<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin']);
require '../../includes/db.php';

/* =========================
   SUMMARY CARDS
========================= */

$totalIPs = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records
     WHERE status='approved'"
))['c'];

$totalTribes = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(DISTINCT tribe) c
     FROM ip_records
     WHERE status='approved'"
))['c'];

$totalLandParcels = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_land_parcels"
))['c'];

$gisTagged = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c
     FROM ip_records
     WHERE latitude IS NOT NULL
     AND longitude IS NOT NULL
     AND latitude != ''
     AND longitude != ''"
))['c'];

$gisCoverage = $totalIPs > 0
    ? round(($gisTagged / $totalIPs) * 100)
    : 0;
$totalFamilies=(int)$conn->query('SELECT COUNT(*) FROM ip_families')->fetch_row()[0];
$totalMembers=(int)$conn->query('SELECT COUNT(*) FROM ip_family_members')->fetch_row()[0];
$familyLinkedRecords=(int)$conn->query('SELECT COUNT(*) FROM ip_records WHERE family_member_id IS NOT NULL')->fetch_row()[0];
$familyLinkedCases=(int)$conn->query('SELECT COUNT(DISTINCT cp.case_id) FROM case_persons_involved cp JOIN ip_family_members fm ON fm.id=cp.family_member_id')->fetch_row()[0];
$linkedTax=(int)$conn->query('SELECT COUNT(*) FROM tax_declarations WHERE parcel_id IS NOT NULL')->fetch_row()[0];

/* =========================
   IP POPULATION BY TRIBE
========================= */

$tribeLabels = [];
$tribeData = [];

