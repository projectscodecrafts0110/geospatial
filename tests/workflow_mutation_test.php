<?php
declare(strict_types=1);
$db=getenv('DB_NAME')?:'geo_case_test';if(!str_ends_with($db,'_test'))exit("Refusing workflow mutation tests against non-test database.\n");
$conn=new mysqli('127.0.0.1','root','',$db,3307);$conn->set_charset('utf8mb4');
require_once __DIR__.'/../includes/record_workflow.php';require_once __DIR__.'/../includes/case_workflow.php';
$n=0;function workflow_ok(bool $value,string $label):void{global$n;if(!$value)throw new RuntimeException("FAIL: $label");$n++;echo"PASS: $label\n";}
$admin=(int)$conn->query("SELECT id FROM users WHERE role='admin' LIMIT 1")->fetch_row()[0];
$conn->begin_transaction();
try{
    $conn->query("INSERT INTO ip_records(reference_code,full_name,tribe,barangay,municipality,status,created_by)VALUES('WF-RECORD-001','Workflow Person','Test Tribe','Test Barangay','Test Municipality','for_assessment',$admin)");$record=(int)$conn->insert_id;
    workflow_ok(record_transition_allowed('staff','for_assessment','for_approval'),'staff can submit assessed registry record');
    workflow_ok(!record_transition_allowed('staff','for_assessment','approved'),'staff cannot approve registry record');
    workflow_ok(!record_transition_allowed('admin','for_assessment','approved'),'administrator decision requires for-approval stage');
    $conn->query("UPDATE ip_records SET status='for_approval' WHERE id=$record");
    workflow_ok(record_transition_allowed('admin','for_approval','rejected'),'administrator can reject reviewed registry record');
    $conn->query("UPDATE ip_records SET status='rejected' WHERE id=$record");
    workflow_ok(record_transition_allowed('tribe_leader','rejected','for_approval'),'corrected rejected record can be resubmitted');
    $conn->query("UPDATE ip_records SET status='for_approval' WHERE id=$record");
    workflow_ok(record_transition_allowed('admin','for_approval','approved'),'administrator can approve reviewed registry record');
    $conn->query("UPDATE ip_records SET status='approved',approved_by=$admin WHERE id=$record");
    workflow_ok((int)$conn->query("SELECT approved_by FROM ip_records WHERE id=$record")->fetch_row()[0]===$admin,'approval actor persists');

    $type=(int)$conn->query("SELECT id FROM case_types WHERE code='other'")->fetch_row()[0];
    $conn->query("INSERT INTO case_applications(applicant_fullname,applicant_ip_group,case_title,case_type,case_type_id,status,assigned_to,created_by)VALUES('Workflow Applicant','Test Tribe','Workflow Mutation Case','other',$type,'pending','staff',$admin)");$case=(int)$conn->insert_id;
    workflow_ok(case_available_statuses('staff','other','pending')===['pending','ongoing'],'staff UI exposes only current and next case state');
    workflow_ok(!case_status_transition_allowed('staff','other','pending','resolved'),'staff cannot skip case hierarchy');
    workflow_ok(case_status_transition_allowed('staff','other','pending','ongoing'),'staff can begin assigned case handling');
    workflow_ok(!case_status_transition_allowed('assessor','other','pending','ongoing'),'assessor cannot process non-land case');
    workflow_ok(case_initial_assignment('land_dispute')==='assessor','land dispute still enters assessor queue');

    $conn->query("INSERT INTO case_persons_involved(case_id,person_name,role)VALUES($case,'Temporary Participant','witness')");$participant=(int)$conn->insert_id;
    $conn->query("DELETE FROM case_persons_involved WHERE id=$participant AND case_id=$case");
    workflow_ok((int)$conn->query("SELECT COUNT(*) FROM case_persons_involved WHERE id=$participant")->fetch_row()[0]===0,'scoped participant deletion succeeds');

    $aff=(int)$conn->query('SELECT id FROM ip_affiliations LIMIT 1')->fetch_row()[0];
    $conn->query("INSERT INTO ip_families(family_reference,affiliation_id,owning_tribe,created_by)VALUES('WF-FAMILY-001',$aff,'Test Tribe',$admin)");$family=(int)$conn->insert_id;
    $conn->query("INSERT INTO ip_family_members(family_id,member_role,last_name,first_name)VALUES($family,'head','Workflow','Head'),($family,'spouse','Workflow','Spouse')");
    $conn->query("DELETE FROM ip_family_members WHERE family_id=$family AND member_role='spouse'");
    workflow_ok((int)$conn->query("SELECT COUNT(*) FROM ip_family_members WHERE family_id=$family AND member_role='head'")->fetch_row()[0]===1,'optional spouse removal preserves required head');

    $property=(int)$conn->query('SELECT id FROM property_types LIMIT 1')->fetch_row()[0];
    $conn->query("INSERT INTO tax_declarations(td_number,owning_tribe,owner_name,property_type_id,created_by)VALUES('WF-TD-001','Test Tribe','Workflow Owner',$property,$admin)");$tax=(int)$conn->insert_id;
    $conn->query("INSERT INTO tax_declaration_assessments(tax_declaration_id,classification)VALUES($tax,'Temporary')");
    $conn->query("DELETE FROM tax_declaration_assessments WHERE tax_declaration_id=$tax");
    workflow_ok((int)$conn->query("SELECT COUNT(*) FROM tax_declarations WHERE id=$tax")->fetch_row()[0]===1,'assessment-row deletion preserves Tax Declaration');
}finally{$conn->rollback();}
workflow_ok((int)$conn->query("SELECT COUNT(*) FROM ip_records WHERE reference_code='WF-RECORD-001'")->fetch_row()[0]===0,'workflow mutations roll back cleanly');
echo"Workflow mutation assertions passed: $n\n";
