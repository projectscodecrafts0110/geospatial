<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['tribe_leader']);
require '../../includes/db.php';

$user_id = $_SESSION['user_id'];

$get_user_tribe = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT tribe FROM user_tribes WHERE user_id = $user_id"
));

$user_tribe = $get_user_tribe['tribe'];

/* =========================
   SUMMARY STATS
========================= */

$totalRecords = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c 
     FROM ip_records 
     WHERE status='approved'"
))['c'];

$maleCount = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c 
     FROM ip_records 
     WHERE status='approved' 
     AND gender='Male'"
))['c'];

$femaleCount = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c 
     FROM ip_records 
     WHERE status='approved' 
     AND gender='Female'"
))['c'];

$avgAge = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT AVG(TIMESTAMPDIFF(YEAR, birthdate, CURDATE())) as avg_age
     FROM ip_records
     WHERE status='approved'
     AND birthdate IS NOT NULL"
))['avg_age'];

$avgAge = round($avgAge ?? 0);

$approvedToday = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT COUNT(*) c 
     FROM ip_records 
     WHERE status='approved' 
     AND DATE(updated_at)=CURDATE()"
))['c'];

/* =========================
   RECORDS
========================= */

$records = mysqli_query($conn, "
    SELECT id,
           reference_code,
           full_name,
           gender,
           birthdate,
           TIMESTAMPDIFF(YEAR, birthdate, CURDATE()) as age,
           tribe,
           sitio,
           barangay,
           municipality,
           status
    FROM ip_records
    WHERE status='approved'
    ORDER BY id DESC
    LIMIT 10
");
?>

<!-- =========================
   PRINT STYLES
========================= -->
<style>
    body {
        color: #000;
    }

    /* =========================
   PRINT RULES
========================= */
    @media print {

        /* Hide UI elements ONLY */
        .sidebar,
        .topbar,
        .right-panel,
        .btn,
        button,
        .no-print {
            display: none !important;
        }

        /* Keep everything clean */
        body {
            font-family: Arial, sans-serif !important;
            font-size: 12px !important;
            color: #000 !important;
            background: #fff !important;
        }

        .card-box {
            box-shadow: none !important;
            border: 1px solid #ccc !important;
            page-break-inside: avoid;
        }

        @page {
            margin: 12mm;
        }
    }
</style>

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">

        <div>
            <h4 class="mb-1">Approvals Dashboard</h4>
            <small class="text-muted">Review approved IP records</small>
        </div>

        <button class="btn btn-success btn-sm" onclick="window.print()">
            <i class="bi bi-printer"></i> Print Report
        </button>

    </div>

    <!-- SUMMARY CARDS -->
    <div class="row g-3">

        <div class="col-md-3">
            <div class="card-box">
                <h6 class="text-muted">Records Approved</h6>
                <h3><?= $totalRecords ?></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">
                <h6 class="text-muted">Male</h6>
                <h3><?= $maleCount ?></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">
                <h6 class="text-muted">Female</h6>
                <h3><?= $femaleCount ?></h3>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card-box">
                <h6 class="text-muted">Avg Age</h6>
                <h3><?= $avgAge ?></h3>
            </div>
        </div>

    </div>

    <!-- INSIGHTS -->
    <div class="card-box mt-3">

        <h6 class="mb-3">Approval Insights</h6>

        <?php
        $totalGender = $maleCount + $femaleCount;
        $malePct = $totalGender ? ($maleCount / $totalGender) * 100 : 0;
        $femalePct = $totalGender ? ($femaleCount / $totalGender) * 100 : 0;
        ?>

        <div class="row">

            <div class="col-md-6">

                <p class="mb-1">Gender Distribution</p>

                <div class="progress mb-2" style="height:10px;">
                    <div class="progress-bar bg-primary" style="width:<?= $malePct ?>%"></div>
                    <div class="progress-bar bg-danger" style="width:<?= $femalePct ?>%"></div>
                </div>

                <small>Male: <?= $maleCount ?> | Female: <?= $femaleCount ?></small>

            </div>

            <div class="col-md-6">

                <p class="mb-1">System Activity</p>

                <div class="progress" style="height:10px;">
                    <div class="progress-bar bg-success" style="width:70%"></div>
                </div>

                <small><?= $approvedToday ?> approved today</small>

            </div>

        </div>

    </div>

    <!-- TABLE -->
    <div class="card-box mt-3">
        <div class="d-flex justify-content-between">
            <h6 class="mb-3">Details of Records Approved</h6>
            <small>Tribe: <?= $user_tribe ?></small>
        </div>
        <div class="table-responsive">

            <table class="table table-hover align-middle">

                <thead class="table-light">
                    <tr>
                        <th>Ref</th>
                        <th>Name</th>
                        <th>Gender</th>
                        <th>Age</th>
                        <th>Tribe</th>
                        <th>Location</th>
                    </tr>
                </thead>

                <tbody>
                    <?php while ($r = mysqli_fetch_assoc($records)): ?>
                        <tr>
                            <td data-label="Reference Code"><?= $r['reference_code'] ?></td>
                            <td data-label="Full Name"><?= htmlspecialchars($r['full_name']) ?></td>
                            <td data-label="Gender"><?= $r['gender'] ?></td>
                            <td data-label="Age"><?= $r['age'] ? $r['age'] . ' yrs' : 'N/A' ?></td>
                            <td data-label="Tribe"><?= htmlspecialchars($r['tribe']) ?></td>
                            <td data-label="Location"><?= $r['sitio'] ?>, <?= $r['barangay'] ?>, <?= $r['municipality'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>

            </table>

        </div>

    </div>

</div>

<?php require '../../includes/footer.php'; ?>