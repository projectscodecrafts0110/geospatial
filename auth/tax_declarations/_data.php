<?php
$scope=tax_scope($conn);$scopeSql=$scope!==null?" WHERE owning_tribe='".$conn->real_escape_string($scope)."'":'';
$types=$conn->query("SELECT id,name FROM property_types WHERE status='active' ORDER BY name")->fetch_all(MYSQLI_ASSOC);
$parcels=$conn->query('SELECT id,land_name FROM ip_land_parcels ORDER BY land_name')->fetch_all(MYSQLI_ASSOC);
$previousDeclarations=$conn->query("SELECT id,td_number FROM tax_declarations$scopeSql ORDER BY td_number")->fetch_all(MYSQLI_ASSOC);
$tribes=[];$r=$conn->query("SELECT DISTINCT tribe FROM user_tribes WHERE tribe<>'' UNION SELECT DISTINCT tribe FROM ip_records WHERE tribe<>'' ORDER BY tribe");while($x=$r->fetch_row())$tribes[]=$x[0];
$ipWhere=$scope!==null?" WHERE tribe='".$conn->real_escape_string($scope)."'":'';$ipOwners=$conn->query("SELECT id,full_name FROM ip_records$ipWhere ORDER BY full_name")->fetch_all(MYSQLI_ASSOC);
$famWhere=$scope!==null?" WHERE f.owning_tribe='".$conn->real_escape_string($scope)."'":'';$familyOwners=$conn->query("SELECT f.id,f.family_reference FROM ip_families f$famWhere ORDER BY f.family_reference")->fetch_all(MYSQLI_ASSOC);
$memberOwners=$conn->query("SELECT m.id,CONCAT_WS(' ',m.first_name,m.middle_name,m.last_name,m.suffix) display_name FROM ip_family_members m JOIN ip_families f ON f.id=m.family_id$famWhere ORDER BY display_name")->fetch_all(MYSQLI_ASSOC);
$caseWhere=$scope!==null?" WHERE applicant_ip_group='".$conn->real_escape_string($scope)."'":'';$cases=$conn->query("SELECT id,case_title FROM case_applications$caseWhere ORDER BY case_title")->fetch_all(MYSQLI_ASSOC);
