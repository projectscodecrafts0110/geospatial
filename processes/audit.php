<?php

function log_action($conn, $action, $module, $record_id = null, $description = null)
{
    if (session_status() !== PHP_SESSION_ACTIVE) session_start();

    $user_id = $_SESSION['user_id'] ?? null;
    $username = $_SESSION['username'] ?? 'unknown';
    $role = $_SESSION['role'] ?? 'unknown';
    $ip = $_SERVER['REMOTE_ADDR'] ?? '';

    $stmt = $conn->prepare('INSERT INTO audit_logs (user_id, username, role, action, module, record_id, description, ip_address) VALUES (?, ?, ?, ?, ?, ?, ?, ?)');
    $user_id = $user_id !== null ? (int) $user_id : null;
    $record_id = $record_id !== null ? (int) $record_id : null;
    $stmt->bind_param('issssiss', $user_id, $username, $role, $action, $module, $record_id, $description, $ip);
    $stmt->execute();
}
