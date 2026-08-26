<?php
require '../includes/db.php';
require 'audit.php';
require_once '../includes/security.php';
require_once '../includes/case_workflow.php';
start_secure_session();
require_csrf();

// ==========================
// SECURITY CHECK
// ==========================
if (!isset($_SESSION['user_id'])) {
    header("Location: ../login.php");
    exit;
}

$user_id = (int) $_SESSION['user_id'];
$role = $_SESSION['role'] ?? '';
$caseBase = $role === 'tribe_leader' ? 'tribe_leader' : 'admin';

// Allowed roles
if (!in_array($role, ['admin', 'tribe_leader', 'assessor', 'staff'])) {
    header("Location: ../auth/403.php");
    exit;
}

// ==========================
// INPUT VALIDATION
// ==========================
$case_id = isset($_POST['case_id']) ? (int) $_POST['case_id'] : 0;
$new_status = trim($_POST['status'] ?? '');

$allowed_status = [
    'pending',
    'ongoing',
    'under_review',
    'resolved',
    'closed'
];

if ($case_id <= 0 || !in_array($new_status, $allowed_status)) {
    header("Location: ../auth/admin/cases.php?error=invalid_input");
    exit;
}

// ==========================
// FETCH CURRENT CASE (for logging)
// ==========================
$check = mysqli_query($conn, "SELECT * FROM case_applications WHERE id = $case_id LIMIT 1");
$case = mysqli_fetch_assoc($check);

if (!$case) {
    header("Location: ../auth/admin/cases.php?error=not_found");
    exit;
}
require_case_access($conn, $case_id);
if(!case_status_transition_allowed($role,(string)$case['case_type'],(string)$case['status'],$new_status)){header("Location: ../auth/$caseBase/cases/view.php?id=$case_id&error=invalid_transition");exit;}

// ==========================
// ROLE-BASED RULES (OPTIONAL CONTROL)
// ==========================

// assessor cannot close cases directly
if ($role === 'assessor' && $new_status === 'closed') {
    header("Location: ../auth/admin/cases.php?error=not_allowed");
    exit;
}

// staff cannot resolve cases directly
if ($role === 'staff' && $new_status === 'resolved') {
    header("Location: ../auth/admin/cases.php?error=not_allowed");
    exit;
}

// ==========================
// UPDATE CASE STATUS
// ==========================
$nextAssignment=case_effective_assignment((string)$case['case_type'],$new_status,(string)($case['assigned_to']??''));
$stmt=$conn->prepare('UPDATE case_applications SET status=?,assigned_to=? WHERE id=? AND status=?');
$oldStatus=(string)$case['status'];$stmt->bind_param('ssis',$new_status,$nextAssignment,$case_id,$oldStatus);$stmt->execute();
$result=$stmt->affected_rows===1 || $new_status===$oldStatus;

// ==========================
// RESULT HANDLING
// ==========================
if ($result) {

    log_action(
        $conn,
        "UPDATE_CASE_STATUS",
        "case_applications",
        $case_id,
        "Status changed from {$case['status']} to {$new_status} by User ID: $user_id ({$role})"
    );

    if (in_array($_SESSION['role'], ['admin', 'assessor', 'staff'], true)) {
        header("Location: ../auth/admin/cases/view.php?id=$case_id&update=success");
        exit;
    } else if ($_SESSION['role'] === 'tribe_leader') {
        header("Location: ../auth/tribe_leader/cases.php?update=success");
    }
} else {

    if (in_array($_SESSION['role'], ['admin', 'assessor', 'staff'], true)) {
        header("Location: ../auth/admin/cases/view.php?id=$case_id&update=error");
        exit;
    } else if ($_SESSION['role'] === 'tribe_leader') {
        header("Location: ../auth/tribe_leader/cases.php?update=error");
    }
}
