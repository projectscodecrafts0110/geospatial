<?php
require '../includes/db.php';
require '../includes/role_guard.php';
require_once '../includes/record_workflow.php';
require_once 'audit.php';
session_start();
requireRole(['admin']);
require_csrf();

$id = (int) ($_POST['id'] ?? 0);
$stmt = $conn->prepare('SELECT status FROM ip_records WHERE id=?');
$stmt->bind_param('i', $id); $stmt->execute(); $record = $stmt->get_result()->fetch_assoc();
if (!$record) { header('Location: ../auth/admin/records.php?error=not_found'); exit; }
if (!record_transition_allowed('admin', (string)$record['status'], 'approved')) {
    header("Location: ../auth/admin/records/view.php?id=$id&error=invalid_transition"); exit;
}
$stmt = $conn->prepare("UPDATE ip_records SET status='approved',approved_by=? WHERE id=? AND status='for_approval'");
$userId=(int)$_SESSION['user_id']; $stmt->bind_param('ii',$userId,$id); $stmt->execute();
if ($stmt->affected_rows !== 1) { header("Location: ../auth/admin/records/view.php?id=$id&error=update_failed"); exit; }
log_action($conn,'APPROVE','ip_records',$id,'Approved IP record after review');
header("Location: ../auth/admin/records/view.php?id=$id&success=approved");
exit;
