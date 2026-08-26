<?php
require '../includes/db.php';
require 'audit.php';
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin', 'staff', 'tribe_leader', 'tribe_rep']);
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}
require_csrf();

$role = $_SESSION['role'] ?? '';

if (isset($_POST['update_record'])) {

    $id = (int) $_POST['id'];

    // FETCH CURRENT RECORD
    $check = mysqli_query($conn, "SELECT * FROM ip_records WHERE id=$id");
    $record = mysqli_fetch_assoc($check);

    if (!$record) {
        header("Location: ../auth/admin/records.php?error=not_found");
        exit;
    }

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true) && current_user_tribe($conn) !== $record['tribe']) {
        http_response_code(403);
        exit('Access denied.');
    }

    // INPUTS
    $full_name = mysqli_real_escape_string($conn, $_POST['full_name']);
    $tribe = mysqli_real_escape_string($conn, $_POST['tribe']);
    $barangay = mysqli_real_escape_string($conn, $_POST['barangay']);
    $municipality = mysqli_real_escape_string($conn, $_POST['municipality']);
    $latitude = mysqli_real_escape_string($conn, $_POST['latitude']);
    $longitude = mysqli_real_escape_string($conn, $_POST['longitude']);

    $changes = [];

    // =========================
    // FIELD CHANGE DETECTION
    // =========================

    if ($record['full_name'] !== $full_name) {
        $changes[] = "Name: {$record['full_name']} → {$full_name}";
    }

    if ($record['tribe'] !== $tribe) {
        $changes[] = "Tribe: {$record['tribe']} → {$tribe}";
    }

    if ($record['barangay'] !== $barangay) {
        $changes[] = "Barangay: {$record['barangay']} → {$barangay}";
    }

    if ($record['municipality'] !== $municipality) {
        $changes[] = "Municipality: {$record['municipality']} → {$municipality}";
    }

    if ($record['latitude'] !== $latitude || $record['longitude'] !== $longitude) {
        $changes[] = "Location updated (lat/lng changed)";
    }

    // =========================
    // BASE SQL
    // =========================

    $sql = "UPDATE ip_records SET
                full_name='$full_name',
                tribe='$tribe',
                barangay='$barangay',
                municipality='$municipality',
                latitude='$latitude',
                longitude='$longitude'";

    // =========================
    // ROLE LOGIC
    // =========================

    if ($role == 'staff' || $role == 'admin') {

        $requestedStatus = (string)($_POST['status'] ?? $record['status']);
        $status = $role === 'admin' && in_array($requestedStatus, ['for_assessment','for_approval','approved','rejected'], true)
            ? mysqli_real_escape_string($conn, $requestedStatus)
            : mysqli_real_escape_string($conn, (string)$record['status']);

        if ($record['status'] !== $status) {
            $changes[] = "Status: {$record['status']} → {$status}";
        }

        $sql .= ", status='$status'";
    }

    if ($role == 'assessor') {
        header("Location: ../auth/admin/records.php?error=unauthorized");
        exit;
    }

    $sql .= " WHERE id=$id";

    // =========================
    // EXECUTE UPDATE
    // =========================

    $result = mysqli_query($conn, $sql);

    if ($result) {

        // =========================
        // SMART AUDIT LOG
        // =========================

        $description = "Updated IP record";

        if (!empty($changes)) {
            $description .= " | Changes: " . implode(", ", $changes);
        } else {
            $description .= " | No field changes detected";
        }

        $description .= " | Role: {$role}";

        log_action(
            $conn,
            "UPDATE",
            "ip_records",
            $id,
            $description
        );

        if (in_array($_SESSION['role'], ['admin', 'staff'], true)) {
            header("Location: ../auth/admin/records/view.php?id=$id&update=success");
        } else if ($_SESSION['role'] === 'tribe_rep') {
            header("Location: ../auth/tribe_rep/records/view.php?id=$id&update=success");
        } else if ($_SESSION['role'] === 'tribe_leader') {
            header("Location: ../auth/tribe_leader/records/view.php?id=$id&update=success");
        }
    } else {
        if (in_array($_SESSION['role'], ['admin', 'staff'], true)) {
            header("Location: ../auth/admin/records/edit.php?id=$id&update=failed");
        } else if ($_SESSION['role'] === 'tribe_rep') {
            header("Location: ../auth/tribe_rep/records/edit.php?id=$id&update=failed");
        }
    }

    exit;
}

