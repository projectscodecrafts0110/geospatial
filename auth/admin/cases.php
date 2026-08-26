<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
require '../../includes/db.php';

requireRole(['admin', 'staff', 'assessor']);

// ==========================
// FETCH CASES
// ==========================
$roleScope=($_SESSION['role']??'')==='assessor'?" WHERE assigned_to='assessor'":((($_SESSION['role']??'')==='staff')?" WHERE (assigned_to='staff' OR created_by=".(int)($_SESSION['user_id']??0).")":'');
$caseStats = $conn->query("SELECT COUNT(*) total,
    SUM(status='pending') pending,
    SUM(status='ongoing') ongoing,
    SUM(status='under_review') review_count,
    SUM(status='resolved') resolved FROM case_applications $roleScope")->fetch_assoc();
$totalCases = (int) $caseStats['total'];
$pendingCases = (int) $caseStats['pending'];
$ongoingCases = (int) $caseStats['ongoing'];
$reviewCases = (int) $caseStats['review_count'];
$resolvedCases = (int) $caseStats['resolved'];
$filterQ=trim((string)($_GET['q']??'')); $filterStatus=(string)($_GET['status']??''); $filterType=(string)($_GET['type']??'');
$where=' WHERE 1=1';
if(($_SESSION['role']??'')==='assessor')$where.=" AND assigned_to='assessor'";
if(($_SESSION['role']??'')==='staff')$where.=" AND (assigned_to='staff' OR created_by=".(int)($_SESSION['user_id']??0).")";
if($filterQ!==''){ $safe=mysqli_real_escape_string($conn,$filterQ); $where.=" AND (applicant_fullname LIKE '%$safe%' OR case_title LIKE '%$safe%' OR incident_barangay LIKE '%$safe%' OR incident_municipality LIKE '%$safe%' OR incident_location_text LIKE '%$safe%' OR EXISTS(SELECT 1 FROM case_persons_involved p WHERE p.case_id=case_applications.id AND p.person_name LIKE '%$safe%'))"; }
$allowedStatuses=['pending','ongoing','under_review','resolved','closed']; if(in_array($filterStatus,$allowedStatuses,true)){$where.=" AND status='".mysqli_real_escape_string($conn,$filterStatus)."'";}else{$filterStatus='';}
$allowedTypes=['land_dispute','ancestral_domain_conflict','cultural_rights_violation','discrimination','environmental_issue','other']; if(in_array($filterType,$allowedTypes,true)){$where.=" AND case_type='".mysqli_real_escape_string($conn,$filterType)."'";}else{$filterType='';}
$filteredTotal=(int)$conn->query("SELECT COUNT(*) FROM case_applications $where")->fetch_row()[0];
[$page, $perPage, $offset, $pages] = pagination_values($filteredTotal);
$sql = "SELECT case_applications.id,applicant_fullname,applicant_ip_group,case_title,case_type,incident_barangay,incident_municipality,status,assigned_to,created_at,(SELECT COUNT(DISTINCT fm.family_id) FROM case_persons_involved cp JOIN ip_family_members fm ON fm.id=cp.family_member_id WHERE cp.case_id=case_applications.id) linked_family_count,(SELECT COUNT(*) FROM case_tax_declarations ct WHERE ct.case_id=case_applications.id) tax_declaration_count FROM case_applications $where ORDER BY id DESC LIMIT $perPage OFFSET $offset";
$result = mysqli_query($conn, $sql);

$cases = [];
while ($row = mysqli_fetch_assoc($result)) {
    $cases[] = $row;
}

// ==========================
// STATS (FIXED STATUS VALUES)
// ==========================
?>

<div class="main-no-right">

    <!-- HEADER -->
    <div class="workspace-header">

        <div>
            <div class="eyebrow">Case Management</div><h1>Case Applications</h1>
            <p>Follow intake, assignment, assessment, review, and resolution with linked family and land evidence.</p>
        </div>

        <?php if ($_SESSION['role'] == 'admin'): ?>
            <a href="cases/import.php" class="btn btn-light border btn-sm"><i class="bi bi-file-earmark-word"></i> Import</a>
            <a href="cases/create.php" class="btn btn-success btn-sm">
                <i class="bi bi-plus-circle"></i>
            </a>
        <?php endif; ?>

    </div>

    <?php require '../../includes/components/case_summary.php'; ?>

    <!-- FILTERS -->
    <form class="card-box mb-3" method="get">

        <div class="row g-2">

            <div class="col-md-5">
                <input type="search" id="searchInput" name="q" value="<?= e($filterQ) ?>"
                    class="form-control form-control-sm"
                    placeholder="Search name, title, barangay...">
            </div>

            <div class="col-md-3">
                <select id="statusFilter" name="status" class="form-select form-select-sm">
                    <option value="">All Status</option>
                    <?php foreach($allowedStatuses as $value): ?><option value="<?= e($value) ?>" <?= $filterStatus===$value?'selected':'' ?>><?= e(ucwords(str_replace('_',' ',$value))) ?></option><?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <select id="typeFilter" name="type" class="form-select form-select-sm">
                    <option value="">All Types</option>
                    <?php foreach($allowedTypes as $value): ?><option value="<?= e($value) ?>" <?= $filterType===$value?'selected':'' ?>><?= e(ucwords(str_replace('_',' ',$value))) ?></option><?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-1">
                <button class="btn btn-success btn-sm w-100" aria-label="Apply filters"><i class="bi bi-funnel"></i></button>
            </div>

        </div>

    </form>

    <!-- TABLE -->
    <div class="card-box p-0 overflow-hidden">

        <table class="table table-hover align-middle mb-0" id="casesTable">

            <thead class="table-light">
                <tr>
                    <th>Applicant</th>
                    <th>Case</th>
                    <th>Connections</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th class="text-end">Action</th>
                </tr>
            </thead>

            <tbody>
                <?php if (!$cases): ?><tr><td colspan="7"><div class="empty-state border-0"><i class="bi bi-folder2-open"></i><h5>No cases found</h5><p>Try changing or clearing the filters.</p></div></td></tr><?php endif; ?>

                <?php foreach ($cases as $c): ?>

                    <tr>

                        <!-- APPLICANT -->
                        <td data-label="Applicant/Tribe">
                            <div class="fw-semibold">
                                <?= htmlspecialchars($c['applicant_fullname']) ?><br>
                                <small class="text-muted">
                                    <?= htmlspecialchars($c['applicant_ip_group']) ?>
                                </small>
                            </div>

                        </td>

                        <!-- CASE -->
                        <td data-label="Case">
                            <div class="fw-semibold">
                                <?= htmlspecialchars($c['case_title']) ?><br>
                                <small class="text-muted">
                                    <?= str_replace('_', ' ', $c['case_type']) ?>
                                </small>
                            </div>

                        </td>

                        <td data-label="Connections"><span class="relationship-chip"><i class="bi bi-people-fill"></i><?=(int)$c['linked_family_count']?> families</span> <span class="relationship-chip"><i class="bi bi-file-earmark-spreadsheet"></i><?=(int)$c['tax_declaration_count']?> TD</span></td>

                        <!-- LOCATION -->
                        <td data-label="Location">
                            <div class="fw-semibold">
                                <?= e($c['incident_barangay']) ?><br>
                                <small class="text-muted">
                                    <?= e($c['incident_municipality']) ?>
                                </small>
                            </div>
                        </td>

                        <!-- STATUS -->
                        <td data-label="Status">
                            <?php
                            $badge = "bg-secondary";

                            if ($c['status'] == 'ongoing') $badge = "bg-primary";
                            if ($c['status'] == 'under_review') $badge = "bg-warning text-dark";
                            if ($c['status'] == 'resolved') $badge = "bg-success";
                            if ($c['status'] == 'closed') $badge = "bg-dark";
                            ?>

                            <span class="badge <?= $badge ?>">
                                <?= e(ucwords(str_replace('_',' ',$c['status']))) ?>
                            </span>
                        </td>

                        <!-- DATE -->
                        <td data-label="Date">
                            <?= date('M d, Y', strtotime($c['created_at'])) ?>
                        </td>

                        <!-- ACTION -->
                        <td class="text-end">

                            <div class="dropdown">
                                <button class="btn btn-sm btn-light border dropdown-toggle"
                                    data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end">

                                    <li>
                                        <a class="dropdown-item"
                                            href="cases/view.php?id=<?= $c['id'] ?>">
                                            View
                                        </a>
                                    </li>

                                    <?php if (in_array($_SESSION['role'], ['admin','staff'], true)): ?>
                                        <li>
                                            <a class="dropdown-item"
                                                href="cases/edit.php?id=<?= $c['id'] ?>">
                                                Edit
                                            </a>
                                        </li>
                                    <?php endif; ?>

                                </ul>
                            </div>

                        </td>

                    </tr>

                <?php endforeach; ?>

            </tbody>

        </table>

    </div>
</div>

<?php render_pagination($page, $pages); ?>
<?php require '../../includes/footer.php'; ?>