$tribes = mysqli_query($conn, "
    SELECT tribe,
           COUNT(*) total
    FROM ip_records
    WHERE status='approved'
    GROUP BY tribe
    ORDER BY total DESC
");

while ($row = mysqli_fetch_assoc($tribes)) {

    $tribeLabels[] = $row['tribe'];
    $tribeData[] = $row['total'];
}

/* =========================
   RECORD STATUS
========================= */

$statusLabels = [];
$statusData = [];

$statusResult = mysqli_query($conn, "
    SELECT status,
           COUNT(*) total
    FROM ip_records
    GROUP BY status
");

while ($row = mysqli_fetch_assoc($statusResult)) {

    $statusLabels[] = strtoupper(
        str_replace('_', ' ', $row['status'])
    );

    $statusData[] = $row['total'];
}

/* =========================
   LAND OWNERSHIP
========================= */

$landLabels = [];
$landData = [];

$landResult = mysqli_query($conn, "
    SELECT ownership_status,
           COUNT(*) total
    FROM ip_land_parcels
    GROUP BY ownership_status
");

while ($row = mysqli_fetch_assoc($landResult)) {

    $landLabels[] = ucwords(
        str_replace('_', ' ', $row['ownership_status'])
    );

    $landData[] = $row['total'];
}

/* =========================
   BARANGAY RANKING
========================= */

$barangays = mysqli_query($conn, "
    SELECT barangay,
           COUNT(*) total
    FROM ip_records
    WHERE status='approved'
    GROUP BY barangay
    ORDER BY total DESC
    LIMIT 10
");

?>

<style>
    #reportMap {
        height: 550px;
        width: 100%;
        border-radius: 10px;
    }

    /* =========================
       PRINT MODE CONTROL
    ========================= */

    .print-only {
        display: none;
    }

    @media print {

        /* Hide UI clutter */
        .topbar,
        .sidebar,
        .btn,
        .right-panel,
        canvas {
            display: none !important;
        }

        /* Show print tables */
        .print-only {
            display: block !important;
        }

        /* Clean report look */
        body {
            background: white !important;
            color: #000 !important;
            font-size: 12px;
        }

        .card-box {
            box-shadow: none !important;
            border: 1px solid #ddd;
            page-break-inside: avoid;
        }

        h3 {
            font-size: 14px;
            margin-top: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th,
        table td {
            border: 1px solid #ccc !important;
            padding: 6px;
        }

        table th {
            background: #f3f4f6 !important;
        }
    }
</style>

<div class="main-no-right">

    <!-- HEADER -->
    <div class="workspace-header">

        <div>
            <div class="eyebrow">Planning &amp; Accountability</div><h1>Reports &amp; Analytics</h1>
            <p>Connected family, people, case, property, and GIS coverage indicators.</p>
        </div>

        <a href="reports_print.php" class="btn btn-success btn-sm">
            <i class="bi bi-printer"></i>
            Generate Print Report
        </a>

    </div>

    <!-- SUMMARY -->
    <div class="row g-3 mb-4">

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Approved IP Records
                </small>

                <h2 class="mb-0">
                    <?= number_format($totalIPs) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Registered Tribes
                </small>

                <h2 class="mb-0">
                    <?= number_format($totalTribes) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    Land Parcels
                </small>

                <h2 class="mb-0">
                    <?= number_format($totalLandParcels) ?>
                </h2>

            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">

                <small class="text-muted">
                    GIS Validated
                </small>

                <h2 class="mb-0">
                    <?= number_format($gisTagged) ?>
                </h2>

            </div>
        </div>

    </div>

    <div class="row g-3 mb-4"><?php foreach([['IP Families',$totalFamilies,'people-fill'],['Family Members',$totalMembers,'person-vcard'],['Records Linked to Families',$familyLinkedRecords,'link-45deg'],['Cases Linked to Families',$familyLinkedCases,'folder-symlink'],['Tax Declarations on Parcels',$linkedTax,'geo-alt']]as[$label,$value,$icon]):?><div class="col-6 col-lg"><div class="card-box metric-card"><div class="d-flex justify-content-between"><div><div class="metric-label"><?=$label?></div><div class="metric-value"><?=number_format($value)?></div></div><div class="metric-icon"><i class="bi bi-<?=$icon?>"></i></div></div></div></div><?php endforeach;?></div>
    <div class="data-context mb-4">Family linkage indicators distinguish legacy individual records from structured households and show how many cases already have explicit family-member relationships. Unlinked records remain valid and require reviewed matching.</div>

    <!-- =========================
     CHARTS ROW
========================= -->
    <div class="row g-3 mt-1">

        <!-- TRIBE CHART -->
        <div class="col-lg-6">

            <div class="card-box">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="mb-0">IP Population by Tribe</h6>
                    <span class="badge bg-success">Approved Records</span>
                </div>

                <canvas id="tribeChart" height="220"></canvas>

            </div>

        </div>

        <!-- STATUS CHART -->
        <div class="col-lg-6">

            <div class="card-box">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="mb-0">Record Status Distribution</h6>
                    <span class="badge bg-primary">System Status</span>
                </div>

                <canvas id="statusChart" height="220"></canvas>

            </div>

        </div>

    </div>


    <!-- =========================
     LAND + GIS COVERAGE
========================= -->
    <div class="row g-3 mt-1">

        <!-- LAND CHART -->
        <div class="col-lg-8">

            <div class="card-box">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="mb-0">Land Ownership Status</h6>
                    <span class="badge bg-secondary">
                        Parcels
                    </span>
                </div>

                <canvas id="landChart" height="120"></canvas>

            </div>

        </div>

        <!-- GIS COVERAGE -->
        <div class="col-lg-4">

            <div class="card-box h-100">

                <h6>GIS Coverage</h6>

                <h2 class="mb-1">
                    <?= $gisCoverage ?>%
                </h2>

                <small class="text-muted">
                    <?= $gisTagged ?>
                    GIS Tagged Records
                </small>

                <div class="progress mt-3" style="height:10px;">

                    <div
                        class="progress-bar bg-success"
                        style="width:<?= $gisCoverage ?>%">
                    </div>

                </div>

                <div class="mt-3">

                    <div class="d-flex justify-content-between">
                        <span>Approved Records</span>
                        <strong><?= $totalIPs ?></strong>
                    </div>

                    <div class="d-flex justify-content-between">
                        <span>GIS Tagged</span>
                        <strong><?= $gisTagged ?></strong>
                    </div>

                    <div class="d-flex justify-content-between">
                        <span>Missing Coordinates</span>
                        <strong><?= ($totalIPs - $gisTagged) ?></strong>
                    </div>

                </div>

            </div>

        </div>

    </div>


    <!-- =========================
     BARANGAY RANKING
========================= -->
    <div class="card-box mt-3">

        <div class="d-flex justify-content-between align-items-center mb-3">

            <h6 class="mb-0">
                Top Barangays by IP Population
            </h6>

            <span class="badge bg-success">
                Approved Records
            </span>

        </div>

        <div class="table-responsive">

            <table class="table table-hover align-middle">

                <thead>

                    <tr>
                        <th>#</th>
                        <th>Barangay</th>
                        <th class="text-end">Population</th>
                    </tr>

                </thead>

                <tbody>

                    <?php
                    $rank = 1;

                    while ($b = mysqli_fetch_assoc($barangays)):
                    ?>

                        <tr>

                            <td><?= $rank++ ?></td>

                            <td>
                                <?= htmlspecialchars($b['barangay']) ?>
                            </td>

                            <td class="text-end fw-semibold">
                                <?= number_format($b['total']) ?>
                            </td>

                        </tr>

                    <?php endwhile; ?>

                </tbody>

            </table>

        </div>

    </div>



</div>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    /* =========================
   TRIBE CHART
========================= */

    new Chart(
        document.getElementById('tribeChart'), {
            type: 'bar',
            data: {
                labels: <?= json_encode($tribeLabels) ?>,
                datasets: [{
                    label: 'Population',
                    data: <?= json_encode($tribeData) ?>
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        }
    );


    /* =========================
       STATUS CHART
    ========================= */

    new Chart(
        document.getElementById('statusChart'), {
            type: 'doughnut',
            data: {
                labels: <?= json_encode($statusLabels) ?>,
                datasets: [{
                    data: <?= json_encode($statusData) ?>
                }]
            },
            options: {
                responsive: true
            }
        }
    );


    /* =========================
       LAND CHART
    ========================= */

    new Chart(
        document.getElementById('landChart'), {
            type: 'bar',
            data: {
                labels: <?= json_encode($landLabels) ?>,
                datasets: [{
                    label: 'Parcels',
                    data: <?= json_encode($landData) ?>
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                }
            }
        }
    );
</script>
<?php require '../../includes/footer.php'; ?>
