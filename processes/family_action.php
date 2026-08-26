<?php
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin','staff','tribe_leader','tribe_rep']);
require_csrf();
require '../includes/db.php';
require 'audit.php';
require_once '../includes/real_data_normalization.php';
require_once '../includes/family_access.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); exit('Method not allowed.'); }
$id = (int) ($_POST['id'] ?? 0);
$existing = $id ? require_family_access($conn, $id) : null;
$affiliationId = (int) ($_POST['affiliation_id'] ?? 0) ?: null;
if ($affiliationId !== null) {
    $stmt=$conn->prepare("SELECT COUNT(*) FROM ip_affiliations WHERE id=? AND status='active'"); $stmt->bind_param('i',$affiliationId); $stmt->execute();
    if ((int)$stmt->get_result()->fetch_row()[0] !== 1) { header('Location: ../auth/families.php?error=invalid_affiliation'); exit; }
}
$owningTribe = family_owning_tribe($conn, $_POST['owning_tribe'] ?? null);
if ($owningTribe === null) { header('Location: ../auth/families.php?error=ownership_required'); exit; }
$head = family_person_payload('head'); $spouse = family_person_payload('spouse');
if ($head['first_name'] === null || $head['last_name'] === null) { header('Location: ../auth/families.php?error=head_required'); exit; }

$fields=['region','province','municipality_city','barangay','house_number','sitio_street','contact_number','id_type','id_number','remarks'];
$family=[]; foreach($fields as $field) $family[$field]=normalize_source_text($_POST[$field]??null);
$conn->begin_transaction();
try {
    if ($existing) {
        $stmt=$conn->prepare('UPDATE ip_families SET affiliation_id=?,owning_tribe=?,region=?,province=?,municipality_city=?,barangay=?,house_number=?,sitio_street=?,contact_number=?,id_type=?,id_number=?,remarks=?,updated_by=? WHERE id=?');
        $userId=(int)$_SESSION['user_id'];
        $stmt->bind_param('isssssssssssii',$affiliationId,$owningTribe,$family['region'],$family['province'],$family['municipality_city'],$family['barangay'],$family['house_number'],$family['sitio_street'],$family['contact_number'],$family['id_type'],$family['id_number'],$family['remarks'],$userId,$id); $stmt->execute();
    } else {
        $reference='FAM-'.date('Y').'-'.strtoupper(bin2hex(random_bytes(4))); $userId=(int)$_SESSION['user_id'];
        $stmt=$conn->prepare('INSERT INTO ip_families (family_reference,affiliation_id,owning_tribe,region,province,municipality_city,barangay,house_number,sitio_street,contact_number,id_type,id_number,remarks,created_by,updated_by) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)');
        $stmt->bind_param('sisssssssssssii',$reference,$affiliationId,$owningTribe,$family['region'],$family['province'],$family['municipality_city'],$family['barangay'],$family['house_number'],$family['sitio_street'],$family['contact_number'],$family['id_type'],$family['id_number'],$family['remarks'],$userId,$userId); $stmt->execute(); $id=$conn->insert_id;
    }
    $changes=[];
    foreach(['head'=>$head,'spouse'=>$spouse] as $role=>$person) {
        $old=family_member($conn,$id,$role);
        if ($role==='spouse' && family_person_is_empty($person)) {
            if ($old) { $stmt=$conn->prepare("DELETE FROM ip_family_members WHERE id=?"); $stmt->bind_param('i',$old['id']); $stmt->execute(); $changes[]='spouse removed'; }
            continue;
        }
        if ($old) {
            $stmt=$conn->prepare('UPDATE ip_family_members SET last_name=?,first_name=?,middle_name=?,suffix=?,sex=?,birthdate=? WHERE id=?');
            $stmt->bind_param('ssssssi',$person['last_name'],$person['first_name'],$person['middle_name'],$person['suffix'],$person['sex'],$person['birthdate'],$old['id']); $stmt->execute(); $changes[]="$role changed";
        } else {
            $stmt=$conn->prepare('INSERT INTO ip_family_members (family_id,member_role,last_name,first_name,middle_name,suffix,sex,birthdate) VALUES (?,?,?,?,?,?,?,?)');
            $stmt->bind_param('isssssss',$id,$role,$person['last_name'],$person['first_name'],$person['middle_name'],$person['suffix'],$person['sex'],$person['birthdate']); $stmt->execute(); $changes[]="$role added";
        }
    }
    $conn->commit();
    log_action($conn,$existing?'UPDATE_FAMILY':'CREATE_FAMILY','ip_families',$id,($existing?'Updated':'Created').' family record; fields: '.implode(', ',$changes));
    header("Location: ../auth/families/view.php?id=$id&saved=1");
} catch(Throwable $e) { $conn->rollback(); error_log('Family save failed: '.$e->getMessage()); header('Location: ../auth/families.php?error=save_failed'); }
