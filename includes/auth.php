<?php
require_once __DIR__ . '/security.php';
start_secure_session();

if (!isset($_SESSION['user_id'])) {
    header("Location: ../../login.php");
    exit();
}
