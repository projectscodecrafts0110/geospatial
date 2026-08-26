<?php
require '../includes/header.php';
require '../includes/db.php';

$query = trim((string) ($_GET['q'] ?? ''));
$records = $families = $cases = $taxDeclarations = $users = [];
if (mb_strlen($query) >= 2) {
    $like = '%' . $query . '%';
    $role = $_SESSION['role'] ?? '';
    $tribe = current_user_tribe($conn);

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $stmt = $conn->prepare('SELECT id,reference_code,full_name,tribe,barangay,municipality,status FROM ip_records WHERE tribe=? AND (reference_code LIKE ? OR full_name LIKE ? OR barangay LIKE ? OR municipality LIKE ?) ORDER BY id DESC LIMIT 20');
        $stmt->bind_param('sssss', $tribe, $like, $like, $like, $like);
    } else {
        $stmt = $conn->prepare('SELECT id,reference_code,full_name,tribe,barangay,municipality,status FROM ip_records WHERE reference_code LIKE ? OR full_name LIKE ? OR tribe LIKE ? OR barangay LIKE ? OR municipality LIKE ? ORDER BY id DESC LIMIT 20');
        $stmt->bind_param('sssss', $like, $like, $like, $like, $like);
    }
    $stmt->execute(); $records = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $stmt = $conn->prepare("SELECT f.id,f.family_reference,f.barangay,a.name affiliation_name,CONCAT_WS(' ',h.first_name,h.middle_name,h.last_name,h.suffix) head_name FROM ip_families f LEFT JOIN ip_affiliations a ON a.id=f.affiliation_id LEFT JOIN ip_family_members h ON h.family_id=f.id AND h.member_role='head' LEFT JOIN ip_family_members s ON s.family_id=f.id AND s.member_role='spouse' WHERE f.owning_tribe=? AND (h.first_name LIKE ? OR h.last_name LIKE ? OR s.first_name LIKE ? OR s.last_name LIKE ? OR a.name LIKE ? OR f.barangay LIKE ? OR f.sitio_street LIKE ?) ORDER BY f.id DESC LIMIT 20");
        $stmt->bind_param('ssssssss', $tribe, $like, $like, $like, $like, $like, $like, $like);
    } else {
        $stmt = $conn->prepare("SELECT f.id,f.family_reference,f.barangay,a.name affiliation_name,CONCAT_WS(' ',h.first_name,h.middle_name,h.last_name,h.suffix) head_name FROM ip_families f LEFT JOIN ip_affiliations a ON a.id=f.affiliation_id LEFT JOIN ip_family_members h ON h.family_id=f.id AND h.member_role='head' LEFT JOIN ip_family_members s ON s.family_id=f.id AND s.member_role='spouse' WHERE h.first_name LIKE ? OR h.last_name LIKE ? OR s.first_name LIKE ? OR s.last_name LIKE ? OR a.name LIKE ? OR f.barangay LIKE ? OR f.sitio_street LIKE ? ORDER BY f.id DESC LIMIT 20");
        $stmt->bind_param('sssssss', $like, $like, $like, $like, $like, $like, $like);
    }
    $stmt->execute(); $families = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $stmt = $conn->prepare('SELECT id,applicant_fullname,applicant_ip_group,case_title,incident_barangay,incident_municipality,status FROM case_applications WHERE applicant_ip_group=? AND (applicant_fullname LIKE ? OR case_title LIKE ? OR incident_barangay LIKE ? OR incident_municipality LIKE ?) ORDER BY id DESC LIMIT 20');
        $stmt->bind_param('sssss', $tribe, $like, $like, $like, $like);
    } else {
        $stmt = $conn->prepare('SELECT id,applicant_fullname,applicant_ip_group,case_title,incident_barangay,incident_municipality,status FROM case_applications WHERE applicant_fullname LIKE ? OR applicant_ip_group LIKE ? OR case_title LIKE ? OR incident_barangay LIKE ? OR incident_municipality LIKE ? ORDER BY id DESC LIMIT 20');
        $stmt->bind_param('sssss', $like, $like, $like, $like, $like);
    }
    $stmt->execute(); $cases = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if (in_array($role, ['tribe_leader', 'tribe_rep'], true)) {
        $stmt=$conn->prepare("SELECT t.id,t.td_number,t.owner_name,t.location_barangay,p.land_name FROM tax_declarations t LEFT JOIN ip_land_parcels p ON p.id=t.parcel_id WHERE t.owning_tribe=? AND (t.td_number LIKE ? OR t.pin LIKE ? OR t.owner_name LIKE ? OR t.location_barangay LIKE ? OR t.lot_number LIKE ? OR EXISTS(SELECT 1 FROM tax_declaration_assessments a WHERE a.tax_declaration_id=t.id AND (a.classification LIKE ? OR a.actual_use LIKE ?))) ORDER BY t.id DESC LIMIT 20");$stmt->bind_param('ssssssss',$tribe,$like,$like,$like,$like,$like,$like,$like);
    } else {
        $stmt=$conn->prepare("SELECT t.id,t.td_number,t.owner_name,t.location_barangay,p.land_name FROM tax_declarations t LEFT JOIN ip_land_parcels p ON p.id=t.parcel_id WHERE t.td_number LIKE ? OR t.pin LIKE ? OR t.owner_name LIKE ? OR t.location_barangay LIKE ? OR t.lot_number LIKE ? OR EXISTS(SELECT 1 FROM tax_declaration_assessments a WHERE a.tax_declaration_id=t.id AND (a.classification LIKE ? OR a.actual_use LIKE ?)) ORDER BY t.id DESC LIMIT 20");$stmt->bind_param('sssssss',$like,$like,$like,$like,$like,$like,$like);
    }
    $stmt->execute();$taxDeclarations=$stmt->get_result()->fetch_all(MYSQLI_ASSOC);

    if ($role === 'admin') {
        $stmt = $conn->prepare('SELECT id,username,full_name,email,role,status FROM users WHERE username LIKE ? OR full_name LIKE ? OR email LIKE ? ORDER BY id DESC LIMIT 20');
        $stmt->bind_param('sss', $like, $like, $like); $stmt->execute(); $users = $stmt->get_result()->fetch_all(MYSQLI_ASSOC);
    }
}

