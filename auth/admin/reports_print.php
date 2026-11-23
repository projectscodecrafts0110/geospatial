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
$totalFamilies=(int)$conn->query('SELECT COUNT(*) FROM ip_families')->fetch_row()[0];
$totalMembers=(int)$conn->query('SELECT COUNT(*) FROM ip_family_members')->fetch_row()[0];
$familiesWithSpouse=(int)$conn->query("SELECT COUNT(DISTINCT family_id) FROM ip_family_members WHERE member_role='spouse'")->fetch_row()[0];
$familyLinkedRecords=(int)$conn->query('SELECT COUNT(*) FROM ip_records WHERE family_member_id IS NOT NULL')->fetch_row()[0];
$familyLinkedCases=(int)$conn->query('SELECT COUNT(DISTINCT cp.case_id) FROM case_persons_involved cp JOIN ip_family_members fm ON fm.id=cp.family_member_id')->fetch_row()[0];
$totalCases=(int)$conn->query('SELECT COUNT(*) FROM case_applications')->fetch_row()[0];
$activeCases=(int)$conn->query("SELECT COUNT(*) FROM case_applications WHERE status NOT IN ('resolved','closed')")->fetch_row()[0];
$resolvedCases=(int)$conn->query("SELECT COUNT(*) FROM case_applications WHERE status IN ('resolved','closed')")->fetch_row()[0];
$totalTax=(int)$conn->query('SELECT COUNT(*) FROM tax_declarations')->fetch_row()[0];
$currentTax=(int)$conn->query("SELECT COUNT(*) FROM tax_declarations WHERE declaration_status='current'")->fetch_row()[0];
$linkedTax=(int)$conn->query('SELECT COUNT(*) FROM tax_declarations WHERE parcel_id IS NOT NULL')->fetch_row()[0];
$parcelGeometry=(int)$conn->query("SELECT COUNT(*) FROM ip_land_parcels WHERE boundary_geojson IS NOT NULL OR (latitude IS NOT NULL AND longitude IS NOT NULL)")->fetch_row()[0];
$familyAffiliations=$conn->query("SELECT COALESCE(a.name,'Not specified') label,COUNT(*) total FROM ip_families f LEFT JOIN ip_affiliations a ON a.id=f.affiliation_id GROUP BY a.id,a.name ORDER BY total DESC,label")->fetch_all(MYSQLI_ASSOC);
$familyLocations=$conn->query("SELECT COALESCE(NULLIF(f.barangay,''),'Not specified') barangay,COUNT(DISTINCT f.id) families,COUNT(m.id) members FROM ip_families f LEFT JOIN ip_family_members m ON m.family_id=f.id GROUP BY COALESCE(NULLIF(f.barangay,''),'Not specified') ORDER BY families DESC,barangay")->fetch_all(MYSQLI_ASSOC);
$memberSex=$conn->query("SELECT COALESCE(sex,'Not specified') label,COUNT(*) total FROM ip_family_members GROUP BY sex ORDER BY total DESC")->fetch_all(MYSQLI_ASSOC);
$caseSummary=$conn->query("SELECT status,COUNT(*) total FROM case_applications GROUP BY status ORDER BY FIELD(status,'pending','ongoing','under_review','resolved','closed')")->fetch_all(MYSQLI_ASSOC);
$taxSummary=$conn->query("SELECT declaration_status,COUNT(*) total,COALESCE(SUM(total_market_value),0) market_value,COALESCE(SUM(total_assessed_value),0) assessed_value FROM tax_declarations GROUP BY declaration_status ORDER BY FIELD(declaration_status,'current','historical','cancelled')")->fetch_all(MYSQLI_ASSOC);

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
            PROVINCE OF ILOCOS NORTE
        </div>

        <div class="lgu-line">
            MUNICIPALITY OF ADAMS
        </div>

        <div class="lgu-office">
            Office of Indigenous Peoples Affairs / IP Registry Unit
        </div>

        <br>

        <div class="report-title">
            INDIGENOUS PEOPLES & LAND REGISTRY REPORT
        </div>

        <div class="report-subtitle">
            Official Statistical Summary Report<br>
            Generated <?=e(date('F j, Y, g:i a'))?>
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
            <tr><td>IP Families</td><td><?=number_format($totalFamilies)?></td></tr>
            <tr><td>Family Members</td><td><?=number_format($totalMembers)?></td></tr>
            <tr><td>Total Cases</td><td><?=number_format($totalCases)?></td></tr>
            <tr><td>Tax Declarations</td><td><?=number_format($totalTax)?></td></tr>
        </table>
    </div>

    <div class="section">
        <h3>II. IP Family and Household Profile</h3>
        <table><tr><th>Indicator</th><th>Count</th><th>Coverage / Share</th></tr>
            <tr><td>Families with a recorded spouse</td><td><?=number_format($familiesWithSpouse)?></td><td><?=$totalFamilies?round($familiesWithSpouse/$totalFamilies*100,1):0?>%</td></tr>
            <tr><td>Members linked to approved or legacy IP records</td><td><?=number_format($familyLinkedRecords)?></td><td><?=$totalMembers?round($familyLinkedRecords/$totalMembers*100,1):0?>%</td></tr>
            <tr><td>Cases explicitly linked to family members</td><td><?=number_format($familyLinkedCases)?></td><td><?=$totalCases?round($familyLinkedCases/$totalCases*100,1):0?>%</td></tr>
        </table>
        <table><tr><th>Affiliation</th><th>Families</th><th>Share</th></tr><?php foreach($familyAffiliations as$r):?><tr><td><?=e($r['label'])?></td><td><?=number_format($r['total'])?></td><td><?=$totalFamilies?round($r['total']/$totalFamilies*100,1):0?>%</td></tr><?php endforeach;?></table>
        <table><tr><th>Member sex</th><th>Members</th></tr><?php foreach($memberSex as$r):?><tr><td><?=e($r['label'])?></td><td><?=number_format($r['total'])?></td></tr><?php endforeach;?></table>
    </div>

    <div class="section">
        <h3>III. Family Location Distribution</h3>
        <table><tr><th>#</th><th>Barangay</th><th>Families</th><th>Members</th></tr><?php foreach($familyLocations as$i=>$r):?><tr><td><?=$i+1?></td><td><?=e($r['barangay'])?></td><td><?=number_format($r['families'])?></td><td><?=number_format($r['members'])?></td></tr><?php endforeach;?></table>
    </div>

    <div class="section">
        <h3>IV. Case Management</h3>
        <table><tr><th>Status</th><th>Cases</th></tr><?php foreach($caseSummary as$r):?><tr><td><?=e(ucwords(str_replace('_',' ',$r['status'])))?></td><td><?=number_format($r['total'])?></td></tr><?php endforeach;?><tr><th>Active workload</th><th><?=number_format($activeCases)?></th></tr><tr><th>Resolved / closed</th><th><?=number_format($resolvedCases)?></th></tr></table>
    </div>

    <div class="section">
        <h3>V. Property, GIS and Tax Declarations</h3>
        <table><tr><th>Indicator</th><th>Count</th><th>Coverage</th></tr><tr><td>Parcels with point or boundary geometry</td><td><?=number_format($parcelGeometry)?></td><td><?=$totalLandParcels?round($parcelGeometry/$totalLandParcels*100,1):0?>%</td></tr><tr><td>Tax declarations linked to parcels</td><td><?=number_format($linkedTax)?></td><td><?=$totalTax?round($linkedTax/$totalTax*100,1):0?>%</td></tr><tr><td>Current tax declarations</td><td><?=number_format($currentTax)?></td><td><?=$totalTax?round($currentTax/$totalTax*100,1):0?>%</td></tr></table>
        <table><tr><th>Declaration status</th><th>Records</th><th>Market value</th><th>Assessed value</th></tr><?php foreach($taxSummary as$r):?><tr><td><?=e(ucfirst($r['declaration_status']))?></td><td><?=number_format($r['total'])?></td><td class="text-end"><?=number_format((float)$r['market_value'],2)?></td><td class="text-end"><?=number_format((float)$r['assessed_value'],2)?></td></tr><?php endforeach;?></table>
    </div>

    <!-- TRIBES -->
    <div class="section">
        <h3>VI. Legacy Approved-Record Tribal Distribution</h3>
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
        <h3>VII. Legacy Record Status</h3>
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
        <h3>VIII. Land Ownership</h3>
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
        <h3>IX. Legacy Approved-Record Barangays</h3>
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
