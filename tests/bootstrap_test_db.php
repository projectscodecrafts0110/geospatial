<?php

declare(strict_types=1);

$database = 'geo_case_test';
if (!str_ends_with($database, '_test')) exit("Refusing to recreate a non-test database.\n");

$conn = new mysqli('127.0.0.1', 'root', '', '', 3307);
if ($conn->connect_error) throw new RuntimeException($conn->connect_error);
$conn->query("DROP DATABASE IF EXISTS `$database`");
$conn->query("CREATE DATABASE `$database` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci");
$conn->select_db($database);

function runSqlFile(mysqli $conn, string $path): void
{
    $sql = file_get_contents($path);
    if ($sql === false || !$conn->multi_query($sql)) throw new RuntimeException($conn->error ?: "Cannot read $path");
    do {
        if ($result = $conn->store_result()) $result->free();
        if (!$conn->more_results()) break;
    } while ($conn->next_result());
    if ($conn->errno) throw new RuntimeException($conn->error);
}

runSqlFile($conn, __DIR__ . '/../geo-case.sql');
runSqlFile($conn, __DIR__ . '/../database/upgrade_2026_08_security_and_indexes.sql');

$password = password_hash('TestPassword!123', PASSWORD_DEFAULT);
$users = [
    ['admin_test', 'admin', 'Admin Test'],
    ['leader_test', 'tribe_leader', 'Leader Test'],
    ['rep_test', 'tribe_rep', 'Representative Test'],
    ['assessor_test', 'assessor', 'Assessor Test'],
    ['staff_test', 'staff', 'Staff Test'],
];
$stmt = $conn->prepare("INSERT INTO users (username,email,password,role,full_name,status) VALUES (?, ?, ?, ?, ?, 'active')");
foreach ($users as [$username, $role, $name]) {
    $email = $username . '@example.test';
    $stmt->bind_param('sssss', $username, $email, $password, $role, $name);
    $stmt->execute();
    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $id = $conn->insert_id;
        $tribe = 'Test Tribe';
        $tribeStmt = $conn->prepare('INSERT INTO user_tribes (user_id, tribe) VALUES (?, ?)');
        $tribeStmt->bind_param('is', $id, $tribe);
        $tribeStmt->execute();
    }
}

$adminId = (int) $conn->query("SELECT id FROM users WHERE username='admin_test'")->fetch_row()[0];
$conn->query("INSERT INTO ip_records (reference_code,full_name,gender,tribe,barangay,municipality,status,created_by) VALUES ('IP-TEST-001','Test Person','Other','Test Tribe','Test Barangay','Test Municipality','for_assessment',$adminId)");
$conn->query("INSERT INTO ip_records (reference_code,full_name,gender,tribe,barangay,municipality,status,created_by) VALUES ('IP-OTHER-001','Hidden Other Person','Other','Other Tribe','Other Barangay','Other Municipality','approved',$adminId)");
$conn->query("INSERT INTO case_applications (applicant_fullname,applicant_ip_group,case_title,case_type,status,created_by,assigned_to) VALUES ('Test Applicant','Test Tribe','Test Case','other','pending',$adminId,'tribe_leader')");
$conn->query("INSERT INTO case_applications (applicant_fullname,applicant_ip_group,case_title,case_type,status,created_by,assigned_to) VALUES ('Land Applicant','Test Tribe','Assessor-routed Land Case','land_dispute','pending',$adminId,'assessor')");
$conn->query("INSERT INTO case_applications (applicant_fullname,applicant_ip_group,case_title,case_type,status,created_by,assigned_to) VALUES ('Hidden Applicant','Other Tribe','Hidden Other Case','other','pending',$adminId,'tribe_leader')");
$conn->query("INSERT INTO ip_land_parcels (land_name,owner_name,ownership_status,created_by) VALUES ('Test Land','Test Owner','claimed',$adminId)");
runSqlFile($conn, __DIR__ . '/../database/upgrade_2026_08_relational_integrity.sql');
runSqlFile($conn, __DIR__ . '/../database/upgrade_2026_08_phase1_real_data_foundation.sql');
runSqlFile($conn, __DIR__ . '/../database/upgrade_2026_08_phase3_case_participants.sql');
runSqlFile($conn, __DIR__ . '/../database/upgrade_2026_08_phase4_tax_declarations.sql');

putenv('DB_NAME=' . $database);
require __DIR__ . '/../scripts/seed_anonymized_families.php';
require __DIR__ . '/../scripts/seed_anonymized_cases.php';
require __DIR__ . '/../scripts/seed_anonymized_tax_declarations.php';
$otherAffiliation = (int) $conn->query("SELECT id FROM ip_affiliations WHERE code='yapayao'")->fetch_row()[0];
$conn->query("INSERT INTO ip_families (family_reference,affiliation_id,owning_tribe,barangay) VALUES ('ANON-HIDDEN-001',$otherAffiliation,'Other Tribe','Hidden Barangay')");
$hiddenFamilyId = $conn->insert_id;
$conn->query("INSERT INTO ip_family_members (family_id,member_role,last_name,first_name) VALUES ($hiddenFamilyId,'head','Private','Hidden')");

echo "Created $database with role fixtures and sample records.\n";
