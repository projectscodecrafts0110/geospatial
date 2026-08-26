<?php
require '../includes/db.php';
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin', 'tribe_leader', 'tribe_rep']);
require_csrf();

if (!isset($_SESSION['user_id'])) {
    header("Location: ../login.php");
    exit;
}

$id = (int) ($_POST['id'] ?? 0);
$case_id = (int) ($_POST['case_id'] ?? 0);
require_case_access($conn, $case_id);

if ($id > 0) {

    // get file
    $sql = "SELECT file_path FROM case_attachments WHERE id = $id AND case_id = $case_id LIMIT 1";
    $res = mysqli_query($conn, $sql);
    $file = mysqli_fetch_assoc($res);

    if ($file) {

        $fullPath = attachment_disk_path((string) $file['file_path']);

        // delete file from server
        if ($fullPath && file_exists($fullPath)) {
            unlink($fullPath);
        }

        // delete db record
        mysqli_query($conn, "DELETE FROM case_attachments WHERE id = $id");
    }
}

$target = match ($_SESSION['role'] ?? '') {
    'tribe_leader' => 'tribe_leader',
    'tribe_rep' => 'tribe_rep',
    default => 'admin',
};
header("Location: ../auth/$target/cases/view.php?id=$case_id&attachment=deleted");
exit;
