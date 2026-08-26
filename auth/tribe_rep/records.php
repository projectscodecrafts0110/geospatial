<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['tribe_rep']);
require '../../includes/db.php';

$user_tribe = current_user_tribe($conn) ?? '';
$scopeTribe = mysqli_real_escape_string($conn, $user_tribe);
$stats = $conn->query("SELECT COUNT(*) total, SUM(status='approved') approved, SUM(status='for_assessment') assessment, SUM(status='for_approval') for_approval, SUM(status='rejected') rejected FROM ip_records WHERE tribe='$scopeTribe'")->fetch_assoc();
$total = (int) $stats['total']; $approved = (int) $stats['approved']; $assessment = (int) $stats['assessment']; $forApproval = (int) $stats['for_approval']; $rejected = (int) $stats['rejected'];
$filterQ=trim((string)($_GET['q']??''));$filterStatus=(string)($_GET['status']??'');$where=" WHERE tribe='$scopeTribe'";
if($filterQ!==''){$safe=mysqli_real_escape_string($conn,$filterQ);$where.=" AND (reference_code LIKE '%$safe%' OR full_name LIKE '%$safe%' OR barangay LIKE '%$safe%' OR municipality LIKE '%$safe%')";}
if(in_array($filterStatus,['approved','for_assessment','for_approval','rejected'],true)){$where.=" AND status='".mysqli_real_escape_string($conn,$filterStatus)."'";}else{$filterStatus='';}
$filteredTotal=(int)$conn->query("SELECT COUNT(*) FROM ip_records $where")->fetch_row()[0];[$page,$perPage,$offset,$pages]=pagination_values($filteredTotal);
$sql = "SELECT id, reference_code, full_name, gender, birthdate, sitio, barangay, municipality, latitude, longitude, tribe, status, created_at FROM ip_records $where ORDER BY id DESC LIMIT $perPage OFFSET $offset";
$result = mysqli_query($conn, $sql);

$records = [];
while ($row = mysqli_fetch_assoc($result)) {
    $records[] = $row;
}


$tribeList = $user_tribe !== '' ? [$user_tribe] : [];
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <div class="d-flex justify-content-between align-items-start mb-3">

        <div>
            <h4 class="mb-1">IP Records</h4>
            <small class="text-muted">
                Manage Indigenous Peoples registry and GIS data
            </small>
        </div>

        <a href="records/create.php" class="btn btn-success btn-sm">
            <i class="bi bi-plus-circle"></i> New Record
        </a>

    </div>

    <?php require '../../includes/components/record_summary.php'; ?>

    <form class="card-box mb-3" method="get">

        <div class="row g-2">

            <!-- SEARCH -->
            <div class="col-md-4">
                <input type="search" id="searchInput" name="q" value="<?= e($filterQ) ?>" class="form-control"
                    placeholder="Search name or reference...">
            </div>

            <!-- STATUS FILTER -->
            <div class="col-md-3">
                <select id="statusFilter" name="status" class="form-select">
                    <option value="">All Status</option>
                    <option value="approved" <?= $filterStatus==='approved'?'selected':'' ?>>Approved</option><option value="for_assessment" <?= $filterStatus==='for_assessment'?'selected':'' ?>>For Assessment</option><option value="for_approval" <?= $filterStatus==='for_approval'?'selected':'' ?>>For Approval</option><option value="rejected" <?= $filterStatus==='rejected'?'selected':'' ?>>Rejected</option>
                </select>
            </div>

            <div class="col-md-5"><div class="d-flex gap-2"><button class="btn btn-success flex-fill">Filter</button><a class="btn btn-light border" href="records.php">Reset</a></div></div>

        </div>

    </form>

    <div class="card-box p-0 overflow-hidden">

        <table class="table table-hover align-middle mb-0">

            <thead class="table-light">
                <tr>
                    <th>Reference</th>
                    <th>Person</th>
                    <th>Location</th>
                    <th>Status</th>
                    <th class="text-end">Action</th>
                </tr>
            </thead>

            <tbody>
                <?php if (!$records): ?><tr><td colspan="5"><div class="empty-state border-0"><i class="bi bi-inbox"></i><h5>No records found</h5><p>Try changing or clearing the filters.</p></div></td></tr><?php endif; ?>

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
                                    <?php if ($r['status'] !== 'for_approval'): ?>
                                        <li>
                                            <a class="dropdown-item" href="records/edit.php?id=<?= $r['id'] ?>">
                                                <i class="bi bi-pencil me-2"></i> Edit
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
<?php render_pagination($page, $pages); require '../../includes/footer.php'; ?>
