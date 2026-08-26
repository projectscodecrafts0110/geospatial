<?php
require '../includes/db.php';
require_once '../includes/security.php';
require 'audit.php';
start_secure_session();
require_login('../login.php');
if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); exit('Method not allowed.'); }
require_csrf();

$userId = (int) $_SESSION['user_id'];
if (isset($_POST['update_profile'])) {
    $name = trim((string) ($_POST['full_name'] ?? ''));
    $email = trim((string) ($_POST['email'] ?? ''));
    $contact = trim((string) ($_POST['contact_number'] ?? ''));
    if ($name === '' || strlen($name) > 150 || !filter_var($email, FILTER_VALIDATE_EMAIL) || strlen($contact) > 30) {
        header('Location: ../auth/profile.php?error=invalid_profile'); exit;
    }
    $stmt = $conn->prepare('UPDATE users SET full_name = ?, email = ?, contact_number = ? WHERE id = ?');
    $stmt->bind_param('sssi', $name, $email, $contact, $userId);
    try { $stmt->execute(); } catch (mysqli_sql_exception $error) { header('Location: ../auth/profile.php?error=email_exists'); exit; }
    log_action($conn, 'UPDATE_PROFILE', 'users', $userId, 'Updated own profile information');
    header('Location: ../auth/profile.php?update=profile'); exit;
}

if (isset($_POST['change_password'])) {
    $current = (string) ($_POST['current_password'] ?? '');
    $new = (string) ($_POST['new_password'] ?? '');
    $confirm = (string) ($_POST['confirm_password'] ?? '');
    if (strlen($new) < 10 || $new !== $confirm || hash_equals($current, $new)) { header('Location: ../auth/profile.php?error=invalid_password'); exit; }
    $stmt = $conn->prepare('SELECT password FROM users WHERE id = ?'); $stmt->bind_param('i', $userId); $stmt->execute();
    $hash = $stmt->get_result()->fetch_column();
    if (!$hash || !password_verify($current, $hash)) { header('Location: ../auth/profile.php?error=current_password'); exit; }
    $newHash = password_hash($new, PASSWORD_DEFAULT);
    $stmt = $conn->prepare('UPDATE users SET password = ? WHERE id = ?'); $stmt->bind_param('si', $newHash, $userId); $stmt->execute();
    session_regenerate_id(true);
    log_action($conn, 'CHANGE_PASSWORD', 'users', $userId, 'Changed own account password');
    header('Location: ../auth/profile.php?update=password'); exit;
}

http_response_code(400); exit('Unsupported account action.');
