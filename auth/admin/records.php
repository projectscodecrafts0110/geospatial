<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin', 'staff', 'assessor']);
require '../../includes/db.php';

$stats = $conn->query("SELECT COUNT(*) total,
    SUM(status='approved') approved,
    SUM(status='for_assessment') assessment,
    SUM(status='for_approval') for_approval,
    SUM(status='rejected') rejected FROM ip_records")->fetch_assoc();
$total = (int) $stats['total'];
$approved = (int) $stats['approved'];
$assessment = (int) $stats['assessment'];
$forApproval = (int) $stats['for_approval'];
$rejected = (int) $stats['rejected'];
$filterQ = trim((string) ($_GET['q'] ?? ''));
$filterStatus = (string) ($_GET['status'] ?? '');
$filterTribe = trim((string) ($_GET['tribe'] ?? ''));
$where = ' WHERE 1=1';
if ($filterQ !== '') { $safe = mysqli_real_escape_string($conn, $filterQ); $where .= " AND (reference_code LIKE '%$safe%' OR full_name LIKE '%$safe%' OR barangay LIKE '%$safe%' OR municipality LIKE '%$safe%')"; }
if (in_array($filterStatus, ['approved','for_assessment','for_approval','rejected'], true)) { $where .= " AND status='" . mysqli_real_escape_string($conn, $filterStatus) . "'"; } else { $filterStatus=''; }
if ($filterTribe !== '') { $where .= " AND tribe='" . mysqli_real_escape_string($conn, $filterTribe) . "'"; }
$filteredTotal = (int) $conn->query("SELECT COUNT(*) FROM ip_records $where")->fetch_row()[0];
[$page, $perPage, $offset, $pages] = pagination_values($filteredTotal);
$recordWhere=str_replace(['reference_code','full_name','barangay','municipality','status','tribe'],['r.reference_code','r.full_name','r.barangay','r.municipality','r.status','r.tribe'],$where);
$sql = "SELECT r.id,r.reference_code,r.full_name,r.gender,r.birthdate,r.sitio,r.barangay,r.municipality,r.latitude,r.longitude,r.tribe,r.status,r.created_at,(SELECT m.family_id FROM ip_family_members m WHERE m.id=r.family_member_id) family_id,(SELECT f.family_reference FROM ip_family_members m JOIN ip_families f ON f.id=m.family_id WHERE m.id=r.family_member_id) family_reference FROM ip_records r $recordWhere ORDER BY r.id DESC LIMIT $perPage OFFSET $offset";
$result = mysqli_query($conn, $sql);

$records = [];
while ($row = mysqli_fetch_assoc($result)) {
    $records[] = $row;
}


$tribeList = [];
$tribeResult = $conn->query("SELECT DISTINCT tribe FROM ip_records WHERE tribe IS NOT NULL AND tribe <> '' ORDER BY tribe");
while ($tribeResult && $row = $tribeResult->fetch_assoc()) $tribeList[] = $row['tribe'];
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main">

    <div class="workspace-header">

        <div>
            <div class="eyebrow">People &amp; Registry</div><h1>Individual IP Records</h1>
            <p>Manage individual records and their optional structured family membership.</p>
        </div>

        <?php if ($_SESSION['role'] == 'staff'): ?>
            <a href="create.php" class="btn btn-success btn-sm">
                <i class="bi bi-plus-circle"></i> New Record
            </a>
        <?php endif; ?>

    </div>

    <?php require '../../includes/components/record_summary.php'; ?>

    <form class="card-box mb-3" method="get">

        <div class="row g-2">

            <!-- SEARCH -->
            <div class="col-md-4">
                <input type="search" id="searchInput" name="q" value="<?= e($filterQ) ?>" class="form-control" placeholder="Search name or reference...">
            </div>

            <!-- STATUS FILTER -->
            <div class="col-md-3">
                <select id="statusFilter" name="status" class="form-select">
                    <option value="">All Status</option>
                    <option value="approved" <?= $filterStatus==='approved'?'selected':'' ?>>Approved</option>
                    <option value="for_assessment" <?= $filterStatus==='for_assessment'?'selected':'' ?>>For Assessment</option>
                    <option value="for_approval" <?= $filterStatus==='for_approval'?'selected':'' ?>>For Approval</option>
                    <option value="rejected" <?= $filterStatus==='rejected'?'selected':'' ?>>Rejected</option>
                </select>
            </div>

            <!-- TRIBE FILTER -->
            <div class="col-md-3">
                <select id="tribeFilter" name="tribe" class="form-select">
                    <option value="">All Tribes</option>
                    <?php foreach ($tribeList as $tribe): ?>
                        <option value="<?= e($tribe) ?>" <?= $filterTribe===$tribe?'selected':'' ?>>
                            <?= htmlspecialchars($tribe) ?>
                        </option>
                    <?php endforeach; ?>
                </select>
            </div>

            <!-- RESET -->
            <div class="col-md-2">
                <div class="d-flex gap-1"><button class="btn btn-success flex-fill" type="submit">Filter</button><a class="btn btn-light border" href="records.php" aria-label="Reset filters"><i class="bi bi-arrow-counterclockwise"></i></a></div>
            </div>

        </div>

    </form>

    <div class="card-box p-0 overflow-hidden">

        <table class="table table-hover align-middle mb-0">

            <thead class="table-light">
                <tr>
                    <th>Reference</th>
                    <th>Person</th>
                    <th>Family Connection</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th class="text-end">Action</th>
                </tr>
            </thead>

            <tbody>
                <?php if (!$records): ?><tr><td colspan="6"><div class="empty-state border-0"><i class="bi bi-inbox"></i><h5>No records found</h5><p>Try changing or clearing the filters.</p></div></td></tr><?php endif; ?>

                <?php foreach ($records as $r): ?>

                    <tr>

                        <td data-label="Reference">
                            <div class="fw-semibold">
                                <?= htmlspecialchars($r['reference_code'] ?? 'N/A') ?>
                            </div>
                        </td>

                        <td data-label="Person/Tribe">
                            <div class="fw-semibold">
                                <?= htmlspecialchars($r['full_name']) ?><br>
                                <small class="text-muted">
                                    <?= htmlspecialchars($r['tribe']) ?>
                                </small>
                            </div>
                        </td>

                        <td data-label="Family Connection"><?php if($r['family_id']):?><a class="relationship-chip" href="../families/view.php?id=<?=(int)$r['family_id']?>"><i class="bi bi-people-fill"></i><?=e($r['family_reference'])?></a><?php else:?><span class="text-muted small">Not linked</span><?php endif;?></td>

                        <td data-label="Location">
                            <div class="small">
                                <?= htmlspecialchars($r['barangay']) ?>, <?= htmlspecialchars($r['municipality']) ?>
                            </div>
                        </td>

                        <td data-label="Status">
                            <?php
                            $status = $r['status'];

                            $badge = match ($status) {
                                'approved' => 'bg-success',
                                'for_assessment' => 'bg-warning text-dark',
                                'for_approval' => 'bg-primary',
                                'rejected' => 'bg-danger',
                                default => 'bg-secondary'
                            };
                            ?>

                            <span class="badge <?= $badge ?>">
                                <?= strtoupper(str_replace('_', ' ', $status)) ?>
                            </span>
                        </td>

                        <td class="text-end">

                            <div class="dropdown">

                                <button class="btn btn-sm btn-light border dropdown-toggle"
                                    data-bs-toggle="dropdown">
                                    <i class="bi bi-three-dots"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end">

                                    <!-- VIEW (ALL ROLES) -->
                                    <li>
                                        <a class="dropdown-item" href="records/view.php?id=<?= $r['id'] ?>">
                                            <i class="bi bi-eye me-2"></i> View
                                        </a>
                                    </li>

                                    <?php if ($_SESSION['role'] == 'staff' || $_SESSION['role'] == 'admin'): ?>
                                        <li>
                                            <a class="dropdown-item" href="records/edit.php?id=<?= $r['id'] ?>">
                                                <i class="bi bi-pencil me-2"></i> Edit
                                            </a>
                                        </li>
                                    <?php endif; ?>

                                    <?php if ($_SESSION['role'] == 'assessor'): ?>
                                        <li>
                                            <a class="dropdown-item text-success" href="gis.php?id=<?= $r['id'] ?>">
                                                <i class="bi bi-geo-alt me-2"></i> GIS Validate
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
    <?php
    include '../../includes/right_panel.php';
    ?>
</div>
<?php render_pagination($page, $pages); ?>
<?php require '../../includes/footer.php'; ?>
