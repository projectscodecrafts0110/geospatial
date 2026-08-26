<?php

require '../includes/db.php';
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin', 'tribe_leader', 'tribe_rep', 'assessor', 'staff']);

$attachmentId = (int) ($_GET['id'] ?? 0);
$download = ($_GET['download'] ?? '') === '1';
if ($attachmentId <= 0) {
    http_response_code(400);
    exit('Invalid attachment.');
}

$stmt = $conn->prepare('SELECT id, case_id, file_name, file_path, file_type FROM case_attachments WHERE id = ? LIMIT 1');
$stmt->bind_param('i', $attachmentId);
$stmt->execute();
$attachment = $stmt->get_result()->fetch_assoc();
if (!$attachment) {
    http_response_code(404);
    exit('Attachment not found.');
}

require_case_access($conn, (int) $attachment['case_id']);

$candidate = attachment_disk_path((string) $attachment['file_path']);
if (!$candidate || !is_file($candidate)) {
    http_response_code(404);
    exit('Attachment file not found.');
}

$allowedTypes = ['image/jpeg', 'image/png', 'application/pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document'];
$type = (new finfo(FILEINFO_MIME_TYPE))->file($candidate);
if (!in_array($type, $allowedTypes, true)) {
    http_response_code(415);
    exit('Unsupported attachment type.');
}

$safeName = preg_replace('/[^A-Za-z0-9._ -]/', '_', basename((string) $attachment['file_name'])) ?: 'attachment';
header('Content-Type: ' . $type);
header('Content-Length: ' . filesize($candidate));
header('Content-Disposition: ' . ($download ? 'attachment' : 'inline') . '; filename="' . addcslashes($safeName, '"\\') . '"');
header('Cache-Control: private, no-store, max-age=0');
readfile($candidate);
exit;