$roleFolder = in_array($_SESSION['role'] ?? '', ['tribe_leader', 'tribe_rep'], true) ? $_SESSION['role'] : 'admin';
?>
<main class="main-no-right">
    <div class="page-heading"><div><h4>Search Results</h4><p><?= $query === '' ? 'Enter at least two characters to search.' : 'Results for “' . e($query) . '”' ?></p></div></div>
    <?php if (mb_strlen($query) < 2): ?>
        <div class="empty-state"><i class="bi bi-search"></i><h5>Search the system</h5><p>Use the search field above to find records, cases, people, locations, and users available to your role.</p></div>
    <?php else: ?>
        <?php foreach ([['Records',$records],['Families',$families],['Cases',$cases],['Tax Declarations',$taxDeclarations],['Users',$users]] as [$title,$items]): if ($title === 'Users' && ($_SESSION['role'] ?? '') !== 'admin') continue; ?>
            <section class="card-box mb-3">
                <div class="d-flex justify-content-between align-items-center mb-3"><h5 class="mb-0"><?= e($title) ?></h5><span class="badge text-bg-light"><?= count($items) ?></span></div>
                <?php if (!$items): ?><p class="text-muted mb-0">No matching <?= e(strtolower($title)) ?>.</p><?php else: ?>
                    <div class="list-group list-group-flush">
                    <?php foreach ($items as $item):
                        if ($title === 'Records') { $url=BASE_URL . '/auth/' . $roleFolder . '/records/view.php?id=' . (int)$item['id']; $primary=$item['full_name']; $secondary=($item['reference_code'] ?: 'No reference') . ' · ' . $item['tribe'] . ' · ' . $item['barangay']; }
                        elseif ($title === 'Families') { $url=BASE_URL . '/auth/families/view.php?id=' . (int)$item['id']; $primary=$item['head_name']; $secondary=($item['family_reference'] ?: 'No reference') . ' · ' . ($item['affiliation_name'] ?: 'No affiliation') . ' · ' . $item['barangay']; }
                        elseif ($title === 'Cases') { $url=BASE_URL . '/auth/' . $roleFolder . '/cases/view.php?id=' . (int)$item['id']; $primary=$item['case_title']; $secondary=$item['applicant_fullname'] . ' · ' . $item['incident_barangay']; }
                        elseif ($title === 'Tax Declarations') { $url=BASE_URL . '/auth/tax_declarations/view.php?id=' . (int)$item['id']; $primary=$item['td_number']; $secondary=($item['owner_name']?:'Owner not recorded') . ' · ' . ($item['land_name']?:$item['location_barangay']?:'No mapped parcel'); }
                        else { $url=BASE_URL . '/auth/admin/users/edit.php?id=' . (int)$item['id']; $primary=$item['full_name'] ?: $item['username']; $secondary=$item['email'] . ' · ' . str_replace('_',' ',$item['role']); }
                    ?>
                        <a class="list-group-item list-group-item-action d-flex justify-content-between align-items-center gap-3" href="<?= e($url) ?>"><span><strong><?= e($primary) ?></strong><small class="d-block text-muted"><?= e($secondary) ?></small></span><i class="bi bi-chevron-right"></i></a>
                    <?php endforeach; ?></div>
                <?php endif; ?>
            </section>
        <?php endforeach; ?>
    <?php endif; ?>
</main>
<?php require '../includes/footer.php'; ?>
