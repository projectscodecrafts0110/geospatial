<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
requireRole(['tribe_rep']);
require '../../../includes/db.php';

$role = $_SESSION['role'];
$user_id = $_SESSION['user_id'];

$get_user_tribe = mysqli_fetch_assoc(mysqli_query(
    $conn,
    "SELECT tribe FROM user_tribes WHERE user_id = $user_id"
));

$user_tribe = $get_user_tribe['tribe'];
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-start mb-3">

        <div>
            <h4 class="mb-1">Create Record</h4>
        </div>

        <a href="../records.php" class="btn btn-light btn-sm border">
            <i class="bi bi-arrow-left"></i> Back
        </a>

    </div>

    <form action="../../../processes/records_action.php" method="POST">

        <div class="row g-3">

            <!-- LEFT FORM -->
            <div class="col-md-6">

                <div class="card-box">

                    <h6 class="mb-3">Personal Information</h6>

                    <div class="mb-2">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="full_name"
                            class="form-control">
                    </div>

                    <div class="row mb-2">
                        <div class="col-6">
                            <label class="form-label">Gender</label>
                            <select name="gender" class="form-select" required>
                                <option value="" selected disabled>Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label class="form-label">Birthdate</label>
                            <input type="date" class="form-control" name="birthdate">
                        </div>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Tribe</label>
                        <input type="text" name="tribe"
                            class="form-control" value="<?= $user_tribe ?>" readonly>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <label class="form-label">Sitio</label>
                            <input type="text" name="sitio"
                                class="form-control">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Barangay</label>
                            <input type="text" name="barangay"
                                class="form-control">
                        </div>

                        <div class="col-md-12">
                            <label class="form-label">Municipality</label>
                            <input type="text" name="municipality"
                                class="form-control">
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

                            <option value="for_assessment">
                                For Assessment
                            </option>

                        </select>

                    </div>

                    <!-- GIS (ONLY ASSIGN IF ADMIN OR ASSESSOR) -->
                    <div class="row">

                        <div class="col-md-6">
                            <label class="form-label">Latitude</label>
                            <input type="text" name="latitude"
                                class="form-control">
                        </div>

                        <div class="col-md-6">
                            <label class="form-label">Longitude</label>
                            <input type="text" name="longitude"
                                class="form-control">
                        </div>

                    </div>

                </div>

                <!-- ACTIONS -->
                <div class="card-box mt-3">

                    <button type="submit" name="create_record" class="btn btn-success w-100">
                        <i class="bi bi-save"></i> Submit
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