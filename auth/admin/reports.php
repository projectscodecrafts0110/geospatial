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
$totalCases=(int)$conn->query('SELECT COUNT(*) FROM case_applications')->fetch_row()[0];
$activeCases=(int)$conn->query("SELECT COUNT(*) FROM case_applications WHERE status NOT IN ('resolved','closed')")->fetch_row()[0];
$resolvedCases=(int)$conn->query("SELECT COUNT(*) FROM case_applications WHERE status IN ('resolved','closed')")->fetch_row()[0];
$totalTax=(int)$conn->query('SELECT COUNT(*) FROM tax_declarations')->fetch_row()[0];
$currentTax=(int)$conn->query("SELECT COUNT(*) FROM tax_declarations WHERE declaration_status='current'")->fetch_row()[0];
$parcelGeometry=(int)$conn->query("SELECT COUNT(*) FROM ip_land_parcels WHERE boundary_geojson IS NOT NULL OR (latitude IS NOT NULL AND longitude IS NOT NULL)")->fetch_row()[0];
$familiesWithSpouse=(int)$conn->query("SELECT COUNT(DISTINCT family_id) FROM ip_family_members WHERE member_role='spouse'")->fetch_row()[0];
$familyLinkCoverage=$totalMembers>0?round(($familyLinkedRecords/$totalMembers)*100):0;
$parcelGeometryCoverage=$totalLandParcels>0?round(($parcelGeometry/$totalLandParcels)*100):0;
$taxParcelCoverage=$totalTax>0?round(($linkedTax/$totalTax)*100):0;

$familyAffiliations=$conn->query("SELECT COALESCE(a.name,'Not specified') label,COUNT(*) total FROM ip_families f LEFT JOIN ip_affiliations a ON a.id=f.affiliation_id GROUP BY a.id,a.name ORDER BY total DESC,label")->fetch_all(MYSQLI_ASSOC);
$familyLocations=$conn->query("SELECT COALESCE(NULLIF(f.barangay,''),'Not specified') barangay,COUNT(DISTINCT f.id) families,COUNT(m.id) members FROM ip_families f LEFT JOIN ip_family_members m ON m.family_id=f.id GROUP BY COALESCE(NULLIF(f.barangay,''),'Not specified') ORDER BY families DESC,barangay LIMIT 10")->fetch_all(MYSQLI_ASSOC);
$memberSex=$conn->query("SELECT COALESCE(sex,'Not specified') label,COUNT(*) total FROM ip_family_members GROUP BY sex ORDER BY total DESC")->fetch_all(MYSQLI_ASSOC);
$caseSummary=$conn->query("SELECT status,COUNT(*) total FROM case_applications GROUP BY status ORDER BY FIELD(status,'pending','ongoing','under_review','resolved','closed')")->fetch_all(MYSQLI_ASSOC);

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

    <div class="row g-3 mb-4"><?php foreach([['All Cases',$totalCases],['Active Cases',$activeCases],['Resolved / Closed',$resolvedCases],['Tax Declarations',$totalTax],['Current Declarations',$currentTax],['Mapped Parcel Geometry',$parcelGeometry]]as[$label,$value]):?><div class="col-6 col-md-4 col-xl-2"><div class="card-box h-100"><small class="text-muted"><?=$label?></small><h3 class="mb-0"><?=number_format($value)?></h3></div></div><?php endforeach;?></div>

    <div class="row g-3 mb-4">
        <div class="col-lg-7"><div class="card-box h-100"><h6>Family Affiliation Distribution</h6><div class="table-responsive"><table class="table table-sm align-middle"><thead><tr><th>Affiliation</th><th class="text-end">Families</th><th class="text-end">Share</th></tr></thead><tbody><?php foreach($familyAffiliations as$r):?><tr><td><?=e($r['label'])?></td><td class="text-end"><?=number_format($r['total'])?></td><td class="text-end"><?=$totalFamilies?round($r['total']/$totalFamilies*100,1):0?>%</td></tr><?php endforeach;?></tbody></table></div></div></div>
        <div class="col-lg-5"><div class="card-box h-100"><h6>Household &amp; Data Coverage</h6><?php foreach([['Families with a recorded spouse',$familiesWithSpouse,$totalFamilies?round($familiesWithSpouse/$totalFamilies*100):0],['Members linked to legacy records',$familyLinkedRecords,$familyLinkCoverage],['Parcels with mapped geometry',$parcelGeometry,$parcelGeometryCoverage],['Tax declarations linked to parcels',$linkedTax,$taxParcelCoverage]]as[$label,$value,$pct]):?><div class="mb-3"><div class="d-flex justify-content-between"><span><?=$label?></span><strong><?=number_format($value)?> (<?=$pct?>%)</strong></div><div class="progress mt-1" style="height:7px"><div class="progress-bar bg-success" style="width:<?=min(100,$pct)?>%"></div></div></div><?php endforeach;?><hr><h6 class="small text-uppercase text-muted">Family members by sex</h6><?php foreach($memberSex as$r):?><div class="d-flex justify-content-between"><span><?=e($r['label'])?></span><strong><?=number_format($r['total'])?></strong></div><?php endforeach;?></div></div>
    </div>

    <div class="row g-3 mb-4"><div class="col-lg-7"><div class="card-box h-100"><h6>Top Family Locations</h6><div class="table-responsive"><table class="table table-sm"><thead><tr><th>Barangay</th><th class="text-end">Families</th><th class="text-end">Members</th></tr></thead><tbody><?php foreach($familyLocations as$r):?><tr><td><?=e($r['barangay'])?></td><td class="text-end"><?=number_format($r['families'])?></td><td class="text-end"><?=number_format($r['members'])?></td></tr><?php endforeach;?></tbody></table></div></div></div><div class="col-lg-5"><div class="card-box h-100"><h6>Case Workload by Status</h6><?php foreach($caseSummary as$r):?><div class="d-flex justify-content-between border-bottom py-2"><span><?=e(ucwords(str_replace('_',' ',$r['status'])))?></span><strong><?=number_format($r['total'])?></strong></div><?php endforeach;?></div></div></div>

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
