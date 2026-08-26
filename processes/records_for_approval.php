<?php
require '../includes/db.php';
require '../includes/role_guard.php';
require_once '../includes/record_workflow.php';
require_once 'audit.php';
session_start();
requireRole(['admin', 'staff', 'tribe_leader']);
require_csrf();

$id = isset($_POST['id']) ? (int) $_POST['id'] : 0;

$stmt = $conn->prepare('SELECT tribe,status FROM ip_records WHERE id = ?');
$stmt->bind_param('i', $id); $stmt->execute(); $row = $stmt->get_result()->fetch_assoc();
if (!$row) { header('Location: ../auth/admin/records.php?error=not_found'); exit; }
if ($_SESSION['role'] === 'tribe_leader') {
    if (current_user_tribe($conn) !== $row['tribe']) {
        http_response_code(403);
        exit('Access denied.');
    }
}
if (!record_transition_allowed((string)$_SESSION['role'],(string)$row['status'],'for_approval')) {
    $base=in_array($_SESSION['role'],['admin','staff'],true)?'admin':'tribe_leader';
    header("Location: ../auth/$base/records/view.php?id=$id&error=invalid_transition"); exit;
}
$stmt=$conn->prepare("UPDATE ip_records SET status='for_approval',approved_by=NULL WHERE id=?");
$stmt->bind_param('i',$id); $stmt->execute();
if ($stmt->affected_rows!==1) { header('Location: ../auth/admin/records.php?error=update_failed'); exit; }
log_action($conn,'SUBMIT_FOR_APPROVAL','ip_records',$id,'Submitted IP record for administrator decision');

if (in_array($_SESSION['role'], ['admin','staff'], true)) {
    header("Location: ../auth/admin/records/view.php?id=$id&success=for_approval");
} else if ($_SESSION['role'] === 'tribe_leader') {
    header("Location: ../auth/tribe_leader/records/view.php?id=$id&success=for_approval");
}
exit;
