<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
requireRole(['admin', 'staff', 'assessor', 'tribe_leader']);
require '../../../includes/db.php';

$id = isset($_GET['id']) ? (int) $_GET['id'] : 0;

$scopeTribe = mysqli_real_escape_string($conn, (string) current_user_tribe($conn));
$sql = "SELECT * FROM ip_records WHERE id = $id AND tribe = '$scopeTribe'";
$result = mysqli_query($conn, $sql);
$record = mysqli_fetch_assoc($result);

if (!$record) {
    header("Location: ../records.php?error=not_found");
    exit;
}
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-start mb-3">

        <div>
            <h4 class="mb-1">
                <?= htmlspecialchars($record['full_name']) ?>
            </h4>

            <small class="text-muted">
                Reference: <?= e($record['reference_code'] ?? 'N/A') ?>
            </small>
        </div>

        <a href="../records.php" class="btn btn-light btn-sm border">
            <i class="bi bi-arrow-left"></i> Back
        </a>

    </div>

    <div class="row g-3">

        <!-- LEFT: RECORD INFO -->
        <div class="col-md-5">

            <div class="card-box">

                <h6 class="mb-3">Record Information</h6>

                <p class="mb-1"><b>Full Name:</b> <?= htmlspecialchars($record['full_name']) ?></p>
                <p class="mb-1"><b>Gender:</b> <?= htmlspecialchars($record['gender']) ?></p>
                <p class="mb-1"><b>Birthdate:</b> <?= htmlspecialchars($record['birthdate']) ?></p>
                <p class="mb-1"><b>Tribe:</b> <?= e($record['tribe']) ?></p>
                <p class="mb-1"><b>Sitio:</b> <?= e($record['sitio']) ?></p>
                <p class="mb-1"><b>Barangay:</b> <?= e($record['barangay']) ?></p>
                <p class="mb-1"><b>Municipality:</b> <?= e($record['municipality']) ?></p>

                <hr>

                <p class="mb-1">
                    <b>Status:</b>
                    <span class="badge bg-primary">
                        <?= strtoupper(str_replace('_', ' ', $record['status'])) ?>
                    </span>
                </p>

                <hr>
                <div class="d-grid gap-2 mt-2">
                    <?php if (in_array($record['status'], ['for_assessment','rejected'], true)): ?>
                        <form method="post" action="../../../processes/records_for_approval.php" onsubmit="return confirm('Send this record to FOR APPROVAL stage?')"><input type="hidden" name="id" value="<?= (int) $record['id'] ?>"><button class="btn btn-primary btn-sm w-100"><i class="bi bi-send"></i> Send for Approval</button></form>
                    <?php endif; ?>
                    <?php if ($record['status'] === 'for_assessment'): ?>
                        <button class="btn btn-danger btn-sm" disabled title="Only administrators can reject records"><i class="bi bi-x-circle"></i> Reject</button>
                    <?php endif; ?>
                </div>
            </div>

            <!-- GIS STATUS -->
            <div class="card-box mt-3">

                <h6 class="mb-2">Geospatial Data</h6>

                <?php if (!empty($record['latitude']) && !empty($record['longitude'])): ?>

                    <div class="text-success small mb-2">
                        ✔ Coordinates Available
                    </div>

                    <p class="small mb-0">
                        Lat: <?= e($record['latitude']) ?><br>
                        Lng: <?= e($record['longitude']) ?>
                    </p>

                <?php else: ?>

                    <div class="text-warning small">
                        ⚠ No GIS data available
                    </div>

                <?php endif; ?>

            </div>

        </div>

        <!-- RIGHT: MAP + TIMELINE -->
        <div class="col-md-7">

            <!-- MAP -->
            <div class="card-box mb-3" style="height: 320px;">

                <h6 class="mb-2">Location Map</h6>

                <div id="map" style="height: 250px; border-radius: 8px;"></div>

            </div>

            <!-- TIMELINE -->
            <div class="card-box">

                <h6 class="mb-3">Record Timeline</h6>

                <div class="small">

                    <div class="mb-2">
                        🟢 Created by Staff<br>
                        <span class="text-muted">Initial encoding of record</span>
                    </div>

                    <div class="mb-2">
                        🟡 Under Assessment<br>
                        <span class="text-muted">Assessor reviewing GIS data</span>
                    </div>

                    <div class="mb-2">
                        🔵 Pending Approval<br>
                        <span class="text-muted">IP Leader validation stage</span>
                    </div>

                </div>

            </div>

        </div>

    </div>
</div>

<!-- LEAFLET MAP SCRIPT -->
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<script>
    var lat = <?= !empty($record['latitude']) ? $record['latitude'] : 18.461 ?>;
    var lng = <?= !empty($record['longitude']) ? $record['longitude'] : 120.94 ?>;

    var map = L.map('map').setView([lat, lng], 13);

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; OpenStreetMap'
    }).addTo(map);

    L.marker([lat, lng]).addTo(map)
        .bindPopup("<?= htmlspecialchars($record['full_name']) ?>");
</script>
<?php require '../../../includes/footer.php'; ?>
