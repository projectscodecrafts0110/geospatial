<?php

declare(strict_types=1);

mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);
$database = getenv('DB_NAME') ?: 'geo_case_test';
if (!str_ends_with($database, '_test')) exit("Refusing Phase 1 tests against non-test database.\n");

$conn = new mysqli(getenv('DB_HOST') ?: '127.0.0.1', getenv('DB_USER') ?: 'root', getenv('DB_PASS') ?: '', $database, (int) (getenv('DB_PORT') ?: 3307));
$conn->set_charset('utf8mb4');
require_once __DIR__ . '/../includes/real_data_normalization.php';

$assertions = 0;
function check(bool $condition, string $message): void
{
    global $assertions;
    if (!$condition) throw new RuntimeException($message);
    $assertions++;
}

check($conn->query("SELECT DATABASE()")->fetch_row()[0] === 'geo_case_test', 'Production database guard failed.');
check((int) $conn->query("SELECT COUNT(*) FROM ip_affiliations")->fetch_row()[0] === 6, 'Canonical affiliations were not installed.');
check((int) $conn->query("SELECT COUNT(*) FROM ip_affiliations WHERE name IN ('Isnag','Isneg','Itneg')")->fetch_row()[0] === 3, 'Near-spelling affiliations were merged.');
check(normalize_source_sex(' Famale ') === 'Female', 'Sex normalization failed.');
check(normalize_source_suffix('sr') === 'Sr.', 'Suffix normalization failed.');
check(normalize_source_text(' n/a ') === null, 'Missing-value normalization failed.');
check(parse_source_date('21/03/1977') === '1977-03-21', 'Date normalization failed.');
check(parse_source_date('03/04/1977', 'm/d/Y') === '1977-03-04', 'Explicit date format handling failed.');

$before = [];
foreach (['ip_records','case_applications','ip_land_parcels','user_tribes'] as $table) {
    $before[$table] = (int) $conn->query("SELECT COUNT(*) FROM `$table`")->fetch_row()[0];
}

$conn->begin_transaction();
try {
    $adminId = (int) $conn->query("SELECT id FROM users WHERE username='admin_test'")->fetch_row()[0];
    $affiliationId = (int) $conn->query("SELECT id FROM ip_affiliations WHERE code='yapayao'")->fetch_row()[0];
    $hash = hash('sha256', 'fictional-phase-1-source');
    $stmt = $conn->prepare("INSERT INTO import_batches (source_type,source_name,source_hash,status,created_by) VALUES ('ip_family_workbook','fictional-test.xlsx',?,'validated',?)");
    $stmt->bind_param('si', $hash, $adminId); $stmt->execute(); $batchId = $conn->insert_id;

    $stmt = $conn->prepare("INSERT INTO ip_families (family_reference,affiliation_id,owning_tribe,import_batch_id,source_reference,created_by) VALUES ('FAM-TEST-001',?,'Test Tribe',?,'ROW-001',?)");
    $stmt->bind_param('iii', $affiliationId, $batchId, $adminId); $stmt->execute(); $familyId = $conn->insert_id;
    check((int) $conn->query("SELECT COUNT(*) FROM ip_family_members WHERE family_id=$familyId")->fetch_row()[0] === 0, 'Spouse/member was created implicitly.');

    $stmt = $conn->prepare("INSERT INTO ip_family_members (family_id,member_role,last_name,first_name,sex,birthdate) VALUES (?,'head','Dalisay','Amihan','Female',NULL)");
    $stmt->bind_param('i', $familyId); $stmt->execute(); $headId = $conn->insert_id;
    check((int) $conn->query("SELECT COUNT(*) FROM ip_family_members WHERE family_id=$familyId AND member_role='head'")->fetch_row()[0] === 1, 'Head member was not created.');
    check($conn->query("SELECT birthdate FROM ip_family_members WHERE id=$headId")->fetch_row()[0] === null, 'Nullable birthday was not preserved.');

    $stmt = $conn->prepare("INSERT INTO ip_family_members (family_id,member_role,last_name,first_name) VALUES (?,'spouse','Dalisay','Luntian')");
    $stmt->bind_param('i', $familyId); $stmt->execute();
    check((int) $conn->query("SELECT COUNT(*) FROM ip_family_members WHERE family_id=$familyId")->fetch_row()[0] === 2, 'Head and spouse relationship failed.');

    $duplicateBlocked = false;
    try {
        $conn->query("INSERT INTO ip_families (import_batch_id,source_reference) VALUES ($batchId,'ROW-001')");
    } catch (mysqli_sql_exception $e) {
        $duplicateBlocked = $e->getCode() === 1062;
    }
    check($duplicateBlocked, 'Duplicate batch/source reference was not blocked.');

    $conn->query("UPDATE ip_records SET family_member_id=$headId, affiliation_id=$affiliationId WHERE reference_code='IP-TEST-001'");
    check((int) $conn->query("SELECT COUNT(*) FROM ip_records WHERE reference_code='IP-TEST-001' AND family_member_id=$headId")->fetch_row()[0] === 1, 'Existing IP compatibility link failed.');
    check((int) $conn->query("SELECT COUNT(*) FROM case_applications WHERE case_title='Test Case'")->fetch_row()[0] === 1, 'Existing case was affected.');
    check((int) $conn->query("SELECT COUNT(*) FROM ip_land_parcels WHERE land_name='Test Land'")->fetch_row()[0] === 1, 'Existing GIS parcel was affected.');
    check((int) $conn->query("SELECT COUNT(*) FROM user_tribes WHERE tribe='Test Tribe'")->fetch_row()[0] === 2, 'Existing tribe authorization data was affected.');
} finally {
    $conn->rollback();
}

foreach ($before as $table => $count) check((int) $conn->query("SELECT COUNT(*) FROM `$table`")->fetch_row()[0] === $count, "$table changed after rollback.");
echo "Phase 1 foundation tests passed: $assertions assertions.\n";
