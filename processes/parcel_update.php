<?php
require '../includes/db.php';
require '../includes/role_guard.php';
session_start();

requireRole(['admin']);
require_csrf();

// INPUTS
$id = isset($_POST['id']) ? (int) $_POST['id'] : 0;

$land_name = mysqli_real_escape_string($conn, $_POST['land_name']);
$owner_name = mysqli_real_escape_string($conn, $_POST['owner_name']);
$status = mysqli_real_escape_string($conn, $_POST['status']);
$reason = mysqli_real_escape_string($conn, $_POST['reason']);

// SESSION DATA
$user_id = $_SESSION['user_id'] ?? null;
$username = $_SESSION['username'] ?? 'unknown';
$role = $_SESSION['role'] ?? 'admin';

// IP ADDRESS
$ip_address = $_SERVER['REMOTE_ADDR'] ?? 'unknown';

// FETCH OLD DATA
$oldQuery = mysqli_query($conn, "SELECT * FROM ip_land_parcels WHERE id=$id");
$old = mysqli_fetch_assoc($oldQuery);

if (!$old) {
    header("Location: ../auth/admin/gis.php?update=error&msg=not_found");
    exit;
}

// UPDATE PARCEL
$updateSql = "
UPDATE ip_land_parcels SET
    land_name='$land_name',
    owner_name='$owner_name',
    ownership_status='$status',
    updated_by='$user_id',
    updated_at=NOW()
WHERE id=$id
";

$update = mysqli_query($conn, $updateSql);

if ($update) {

    // BUILD CHANGE LOG
    $changes = [];

    if ($old['land_name'] !== $_POST['land_name']) {
        $changes[] = "Land Name: '{$old['land_name']}' → '$land_name'";
    }

    if ($old['owner_name'] !== $_POST['owner_name']) {
        $changes[] = "Owner: '{$old['owner_name']}' → '$owner_name'";
    }

    if ($old['ownership_status'] !== $status) {
        $changes[] = "Status: '{$old['ownership_status']}' → '$status'";
    }

    $changeText = !empty($changes) ? implode("; ", $changes) : "No field changes detected";

    $description = mysqli_real_escape_string(
        $conn,
        "GIS Parcel Updated. {$changeText}. Reason: {$reason}"
    );

    // INSERT AUDIT LOG
    $auditSql = "
        INSERT INTO audit_logs (
            user_id,
            username,
            role,
            action,
            module,
            record_id,
            description,
            ip_address
        ) VALUES (
            '$user_id',
            '$username',
            '$role',
            'UPDATE',
            'IP_LAND_PARCELS',
            '$id',
            '$description',
            '$ip_address'
        )
    ";

    mysqli_query($conn, $auditSql);

    header("Location: ../auth/admin/gis.php?update=success");
    exit;
} else {
    header("Location: ../auth/admin/gis.php?update=error");
    exit;
}
