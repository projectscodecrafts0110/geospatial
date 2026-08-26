<?php

declare(strict_types=1);

function start_secure_session(): void
{
    if (session_status() === PHP_SESSION_ACTIVE) {
        return;
    }

    $secure = !empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off';
    session_set_cookie_params([
        'lifetime' => 0,
        'path' => '/',
        'secure' => $secure,
        'httponly' => true,
        'samesite' => 'Lax',
    ]);
    session_start();

    if (!empty($_SESSION['last_activity']) && time() - (int) $_SESSION['last_activity'] > 1800) {
        session_unset();
        session_destroy();
        session_start();
    }
    $_SESSION['last_activity'] = time();
}

function send_security_headers(): void
{
    if (headers_sent()) {
        return;
    }
    header('X-Content-Type-Options: nosniff');
    header('X-Frame-Options: SAMEORIGIN');
    header('Referrer-Policy: strict-origin-when-cross-origin');
    header('Permissions-Policy: camera=(), microphone=(), geolocation=(self)');
}

function csrf_token(): string
{
    start_secure_session();
    if (empty($_SESSION['csrf_token'])) {
        $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
    }
    return $_SESSION['csrf_token'];
}

function require_csrf(): void
{
    $provided = (string) ($_POST['csrf_token'] ?? $_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
    if ($provided === '' || !hash_equals(csrf_token(), $provided)) {
        http_response_code(403);
        exit('The request could not be verified. Please go back, refresh the page, and try again.');
    }
}

function current_user_tribe(mysqli $conn): ?string
{
    static $tribe = false;
    if ($tribe !== false) {
        return $tribe;
    }
    $userId = (int) ($_SESSION['user_id'] ?? 0);
    $stmt = $conn->prepare('SELECT tribe FROM user_tribes WHERE user_id = ? LIMIT 1');
    $stmt->bind_param('i', $userId);
    $stmt->execute();
    $row = $stmt->get_result()->fetch_assoc();
    $tribe = $row['tribe'] ?? null;
    return $tribe;
}

function require_case_access(mysqli $conn, int $caseId): array
{
    $stmt = $conn->prepare('SELECT * FROM case_applications WHERE id = ? LIMIT 1');
    $stmt->bind_param('i', $caseId);
    $stmt->execute();
    $case = $stmt->get_result()->fetch_assoc();
    if (!$case) {
        http_response_code(404);
        exit('Case not found.');
    }
    if (in_array($_SESSION['role'] ?? '', ['tribe_leader', 'tribe_rep'], true)
        && current_user_tribe($conn) !== $case['applicant_ip_group']) {
        http_response_code(403);
        exit('Access denied.');
    }
    $role = $_SESSION['role'] ?? '';
    $userId = (int) ($_SESSION['user_id'] ?? 0);
    if ($role === 'assessor' && $case['assigned_to'] !== 'assessor') {
        http_response_code(403);
        exit('This case is not assigned to the assessor queue.');
    }
    if ($role === 'staff' && $case['assigned_to'] !== 'staff' && (int) $case['created_by'] !== $userId) {
        http_response_code(403);
        exit('This case is not assigned to your support queue.');
    }
    return $case;
}

function login_rate_limit_key(string $username): string
{
    return hash('sha256', strtolower(trim($username)) . '|' . ($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
}

function login_rate_limited(mysqli $conn, string $username): bool
{
    start_secure_session();
    $key = login_rate_limit_key($username);
    try {
        $stmt = $conn->prepare('SELECT attempt_count, window_started_at FROM login_attempts WHERE attempt_key = ?');
        $stmt->bind_param('s', $key);
        $stmt->execute();
        $row = $stmt->get_result()->fetch_assoc();
        if ($row && strtotime($row['window_started_at']) >= time() - 900) return (int) $row['attempt_count'] >= 5;
    } catch (Throwable $ignored) {
        // Fall back to session throttling until the database upgrade is applied.
    }
    $entry = $_SESSION['login_attempts'][$key] ?? ['count' => 0, 'started' => time()];
    if (time() - (int) $entry['started'] > 900) {
        unset($_SESSION['login_attempts'][$key]);
        return false;
    }
    return (int) $entry['count'] >= 5;
}

function record_login_failure(mysqli $conn, string $username): void
{
    start_secure_session();
    $key = login_rate_limit_key($username);
    try {
        $stmt = $conn->prepare("INSERT INTO login_attempts (attempt_key, attempt_count, window_started_at, last_attempt_at)
            VALUES (?, 1, NOW(), NOW()) ON DUPLICATE KEY UPDATE
            attempt_count = IF(window_started_at < DATE_SUB(NOW(), INTERVAL 15 MINUTE), 1, attempt_count + 1),
            window_started_at = IF(window_started_at < DATE_SUB(NOW(), INTERVAL 15 MINUTE), NOW(), window_started_at),
            last_attempt_at = NOW()");
        $stmt->bind_param('s', $key);
        $stmt->execute();
    } catch (Throwable $ignored) {}
    $entry = $_SESSION['login_attempts'][$key] ?? ['count' => 0, 'started' => time()];
    if (time() - (int) $entry['started'] > 900) {
        $entry = ['count' => 0, 'started' => time()];
    }
    $entry['count']++;
    $_SESSION['login_attempts'][$key] = $entry;
}

function clear_login_failures(mysqli $conn, string $username): void
{
    $key = login_rate_limit_key($username);
    unset($_SESSION['login_attempts'][$key]);
    try {
        $stmt = $conn->prepare('DELETE FROM login_attempts WHERE attempt_key = ?');
        $stmt->bind_param('s', $key);
        $stmt->execute();
    } catch (Throwable $ignored) {}
}

function ensure_settings_table(mysqli $conn): void
{
    $conn->query("CREATE TABLE IF NOT EXISTS system_settings (
        setting_key VARCHAR(100) NOT NULL PRIMARY KEY,
        setting_value TEXT NULL,
        updated_by INT NULL,
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci");
}

function system_settings(mysqli $conn): array
{
    $defaults = [
        'logo_path' => 'assets/images/logo.png',
        'theme_primary' => '#177135',
        'theme_sidebar' => '#163820',
        'theme_accent' => '#198754',
    ];
    $result = @$conn->query("SELECT setting_key, setting_value FROM system_settings WHERE setting_key IN ('logo_path','theme_primary','theme_sidebar','theme_accent')");
    while ($result && $row = $result->fetch_assoc()) {
        if (array_key_exists($row['setting_key'], $defaults) && $row['setting_value'] !== '') {
            $defaults[$row['setting_key']] = $row['setting_value'];
        }
    }
    return $defaults;
}

function valid_theme_color(string $color): bool
{
    return preg_match('/^#[0-9A-Fa-f]{6}$/', $color) === 1;
}

function pagination_values(int $total, int $perPage = 25): array
{
    $perPage = max(10, min(100, $perPage));
    $pages = max(1, (int) ceil($total / $perPage));
    $page = max(1, min($pages, (int) ($_GET['page'] ?? 1)));
    return [$page, $perPage, ($page - 1) * $perPage, $pages];
}

function render_pagination(int $page, int $pages): void
{
    if ($pages <= 1) return;
    $query = $_GET;
    echo '<nav aria-label="Pagination"><ul class="pagination justify-content-center mt-3">';
    for ($i = 1; $i <= $pages; $i++) {
        if ($i !== 1 && $i !== $pages && abs($i - $page) > 2) continue;
        $query['page'] = $i;
        $url = '?' . http_build_query($query);
        echo '<li class="page-item ' . ($i === $page ? 'active' : '') . '"><a class="page-link" href="' . e($url) . '">' . $i . '</a></li>';
    }
    echo '</ul></nav>';
}

function attachment_disk_path(string $storedPath): ?string
{
    $root = realpath(__DIR__ . '/../uploads/case_attachments');
    $relative = preg_replace('#^(\.\.[/\\\\])+|^[/\\\\]+#', '', str_replace(['/', '\\'], DIRECTORY_SEPARATOR, $storedPath));
    $candidate = realpath(__DIR__ . '/../' . $relative);
    if (!$root || !$candidate || !str_starts_with($candidate, $root . DIRECTORY_SEPARATOR)) return null;
    return $candidate;
}

function require_login(string $redirect = '../login.php'): void
{
    start_secure_session();
    if (empty($_SESSION['user_id'])) {
        header('Location: ' . $redirect);
        exit;
    }
}

function require_roles(array $roles): void
{
    start_secure_session();
    if (empty($_SESSION['user_id'])) {
        http_response_code(401);
        exit('Authentication required.');
    }
    if (!in_array($_SESSION['role'] ?? '', $roles, true)) {
        http_response_code(403);
        exit('Access denied.');
    }
}

function e($value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

send_security_headers();
