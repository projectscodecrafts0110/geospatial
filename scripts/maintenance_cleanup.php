<?php

declare(strict_types=1);

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/security.php';

$dryRun = in_array('--dry-run', $argv, true);
$loginCutoff = date('Y-m-d H:i:s', time() - 86400);
$logoCutoff = time() - 7 * 86400;

$stmt = $conn->prepare('SELECT COUNT(*) FROM login_attempts WHERE last_attempt_at < ?');
$stmt->bind_param('s', $loginCutoff);
$stmt->execute();
$expiredAttempts = (int) $stmt->get_result()->fetch_row()[0];
if (!$dryRun) {
    $delete = $conn->prepare('DELETE FROM login_attempts WHERE last_attempt_at < ?');
    $delete->bind_param('s', $loginCutoff);
    $delete->execute();
}

$settings = system_settings($conn);
$currentLogo = basename((string) $settings['logo_path']);
$logoDirectory = realpath(__DIR__ . '/../assets/settings');
$obsoleteLogos = [];
if ($logoDirectory) {
    foreach (glob($logoDirectory . DIRECTORY_SEPARATOR . 'system-logo-*') ?: [] as $path) {
        if (!is_file($path) || basename($path) === $currentLogo || filemtime($path) >= $logoCutoff) continue;
        $obsoleteLogos[] = basename($path);
        if (!$dryRun) unlink($path);
    }
}

echo ($dryRun ? 'DRY RUN' : 'CLEANUP COMPLETE') . PHP_EOL;
echo "Expired login-attempt rows: $expiredAttempts" . PHP_EOL;
echo 'Superseded logo files: ' . count($obsoleteLogos) . PHP_EOL;
foreach ($obsoleteLogos as $logo) echo " - $logo" . PHP_EOL;
