<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['tribe_rep']);
require '../../includes/db.php';

/* =========================
   SUMMARY COUNTS
========================= */
$user_id = $_SESSION['user_id'];

$get_user_tribe = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT tribe FROM user_tribes WHERE user_id = $user_id"
));

$user_tribe = $get_user_tribe['tribe'];

$totalIPs = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records WHERE tribe = '$user_tribe'"
))['c'];

$forApproval = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records
     WHERE status='for_approval' AND tribe = '$user_tribe'"
))['c'];

$approved = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records
     WHERE status='approved' AND tribe = '$user_tribe'"
))['c'];

$rejected = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records
     WHERE status='rejected' AND tribe='$user_tribe'"
))['c'];

/* =========================
   RECENT RECORDS
========================= */

$approvedRecords = mysqli_query($conn, "
    SELECT id,
           reference_code,
           full_name,
           tribe,
           status,
           created_at
    FROM ip_records
    WHERE status = 'approved' AND tribe = '$user_tribe'
    ORDER BY id DESC
    LIMIT 5
");

/* =========================
   MAP MARKERS
========================= */

$markers = [];

$mapResult = mysqli_query($conn, "
    SELECT full_name,
           tribe,
           latitude,
           longitude
    FROM ip_records
    WHERE latitude IS NOT NULL
      AND longitude IS NOT NULL
      AND latitude != ''
      AND longitude != ''
      AND tribe = '$user_tribe'
");

while ($m = mysqli_fetch_assoc($mapResult)) {
    $markers[] = $m;
}
?>

<link rel="stylesheet"
    href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <!-- HEADER -->
    <div class="card-box mb-3">

        <div class="d-flex justify-content-between align-items-center">

            <div>
                <h4 class="mb-1">
                    Welcome, Tribe Representative (<?= $user_tribe ?>)
                </h4>

                <small class="text-muted">
                    Monitor Indigenous Peoples records,
                    validate submissions, and track GIS locations.
                </small>
            </div>

            <span class="badge bg-success">
                Tribe Representative Portal
            </span>

        </div>

    </div>

    <!-- SUMMARY CARDS -->
    <div class="row g-3">

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Total IP Records
                </small>

                <h2 class="mb-0">
                    <?= number_format($totalIPs) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    For Approval
                </small>

                <h2 class="mb-0 text-warning">
                    <?= number_format($forApproval) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Approved
                </small>

                <h2 class="mb-0 text-success">
                    <?= number_format($approved) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Rejected
                </small>

                <h2 class="mb-0 text-danger">
                    <?= number_format($rejected) ?>
                </h2>

            </div>
        </div>

    </div>

    <!-- QUICK ACTIONS -->
    <div class="my-3">
        <div class="d-flex flex-wrap gap-3 justify-content-center">
            <a href="records/create.php"
                class="btn btn-success col-3">

                <i class="bi bi-person-plus"></i>
                Create IP Record

            </a>

            <a href="records.php"
                class="btn btn-primary col-3">

                <i class="bi bi-folder2-open"></i>
                View Records

            </a>

            <a href="cases.php"
                class="btn btn-warning col-3">

                <i class="bi bi-exclamation-triangle"></i>
                Manage Cases

            </a>
        </div>
    </div>

    <!-- MAP + PENDING -->
    <div class="row g-3 mt-1">

        <div class="col-lg-12">

            <div class="card-box">

                <div class="d-flex justify-content-between align-items-center mb-3">

                    <h6 class="mb-0">
                        GIS Distribution of IP Members
                    </h6>

                    <span class="badge bg-success">
                        Live GIS Data
                    </span>

                </div>

                <div id="map"
                    style="height:420px;border-radius:10px;">
                </div>

            </div>

        </div>
    </div>

    <div class="row g-3 mt-1">

        <div class="col-lg-6">

            <div class="card-box">

                <h6 class="mb-3">
                    Pending Validation
                </h6>

                <?php

                $pending = mysqli_query($conn, "
                    SELECT id,
                           reference_code,
                           full_name
                    FROM ip_records
                    WHERE status='for_approval'
                    ORDER BY id DESC
                    LIMIT 8
                ");

                if (mysqli_num_rows($pending) > 0):

                    while ($p = mysqli_fetch_assoc($pending)):
                ?>

                        <div class="border-bottom py-2">

                            <div class="fw-semibold">
                                <?= htmlspecialchars($p['full_name']) ?>
                            </div>

                            <small class="text-muted">
                                <?= htmlspecialchars($p['reference_code']) ?>
                            </small>

                        </div>

                    <?php endwhile; ?>

                <?php else: ?>

                    <div class="text-muted">
                        No pending approvals.
                    </div>

                <?php endif; ?>

            </div>

        </div>

        <!-- RECENT RECORDS -->
        <div class="col-6">
            <div class="card-box">

                <div class="d-flex justify-content-between align-items-center mb-3">

                    <h6 class="mb-0">
                        Recent Approved Records
                    </h6>

                    <a href="../records.php"
                        class="btn btn-sm btn-light border">

                        View All

                    </a>

                </div>

                <div class="table-responsive">

                    <table class="table table-hover align-middle">

                        <thead>

                            <tr>
                                <th>Reference</th>
                                <th>Name</th>
                                <th>Tribe</th>
                                <th>Status</th>
                            </tr>

                        </thead>

                        <tbody>

                            <?php while ($r = mysqli_fetch_assoc($approvedRecords)): ?>

                                <tr>

                                    <td>
                                        <?= htmlspecialchars($r['reference_code']) ?>
                                    </td>

                                    <td>
                                        <?= htmlspecialchars($r['full_name']) ?>
                                    </td>

                                    <td>
                                        <?= htmlspecialchars($r['tribe']) ?>
                                    </td>

                                    <td>

                                        <?php

                                        $badge = match ($r['status']) {

                                            'approved' =>
                                            'bg-success',

                                            'for_assessment' =>
                                            'bg-warning text-dark',

                                            'for_approval' =>
                                            'bg-primary',

                                            'rejected' =>
                                            'bg-danger',

                                            default =>
                                            'bg-secondary'
                                        };

                                        ?>

                                        <span class="badge <?= $badge ?>">
                                            <?= strtoupper(str_replace('_', ' ', $r['status'])) ?>
                                        </span>

                                    </td>

                                </tr>

                            <?php endwhile; ?>

                        </tbody>

                    </table>

                </div>

            </div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>

<script>
    var map = L.map('map').setView([18.461, 120.94], 11);

    L.tileLayer(
        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '&copy; OpenStreetMap'
        }
    ).addTo(map);

    let markers =
        <?= json_encode($markers) ?>;

    markers.forEach(function(item) {

        L.marker([
                item.latitude,
                item.longitude
            ])
            .addTo(map)
            .bindPopup(
                "<b>" + item.full_name + "</b><br>" + item.tribe
            );

    });
</script>

<?php require '../../includes/footer.php'; ?>