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

if (!in_array($role, ['admin', 'staff', 'tribe_leader', 'tribe_rep'], true)) {
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
// CASE ID
// ==========================
$case_id = (int) ($_POST['case_id'] ?? 0);

if ($case_id <= 0) {
    if ($role === 'admin') {
        header("Location: ../auth/admin/cases.php?error=invalid_case");
        exit;
    } else if ($role === 'staff') {
        header("Location: ../auth/admin/cases.php?error=invalid_case");
        exit;
    } else  if ($role === 'tribe_rep') {
        header("Location: ../auth/tribe_rep/cases.php?error=invalid_case");
        exit;
    } else if ($role === 'tribe_leader') {
        header("Location: ../auth/tribe_leader/cases.php?error=invalid_case");
        exit;
    }
}

$existingCase = require_case_access($conn, $case_id);
$oldParticipantCount = (int) $conn->query("SELECT COUNT(*) FROM case_persons_involved WHERE case_id=$case_id")->fetch_row()[0];

// ==========================
// CASE DATA
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
    $applicant_ip_group = clean($conn, current_user_tribe($conn));
}

$rep_name        = clean($conn, $_POST['rep_name']);
$rep_relationship = clean($conn, $_POST['rep_relationship']);
$rep_contact     = clean($conn, $_POST['rep_contact']);

$case_title       = clean($conn, $_POST['case_title']);
$case_type        = clean($conn, $_POST['case_type']);
$caseTypeStmt=$conn->prepare("SELECT id FROM case_types WHERE code=? AND status='active' LIMIT 1");$caseTypeStmt->bind_param('s',$case_type);$caseTypeStmt->execute();$caseTypeRow=$caseTypeStmt->get_result()->fetch_assoc();if(!$caseTypeRow){http_response_code(422);exit('Invalid case type.');}$case_type_id=(int)$caseTypeRow['id'];
$case_type_other  = clean($conn, $_POST['case_type_other']);
$incident_date    = clean($conn, $_POST['incident_date']);

$incident_barangay     = clean($conn, $_POST['incident_barangay']);
$incident_municipality = clean($conn, $_POST['incident_municipality']);
$incident_province     = clean($conn, $_POST['incident_province']);
$incident_location_text = clean($conn, $_POST['incident_location_text'] ?? '');

$case_description = clean($conn, $_POST['case_description']);
$effective_assignment = case_effective_assignment($case_type,(string)$existingCase['status'],(string)($existingCase['assigned_to']??''));

// ==========================
// UPDATE CASE
// ==========================
$updateSql = "UPDATE case_applications SET
    applicant_fullname='$applicant_fullname',
    applicant_gender='$applicant_gender',
    applicant_dob='$applicant_dob',
    applicant_contact='$applicant_contact',
    applicant_email='$applicant_email',
    applicant_address='$applicant_address',
    applicant_ip_group='$applicant_ip_group',
    applicant_affiliation_id=" . ($applicant_affiliation_id ?: 'NULL') . ",

    rep_name='$rep_name',
    rep_relationship='$rep_relationship',
    rep_contact='$rep_contact',

    case_title='$case_title',
    case_type='$case_type',
    case_type_other='$case_type_other',
    case_type_id=$case_type_id,
    incident_date='$incident_date',

    incident_barangay='$incident_barangay',
    incident_municipality='$incident_municipality',
    incident_province='$incident_province',
    incident_location_text='$incident_location_text',

    case_description='$case_description',
    assigned_to='$effective_assignment'
WHERE id = $case_id";

mysqli_query($conn, $updateSql);

// ==========================
// DELETE SELECTED ATTACHMENTS
// ==========================
if (!empty($_POST['delete_attachments'])) {

    $deleteIds = $_POST['delete_attachments'];

    foreach ($deleteIds as $att_id) {

        $att_id = (int) $att_id;

        $res = mysqli_query($conn, "SELECT file_path FROM case_attachments WHERE id=$att_id AND case_id=$case_id");
        $file = mysqli_fetch_assoc($res);

        if ($file) {
            $diskPath = attachment_disk_path((string) $file['file_path']);
            if ($diskPath && file_exists($diskPath)) {
                unlink($diskPath); // delete physical file
            }

            mysqli_query($conn, "DELETE FROM case_attachments WHERE id=$att_id");
        }
    }
}

