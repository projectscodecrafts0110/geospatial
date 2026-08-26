<?php

require '../includes/db.php';
require 'audit.php';

require_once '../includes/security.php';
require_once '../includes/case_workflow.php';
start_secure_session();
require_csrf();

require_roles(['admin', 'tribe_leader']);

$case_id = (int)($_POST['case_id'] ?? 0);
$case=require_case_access($conn, $case_id);

$assigned_to = mysqli_real_escape_string(
    $conn,
    $_POST['assigned_to'] ?? ''
);
if (!in_array($assigned_to, ['admin', 'tribe_leader', 'assessor', 'staff'], true)) {
    http_response_code(422);
    exit('Invalid assignment.');
}
$assigned_to=case_effective_assignment((string)$case['case_type'],(string)$case['status'],$assigned_to);

$stmt=$conn->prepare('UPDATE case_applications SET assigned_to=? WHERE id=?');
$stmt->bind_param('si',$assigned_to,$case_id);$stmt->execute();
if ($stmt->affected_rows < 0) { http_response_code(500); exit('Case assignment could not be saved.'); }

log_action(
    $conn,
    "ASSIGN_CASE",
    "case_applications",
    $case_id,
    "Assigned case to role: $assigned_to"
);

if ($_SESSION['role'] === 'admin') {
    header("Location: ../auth/admin/cases/view.php?id=$case_id");
} else if ($_SESSION['role'] === 'tribe_leader') {
    header("Location: ../auth/tribe_leader/cases.php?update_assignee=success");
}
exit;
