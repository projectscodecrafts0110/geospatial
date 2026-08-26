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

// Only administrators and assigned tribe users can create cases.
if (!in_array($role, ['admin', 'tribe_leader', 'tribe_rep'], true)) {
    header("Location: ../auth/403.php");
    exit;
}

// ==========================
// CLEAN FUNCTION
// ==========================
function clean($conn, $val)
{
    return mysqli_real_escape_string($conn, trim($val ?? ''));
}

// ==========================
// APPLICANT INFO
// ==========================
$applicant_fullname  = clean($conn, $_POST['applicant_fullname']);
$applicant_gender    = clean($conn, $_POST['applicant_gender']);
$applicant_dob       = clean($conn, $_POST['applicant_dob']);
$applicant_contact   = clean($conn, $_POST['applicant_contact']);
$applicant_email     = clean($conn, $_POST['applicant_email']);
$applicant_address   = clean($conn, $_POST['applicant_address']);
$applicant_ip_group  = clean($conn, $_POST['applicant_ip_group']);
$applicant_affiliation_id = (int) ($_POST['applicant_affiliation_id'] ?? 0) ?: null;
if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
    $assignedTribe = current_user_tribe($conn);
    if (!$assignedTribe) {
        http_response_code(403);
        exit('No tribe is assigned to this account.');
    }
    $applicant_ip_group = clean($conn, $assignedTribe);
}

// ==========================
// REPRESENTATIVE INFO
// ==========================
$rep_name        = clean($conn, $_POST['rep_name']);
$rep_relationship = clean($conn, $_POST['rep_relationship']);
$rep_contact     = clean($conn, $_POST['rep_contact']);

// ==========================
// CASE INFO
// ==========================
$case_title       = clean($conn, $_POST['case_title']);
$case_type        = clean($conn, $_POST['case_type']);
$caseTypeStmt = $conn->prepare("SELECT id,code FROM case_types WHERE code=? AND status='active' LIMIT 1");
$caseTypeStmt->bind_param('s',$case_type); $caseTypeStmt->execute(); $caseTypeRow=$caseTypeStmt->get_result()->fetch_assoc();
if (!$caseTypeRow) { header('Location: ../auth/admin/cases.php?create=error&msg=invalid_type'); exit; }
$case_type_id = (int) $caseTypeRow['id'];
$case_type_other  = clean($conn, $_POST['case_type_other']);
$incident_date    = clean($conn, $_POST['incident_date']);

$incident_barangay     = clean($conn, $_POST['incident_barangay']);
$incident_municipality = clean($conn, $_POST['incident_municipality']);
$incident_province     = clean($conn, $_POST['incident_province']);
$incident_location_text = clean($conn, $_POST['incident_location_text'] ?? '');

$case_description = clean($conn, $_POST['case_description']);

// ==========================
// SYSTEM VALUES
// ==========================
$status = "pending";
$assigned_to = NULL;

// ==========================
// CASE REFERENCE
// ==========================
$case_reference = "CASE-" . date("Y") . "-" . strtoupper(substr(uniqid(), -6));

// ==========================
// Initial routing by the existing case type workflow.
// ==========================
$assigned_to = case_initial_assignment($case_type);

// ==========================
// INSERT CASE
// ==========================
$sql = "INSERT INTO case_applications (
    applicant_fullname,
    applicant_gender,
    applicant_dob,
    applicant_contact,
    applicant_email,
    applicant_address,
    applicant_ip_group,
    applicant_affiliation_id,

    rep_name,
    rep_relationship,
    rep_contact,

    case_title,
    case_type,
    case_type_other,
    case_type_id,
    incident_date,

    incident_barangay,
    incident_municipality,
    incident_province,
    incident_location_text,

    case_description,
    status,
    created_by,
    assigned_to
) VALUES (
    '$applicant_fullname',
    '$applicant_gender',
    '$applicant_dob',
    '$applicant_contact',
    '$applicant_email',
    '$applicant_address',
    '$applicant_ip_group',
    " . ($applicant_affiliation_id ?: 'NULL') . ",

    '$rep_name',
    '$rep_relationship',
    '$rep_contact',

    '$case_title',
    '$case_type',
    '$case_type_other',
    $case_type_id,
    '$incident_date',

    '$incident_barangay',
    '$incident_municipality',
    '$incident_province',
    '$incident_location_text',

    '$case_description',
    '$status',
    '$user_id',
    " . ($assigned_to ? "'$assigned_to'" : "NULL") . "
)";

$result = mysqli_query($conn, $sql);