// ==========================
// ADD NEW ATTACHMENTS
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

            if ($size > 10 * 1024 * 1024) continue;

            $allowed = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'application/pdf' => 'pdf', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => 'docx'];
            $detectedType = (new finfo(FILEINFO_MIME_TYPE))->file($tmpName);
            if (!isset($allowed[$detectedType])) continue;
            $safeName = bin2hex(random_bytes(16)) . "." . $allowed[$detectedType];

            $filePath = $uploadDir . $safeName;

            if (move_uploaded_file($tmpName, $filePath)) {

                $fileType = $detectedType;

                mysqli_query($conn, "INSERT INTO case_attachments (
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
                )");
            }
        }
    }
}

// ==========================
// UPDATE PERSONS INVOLVED
// ==========================

// Remove old records first
mysqli_query(
    $conn,
    "DELETE FROM case_persons_involved WHERE case_id = $case_id"
);

if (!empty($_POST['person_name'])) {

    $names    = $_POST['person_name'];
    $roles    = $_POST['person_role'];
    $contacts = $_POST['person_contact'];
    $affiliations=$_POST['person_affiliation_id']??[];$ipRecords=$_POST['person_ip_record_id']??[];$familyMembers=$_POST['person_family_member_id']??[];$relationships=$_POST['person_relationship']??[];

    foreach ($names as $index => $name) {

        $person_name = clean($conn, $name);
        $person_role = clean($conn, $roles[$index] ?? '');
        $contact     = clean($conn, $contacts[$index] ?? '');
        $person_role=strtolower($person_role);if(!in_array($person_role,['complainant','respondent','witness','representative'],true))continue;$personAffiliation=(int)($affiliations[$index]??0)?:null;$ipRecord=(int)($ipRecords[$index]??0)?:null;$familyMember=(int)($familyMembers[$index]??0)?:null;$relationship=clean($conn,$relationships[$index]??'');

        if (empty($person_name) || empty($person_role)) {
            continue;
        }

        mysqli_query($conn, "
            INSERT INTO case_persons_involved (
                case_id,
                person_name,
                role,
                contact
                ,relationship_to_applicant,affiliation_id,ip_record_id,family_member_id
            ) VALUES (
                $case_id,
                '$person_name',
                '$person_role',
                '$contact'
                ,'$relationship',".($personAffiliation?:'NULL').",".($ipRecord?:'NULL').",".($familyMember?:'NULL')."
            )
        ");
    }
}
if ($rep_name !== '' && empty(array_filter($_POST['person_role'] ?? [], static fn($r) => strtolower((string)$r)==='representative'))) {
    $stmt=$conn->prepare("INSERT INTO case_persons_involved(case_id,person_name,role,relationship_to_applicant,contact) VALUES(?,?,'representative',?,?)");$stmt->bind_param('isss',$case_id,$rep_name,$rep_relationship,$rep_contact);$stmt->execute();
}

// ==========================
// AUDIT LOG
// ==========================
log_action(
    $conn,
    "UPDATE_CASE",
    "case_applications",
    $case_id,
    "Updated case fields: case type" . ($existingCase['case_type'] !== $case_type ? ' changed' : ' retained') . "; participants synchronized from $oldParticipantCount to " . (int) $conn->query("SELECT COUNT(*) FROM case_persons_involved WHERE case_id=$case_id")->fetch_row()[0]
);

// ==========================
// REDIRECT
// ==========================
if ($role === 'admin') {
    header("Location: ../auth/admin/cases/view.php?id=$case_id&update=success");
} else if ($role === 'staff') {
    header("Location: ../auth/admin/cases/view.php?id=$case_id&update=success");
} else  if ($role === 'tribe_rep') {
    header("Location: ../auth/tribe_rep/cases/view.php?id=$case_id&update=success");
} else if ($role === 'tribe_leader') {
    header("Location: ../auth/tribe_leader/cases/view.php?id=$case_id&update=success");
}
exit;
