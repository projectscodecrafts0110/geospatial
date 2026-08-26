<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
requireRole(['tribe_rep']);
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

$role = $_SESSION['role'];
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-start mb-3">

        <div>
            <h4 class="mb-1">Edit Record</h4>
            <small class="text-muted">
                <?= htmlspecialchars($record['reference_code']) ?>
            </small>
        </div>

        <a href="../records.php" class="btn btn-light btn-sm border">
            <i class="bi bi-arrow-left"></i> Back
        </a>

    </div>

    <form action="../../../processes/records_action.php" method="POST">

        <input type="hidden" name="id" value="<?= $record['id'] ?>">

        <div class="row g-3">

            <!-- LEFT FORM -->
            <div class="col-md-6">

                <div class="card-box">

                    <h6 class="mb-3">Personal Information</h6>

                    <div class="mb-2">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="full_name"
                            class="form-control"
                            value="<?= htmlspecialchars($record['full_name']) ?>"
                            <?= ($role == 'staff') ? '' : '' ?>>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Tribe</label>
                        <input type="text" name="tribe"
                            class="form-control"
                            value="<?= htmlspecialchars($record['tribe']) ?>">
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Barangay</label>
                            <input type="text" name="barangay"
                                class="form-control"
                                value="<?= htmlspecialchars($record['barangay']) ?>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Municipality</label>
                            <input type="text" name="municipality"
                                class="form-control"
                                value="<?= htmlspecialchars($record['municipality']) ?>">
                        </div>
                    </div>

                </div>

            </div>

            <!-- RIGHT FORM -->
            <div class="col-md-6">

                <div class="card-box">

                    <h6 class="mb-3">System Data</h6>

                    <!-- STATUS CONTROL -->
                    <div class="mb-2">
                        <label class="form-label">Status</label>

                        <select name="status" class="form-select">

                            <option value="for_assessment"
                                <?= $record['status'] == 'for_assessment' ? 'selected' : '' ?>>
                                For Assessment
                            </option>

                        </select>

                    </div>

                    <!-- GIS (ONLY ASSIGN IF ADMIN OR ASSESSOR) -->
                    <div class="row">

                        <div class="col-md-6">
                            <label class="form-label">Latitude</label>
                            <input type="text" name="latitude"
                                class="form-control"
                                value="<?= $record['latitude'] ?>">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Longitude</label>
                            <input type="text" name="longitude"
                                class="form-control"
                                value="<?= $record['longitude'] ?>">
                        </div>

                    </div>

                </div>

                <!-- ACTIONS -->
                <div class="card-box mt-3">

                    <button type="submit" name="update_record" class="btn btn-success w-100">
                        <i class="bi bi-save"></i> Save Changes
                    </button>

                </div>

            </div>

        </div>

    </form>
    <?php
    include '../../../includes/toast.php';
    ?>
</div>

<?php require '../../../includes/footer.php'; ?>
