<?php
require_once '../includes/security.php';
start_secure_session();
require '../includes/db.php';
require 'audit.php';

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    header("Location: ../login.php");
    exit();
}

$username = trim((string) ($_POST['username'] ?? ''));
$password = (string) ($_POST['password'] ?? '');

if (empty($username) || empty($password)) {
    header("Location: ../login.php?error=empty_fields");
    exit();
}

if (login_rate_limited($conn, $username)) {
    header('Retry-After: 900');
    header("Location: ../login.php?error=too_many_attempts");
    exit();
}

/* Secure query */
$stmt = $conn->prepare("SELECT id, username, password, role, status FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();

$result = $stmt->get_result();

if ($result->num_rows === 0) {
    record_login_failure($conn, $username);
    header("Location: ../login.php?error=invalid_credentials");
    exit();
}

$user = $result->fetch_assoc();

/* check if account is active */
if ($user['status'] !== 'active') {
    record_login_failure($conn, $username);
    header("Location: ../login.php?error=inactive_account");
    exit();
}

/* verify password */
if (!password_verify($password, $user['password'])) {
    record_login_failure($conn, $username);
    header("Location: ../login.php?error=invalid_credentials");
    exit();
}

/* SUCCESS: create session */
clear_login_failures($conn, $username);
session_regenerate_id(true);
$_SESSION['user_id'] = $user['id'];
$_SESSION['username'] = $user['username'];
$_SESSION['role'] = $user['role'];

/* optional: update last login */
$conn->query("UPDATE users SET last_login = NOW() WHERE id = {$user['id']}");

/* ROLE ROUTING */
switch ($user['role']) {

    case 'admin':
        log_action(
            $conn,
            "LOGIN",
            "users",
            $user['id'],
            "Admin '{$username}' logged in successfully at " . date("Y-m-d H:i:s")
        );
        header("Location: ../auth/admin/dashboard.php");
        break;

    case 'tribe_leader':
        log_action(
            $conn,
            "LOGIN",
            "users",
            $user['id'],
            "IP Leader '{$username}' logged in successfully at " . date("Y-m-d H:i:s")
        );
        header("Location: ../auth/tribe_leader/dashboard.php");
        break;

    case 'tribe_rep':
        log_action(
            $conn,
            "LOGIN",
            "users",
            $user['id'],
            "IP rep '{$username}' logged in successfully at " . date("Y-m-d H:i:s")
        );
        header("Location: ../auth/tribe_rep/dashboard.php");
        break;

    case 'assessor':
        log_action(
            $conn,
            "LOGIN",
            "users",
            $user['id'],
            "Assessor '{$username}' logged in successfully at " . date("Y-m-d H:i:s")
        );
        header("Location: ../auth/admin/cases.php");
        break;

    case 'staff':
        log_action(
            $conn,
            "LOGIN",
            "users",
            $user['id'],
            "Staff member '{$username}' logged in successfully at " . date("Y-m-d H:i:s")
        );
        header("Location: ../auth/admin/records.php");
        break;

    default:
        session_destroy();
        header("Location: ../login.php?error=invalid_role");
        break;
}

exit();
