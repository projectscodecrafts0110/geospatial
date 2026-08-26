<?php
require_once '../includes/security.php';
start_secure_session();
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}
require_csrf();
$_SESSION = [];
session_destroy();
header("Location: ../login.php");
exit();
