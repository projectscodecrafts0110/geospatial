<?php
if (isset($conn) && $conn instanceof mysqli) {
    return;
}
$host = getenv('DB_HOST') ?: "localhost";
$port = (int) (getenv('DB_PORT') ?: 3307);
$db   = getenv('DB_NAME') ?: "geo_case";
$user = getenv('DB_USER') ?: "root";
$pass = getenv('DB_PASS') !== false ? getenv('DB_PASS') : "";
$charset = "utf8mb4";

$conn = new mysqli($host, $user, $pass, $db, $port);

if ($conn->connect_error) {
    error_log("Database connection failed: " . $conn->connect_error);
    http_response_code(503);
    exit("The service is temporarily unavailable.");
}

$conn->set_charset($charset);
