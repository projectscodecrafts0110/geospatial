<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin']);
require '../../includes/db.php';

/* =========================
   SAME DATA QUERIES
========================= */

$totalIPs = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c FROM ip_records WHERE status='approved'"
))['c'];

$totalTribes = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(DISTINCT tribe) c FROM ip_records WHERE status='approved'"
))['c'];

$totalLandParcels = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c FROM ip_land_parcels"
))['c'];

$gisTagged = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c FROM ip_records
     WHERE latitude IS NOT NULL AND longitude IS NOT NULL"
))['c'];

$gisCoverage = $totalIPs > 0 ? round(($gisTagged / $totalIPs) * 100) : 0;

/* =========================
   DATA SETS
========================= */

$tribes = mysqli_query($conn, "
    SELECT tribe, COUNT(*) total
    FROM ip_records
    WHERE status='approved'
    GROUP BY tribe
");

$status = mysqli_query($conn, "
    SELECT status, COUNT(*) total
    FROM ip_records
    GROUP BY status
");

$land = mysqli_query($conn, "
    SELECT ownership_status, COUNT(*) total
    FROM ip_land_parcels
    GROUP BY ownership_status
");

$barangays = mysqli_query($conn, "
    SELECT barangay, COUNT(*) total
    FROM ip_records
    WHERE status='approved'
    GROUP BY barangay
    ORDER BY total DESC
");
?>

<style>
    /* =========================
   GLOBAL REPORT STYLE
========================= */

    body {
        color: #000 !important;
        background: #f2f2f2 !important;
        /* preview gray background */
        margin: 0;
        padding: 0;
    }

    /* =========================
   LONG BOND PAPER PREVIEW
========================= */

    .report-container {
        width: 8.5in;
        /* paper width */
        min-height: 13in;
        font-family: Arial, sans-serif !important;
        font-size: 12px !important;
        /* long bond approximation */
        margin: 20px auto;
        background: #fff;
        padding: 0.8in;
        border: 1px solid #cfcfcf;
        box-shadow: 0 0 12px rgba(0, 0, 0, 0.15);
    }

    /* =========================
   TITLES
========================= */

    h2 {
        font-family: Arial, sans-serif !important;
        font-size: 16px !important;
        text-align: center;
        margin-bottom: 5px;
    }

    h3 {
        font-family: Arial, sans-serif !important;
        font-size: 13px !important;
        margin-top: 20px;
    }

    /* Subtitle */
    .subtitle {
        text-align: center;
        margin-bottom: 20px;
        font-size: 12px !important;
    }

    /* =========================
   TABLES
========================= */

    table {
        width: 100%;
        border-collapse: collapse;
        font-family: Arial, sans-serif !important;
        font-size: 12px !important;
        margin-top: 10px;
        background: #fff;
    }

    table th,
    table td {
        border: 1px solid #333;
        padding: 6px;
        font-size: 12px !important;
    }

    table th {
        background: #f3f4f6;
        font-weight: bold;
    }

    /* =========================
   PRINT BUTTON
========================= */

    .print-btn {
        margin-bottom: 15px;
    }

    /* =========================
   PRINT MODE (FINAL OUTPUT)
========================= */

    @media print {

        /* Hide EVERYTHING first */
        body * {
            visibility: hidden !important;
        }

        /* Show ONLY report area */
        .print-area,
        .print-area * {
            visibility: visible !important;
        }

        /* Position report at top-left */
        .print-area {
            position: absolute;
            left: 0;
            top: 0;
            width: 100% !important;
            margin: 0 !important;
            padding: 0.5in !important;
            box-shadow: none !important;
            border: none !important;
        }

        /* Ensure clean page */
        body {
            background: #fff !important;
        }

        .print-btn {
            display: none !important;
        }
    }

    /* =========================
   LGU OFFICIAL HEADER
========================= */

    .lgu-header {
        text-align: center;
        margin-bottom: 20px;
        font-family: Arial, sans-serif;
    }

    .lgu-line {
        font-size: 12px;
        font-weight: bold;
        letter-spacing: 0.5px;
    }

    .lgu-office {
        font-size: 12px;
        margin-top: 5px;
    }

    .report-title {
        font-size: 16px;
        font-weight: bold;
        margin-top: 10px;
    }

    .report-subtitle {
        font-size: 12px;
        margin-top: 3px;
        color: #333;
    }
</style>

<div class="d-flex justify-content-end">
    <button class="btn btn-success print-btn" onclick="window.print()">
        Print Report
    </button>
</div>

<div class="report-container print-area">

    <div class="lgu-header">

        <div class="lgu-line">
            REPUBLIC OF THE PHILIPPINES
        </div>

        <div class="lgu-line">
            PROVINCE OF ISABELA
        </div>

        <div class="lgu-line">
            MUNICIPALITY OF SAN MATEO
        </div>

        <div class="lgu-office">
            Office of Indigenous Peoples Affairs / IP Registry Unit
        </div>

        <br>

        <div class="report-title">
            INDIGENOUS PEOPLES & LAND REGISTRY REPORT
        </div>

        <div class="report-subtitle">
            Official Statistical Summary Report
        </div>

    </div>

    <!-- SUMMARY -->
    <div class="section">
        <h3>I. Summary Overview</h3>
        <table>
            <tr>
                <th>Indicator</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>Approved IP Records</td>
                <td><?= $totalIPs ?></td>
            </tr>
            <tr>
                <td>Registered Tribes</td>
                <td><?= $totalTribes ?></td>
            </tr>
            <tr>
                <td>Land Parcels</td>
                <td><?= $totalLandParcels ?></td>
            </tr>
            <tr>
                <td>GIS Tagged</td>
                <td><?= $gisTagged ?></td>
            </tr>
            <tr>
                <td>GIS Coverage</td>
                <td><?= $gisCoverage ?>%</td>
            </tr>
        </table>
    </div>

    <!-- TRIBES -->
    <div class="section">
        <h3>II. Tribal Distribution</h3>
        <table>
            <tr>
                <th>Tribe</th>
                <th>Population</th>
            </tr>
            <?php while ($t = mysqli_fetch_assoc($tribes)): ?>
                <tr>
                    <td><?= $t['tribe'] ?></td>
                    <td><?= $t['total'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    </div>

    <!-- STATUS -->
    <div class="section">
        <h3>III. Record Status</h3>
        <table>
            <tr>
                <th>Status</th>
                <th>Count</th>
            </tr>
            <?php while ($s = mysqli_fetch_assoc($status)): ?>
                <tr>
                    <td><?= strtoupper($s['status']) ?></td>
                    <td><?= $s['total'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    </div>

    <!-- LAND -->
    <div class="section">
        <h3>IV. Land Ownership</h3>
        <table>
            <tr>
                <th>Status</th>
                <th>Parcels</th>
            </tr>
            <?php while ($l = mysqli_fetch_assoc($land)): ?>
                <tr>
                    <td><?= ucwords($l['ownership_status']) ?></td>
                    <td><?= $l['total'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    </div>

    <!-- BARANGAY -->
    <div class="section">
        <h3>V. Top Barangays</h3>
        <table>
            <tr>
                <th>#</th>
                <th>Barangay</th>
                <th>Population</th>
            </tr>
            <?php $i = 1;
            while ($b = mysqli_fetch_assoc($barangays)): ?>
                <tr>
                    <td><?= $i++ ?></td>
                    <td><?= $b['barangay'] ?></td>
                    <td><?= $b['total'] ?></td>
                </tr>
            <?php endwhile; ?>
        </table>
    </div>

</div>

<?php require '../../includes/footer.php'; ?>