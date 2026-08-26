<?php

require '../includes/db.php';
require_once '../includes/security.php';
require 'audit.php';
start_secure_session();
require_roles(['admin']);
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}
require_csrf();
ensure_settings_table($conn);

$defaults = ['theme_primary' => '#177135', 'theme_sidebar' => '#163820', 'theme_accent' => '#198754'];
$colors = [];
foreach ($defaults as $key => $default) {
    $value = isset($_POST['reset_theme']) ? $default : (string) ($_POST[$key] ?? '');
    if (!valid_theme_color($value)) {
        header('Location: ../auth/admin/settings.php?error=invalid_color');
        exit;
    }
    $colors[$key] = strtoupper($value);
}

$logoPath = null;
if (isset($_POST['reset_logo'])) {
    $logoPath = 'assets/images/logo.png';
} elseif (isset($_FILES['logo']) && $_FILES['logo']['error'] !== UPLOAD_ERR_NO_FILE) {
    $file = $_FILES['logo'];
    if ($file['error'] !== UPLOAD_ERR_OK || $file['size'] <= 0 || $file['size'] > 2 * 1024 * 1024) {
        header('Location: ../auth/admin/settings.php?error=invalid_logo');
        exit;
    }
    $type = (new finfo(FILEINFO_MIME_TYPE))->file($file['tmp_name']);
    $allowed = ['image/png' => 'png', 'image/jpeg' => 'jpg', 'image/webp' => 'webp'];
    if (!isset($allowed[$type]) || @getimagesize($file['tmp_name']) === false) {
        header('Location: ../auth/admin/settings.php?error=invalid_logo');
        exit;
    }
    $directory = __DIR__ . '/../assets/settings';
    if (!is_dir($directory) && !mkdir($directory, 0750, true)) {
        header('Location: ../auth/admin/settings.php?error=storage');
        exit;
    }
    $name = 'system-logo-' . bin2hex(random_bytes(8)) . '.' . $allowed[$type];
    if (!move_uploaded_file($file['tmp_name'], $directory . '/' . $name)) {
        header('Location: ../auth/admin/settings.php?error=storage');
        exit;
    }
    $logoPath = 'assets/settings/' . $name;
}

$stmt = $conn->prepare('INSERT INTO system_settings (setting_key, setting_value, updated_by) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value), updated_by = VALUES(updated_by)');
$userId = (int) $_SESSION['user_id'];
$conn->begin_transaction();
try {
    foreach ($colors as $key => $value) {
        $stmt->bind_param('ssi', $key, $value, $userId);
        $stmt->execute();
    }
    if ($logoPath !== null) {
        $key = 'logo_path';
        $stmt->bind_param('ssi', $key, $logoPath, $userId);
        $stmt->execute();
    }
    $conn->commit();
} catch (Throwable $error) {
    $conn->rollback();
    error_log('Settings update failed: ' . $error->getMessage());
    header('Location: ../auth/admin/settings.php?error=database');
    exit;
}

log_action($conn, 'UPDATE_SETTINGS', 'system_settings', null, 'Updated system logo/theme settings');
header('Location: ../auth/admin/settings.php?update=success');
exit;
