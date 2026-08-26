<?php
require '../includes/db.php';
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin']);

header('Content-Type: application/json');

// fetch latest 20 logs
$sql = "SELECT * FROM audit_logs ORDER BY id DESC LIMIT 20";
$result = mysqli_query($conn, $sql);

$logs = [];

while ($row = mysqli_fetch_assoc($result)) {
    $logs[] = $row;
}

echo json_encode($logs);