// ==========================
// CREATE RECORD
// ==========================
if (isset($_POST['create_record'])) {

    $year = date("Y");

    $reference_code = "IP-$year-" . strtoupper(uniqid());

    $role = $_SESSION['role'] ?? '';

    // Optional: restrict who can create
    if (!in_array($role, ['staff', 'admin', 'tribe_leader', 'tribe_rep'], true)) {
        header("Location: ../auth/admin/records.php?error=unauthorized");
        exit;
    }

    // INPUTS
    $full_name = mysqli_real_escape_string($conn, $_POST['full_name'] ?? '');
    $gender = mysqli_real_escape_string($conn, $_POST['gender'] ?? '');
    $birthdate = mysqli_real_escape_string($conn, $_POST['birthdate'] ?? '');
    $tribe = mysqli_real_escape_string($conn, $_POST['tribe'] ?? '');
    $sitio = mysqli_real_escape_string($conn, $_POST['sitio'] ?? '');
    $barangay = mysqli_real_escape_string($conn, $_POST['barangay'] ?? '');
    $municipality = mysqli_real_escape_string($conn, $_POST['municipality'] ?? '');
    $latitude = mysqli_real_escape_string($conn, $_POST['latitude'] ?? '');
    $longitude = mysqli_real_escape_string($conn, $_POST['longitude'] ?? '');

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $assignedTribe = current_user_tribe($conn);
        if (!$assignedTribe) {
            http_response_code(403);
            exit('No tribe is assigned to this account.');
        }
        $tribe = mysqli_real_escape_string($conn, $assignedTribe);
    }

    // DEFAULT STATUS ON CREATION
    $status = 'for_assessment';

    // VALIDATION (basic)
    if (empty($full_name) || empty($tribe) || empty($barangay) || empty($municipality)) {
        header("Location: ../auth/admin/records.php?create=error&msg=invalid_input");
        exit;
    }

    // INSERT QUERY
    $sql = "INSERT INTO ip_records (
                reference_code,
                full_name,
                gender,
                birthdate,
                tribe,
                sitio,
                barangay,
                municipality,
                latitude,
                longitude,
                status,
                created_by,
                created_at
            ) VALUES (
                '$reference_code',
                '$full_name',
                '$gender',
                '$birthdate',
                '$tribe',
                '$sitio',
                '$barangay',
                '$municipality',
                '$latitude',
                '$longitude',
                '$status',
                " . (int) $_SESSION['user_id'] . ",
                NOW()
            )";

    $result = mysqli_query($conn, $sql);

    if ($result) {

        $newId = mysqli_insert_id($conn);

        // AUDIT LOG
        log_action(
            $conn,
            "CREATE",
            "ip_records",
            $newId,
            "Created IP record for {$full_name} | Tribe: {$tribe} | Status: {$status}"
        );

        if (in_array($_SESSION['role'], ['admin', 'staff'], true)) {
            header("Location: ../auth/admin/records/view.php?id=$newId&create=success");
        } else if ($_SESSION['role'] === 'tribe_leader') {
            header("Location: ../auth/tribe_leader/records/view.php?id=$newId&create=success");
        } else  if ($_SESSION['role'] === 'tribe_rep') {
            header("Location: ../auth/tribe_rep/records/view.php?id=$newId&create=success");
        }
    } else {
        if (in_array($_SESSION['role'], ['admin', 'staff'], true)) {
            header("Location: ../auth/admin/records.php?create=error&msg=db_fail");
        } else if ($_SESSION['role'] === 'tribe_leader') {
            header("Location: ../auth/tribe_leader/records.php?create=error&msg=db_fail");
        } else  if ($_SESSION['role'] === 'tribe_rep') {
            header("Location: ../auth/tribe_rep/records.php?create=error&msg=db_fail");
        }
    }

    exit;
}