// ==========================
// AFTER INSERT
// ==========================
if ($result) {

    $case_id = mysqli_insert_id($conn);

    // ==========================
    // HANDLE ATTACHMENTS
    // ==========================
    if (!empty($_FILES['attachments']['name'][0])) {

        $uploadDir = "../uploads/case_attachments/";

        if (!is_dir($uploadDir)) {
            mkdir($uploadDir, 0750, true);
        }

        foreach ($_FILES['attachments']['name'] as $key => $fileName) {

            $tmpName = $_FILES['attachments']['tmp_name'][$key];
            $error   = $_FILES['attachments']['error'][$key];
            $size    = $_FILES['attachments']['size'][$key];

            if ($error === 0) {

                // limit: 10MB
                if ($size > 10 * 1024 * 1024) continue;

                $allowed = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'application/pdf' => 'pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'docx'];
                $detectedType = (new finfo(FILEINFO_MIME_TYPE))->file($tmpName);
                if (!isset($allowed[$detectedType])) continue;
                $safeName = bin2hex(random_bytes(16)) . "." . $allowed[$detectedType];

                $filePath = $uploadDir . $safeName;

                if (move_uploaded_file($tmpName, $filePath)) {

                    $fileType = $detectedType;

                    $sqlAttach = "INSERT INTO case_attachments (
                        case_id,
                        file_name,
                        file_path,
                        file_type,
                        uploaded_by
                    ) VALUES (
                        $case_id,
                        '$fileName',
                        '$filePath',
                        '$fileType',
                        $user_id
                    )";

                    mysqli_query($conn, $sqlAttach);
                }
            }
        }
    }

    // ==========================
    // HANDLE PERSONS INVOLVED
    // ==========================
    if (!empty($_POST['person_name'])) {

        $names    = $_POST['person_name'];
        $roles    = $_POST['person_role'];
        $contacts = $_POST['person_contact'];
        $affiliations = $_POST['person_affiliation_id'] ?? [];
        $ipRecords = $_POST['person_ip_record_id'] ?? [];
        $familyMembers = $_POST['person_family_member_id'] ?? [];
        $relationships = $_POST['person_relationship'] ?? [];

        foreach ($names as $index => $name) {

            $person_name = clean($conn, $name);
            $role        = clean($conn, $roles[$index] ?? '');
            $contact     = clean($conn, $contacts[$index] ?? '');
            $personAffiliation=(int)($affiliations[$index]??0)?:null;$ipRecord=(int)($ipRecords[$index]??0)?:null;$familyMember=(int)($familyMembers[$index]??0)?:null;$relationship=clean($conn,$relationships[$index]??'');
            $role = strtolower($role);
            if(!in_array($role,['complainant','respondent','witness','representative'],true))continue;

            if (empty($person_name) || empty($role)) {
                continue;
            }

            $sqlPerson = "INSERT INTO case_persons_involved (
            case_id,
            person_name,
            role,
            contact
            ,relationship_to_applicant,affiliation_id,ip_record_id,family_member_id
        ) VALUES (
            $case_id,
            '$person_name',
            '$role',
            '$contact'
            ,'$relationship',".($personAffiliation?:'NULL').",".($ipRecord?:'NULL').",".($familyMember?:'NULL')."
        )";

            mysqli_query($conn, $sqlPerson);
        }
    }
    if ($rep_name !== '' && empty(array_filter($_POST['person_role'] ?? [], static fn($r) => strtolower((string)$r)==='representative'))) {
        $stmt=$conn->prepare("INSERT INTO case_persons_involved(case_id,person_name,role,relationship_to_applicant,contact) VALUES(?,?,'representative',?,?)");
        $stmt->bind_param('isss',$case_id,$rep_name,$rep_relationship,$rep_contact);$stmt->execute();
    }

    // ==========================
    // AUDIT LOG
    // ==========================
    log_action(
        $conn,
        "CREATE_CASE",
        "case_applications",
        $case_id,
        "Created case record | Type: $case_type | Participants captured: " . count(array_filter($_POST['person_name'] ?? []))
    );

    if ($_SESSION['role'] === 'admin') {
        header("Location: ../auth/admin/cases.php?create=success");
        exit;
    } else if ($_SESSION['role'] === 'tribe_leader') {
        header("Location: ../auth/tribe_leader/cases.php?create=success");
        exit;
    } else if ($_SESSION['role'] === 'tribe_rep') {
        header("Location: ../auth/tribe_rep/cases.php?create=success");
        exit;
    }
}

// ==========================
// ERROR
// ==========================
$targetRole = in_array($role, ['tribe_leader', 'tribe_rep'], true) ? $role : 'admin';
header("Location: ../auth/$targetRole/cases/create.php?create=error&msg=db_fail");
exit;
