<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
require '../../../includes/db.php';

requireRole(['tribe_rep']);

$id = (int) ($_GET['id'] ?? 0);

if ($id <= 0) {
    header("Location: ../cases.php?error=invalid_id");
    exit;
}

$scopeTribe = mysqli_real_escape_string($conn, (string) current_user_tribe($conn));
$sql = "SELECT * FROM case_applications WHERE id = $id AND applicant_ip_group = '$scopeTribe' LIMIT 1";
$result = mysqli_query($conn, $sql);
$case = mysqli_fetch_assoc($result);

if (!$case) {
    header("Location: ../cases.php?error=not_found");
    exit;
}

$persons = [];
$pq = mysqli_query($conn, "SELECT * FROM case_persons_involved WHERE case_id = $id");
while ($row = mysqli_fetch_assoc($pq)) {
    $persons[] = $row;
}

$attachments = [];
$aq = mysqli_query($conn, "SELECT * FROM case_attachments WHERE case_id = $id ORDER BY id DESC");
while ($row = mysqli_fetch_assoc($aq)) {
    $attachments[] = $row;
}
?>

<div class="main-no-right">
    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h4 class="mb-0">Edit Case Application</h4> <small class="text-muted">Case ID: #<?= $case['id'] ?></small>
        </div> <a href="../cases.php" class="btn btn-light border btn-sm"> <i class="bi bi-arrow-left"></i> Back </a>
    </div>
    <form method="POST" action="../../../processes/case_edit_update.php" enctype="multipart/form-data">

        <input type="hidden" name="case_id" value="<?= $case['id'] ?>">

        <!-- ================= APPLICANT ================= -->
        <div class="card-box mb-3">
            <div class="section-title">Applicant Information</div>

            <div class="row g-2">

                <div class="col-md-6">
                    <input type="text" name="applicant_fullname" class="form-control"
                        value="<?= htmlspecialchars($case['applicant_fullname']) ?>" placeholder="Applicant Fullname" required>
                </div>

                <div class="col-md-3">
                    <select name="applicant_gender" class="form-select">
                        <option value="" <?= $case['applicant_gender'] == '' ? 'selected' : '' ?>>Select Gender</option>
                        <option value="Male" <?= $case['applicant_gender'] == 'Male' ? 'selected' : '' ?>>Male</option>
                        <option value="Female" <?= $case['applicant_gender'] == 'Female' ? 'selected' : '' ?>>Female</option>
                        <option value="Other" <?= $case['applicant_gender'] == 'Other' ? 'selected' : '' ?>>Other</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <input type="date" name="applicant_dob" class="form-control"
                        value="<?= $case['applicant_dob'] ?>">
                </div>

                <div class="col-md-4 mt-2">
                    <input type="text" name="applicant_contact" class="form-control"
                        value="<?= htmlspecialchars($case['applicant_contact']) ?>" placeholder="Applicant Contact">
                </div>

                <div class="col-md-4 mt-2">
                    <input type="email" name="applicant_email" class="form-control"
                        value="<?= htmlspecialchars($case['applicant_email']) ?>" placeholder="Applicant Email">
                </div>

                <div class="col-md-4 mt-2">
                    <input type="text" name="applicant_ip_group" class="form-control"
                        value="<?= htmlspecialchars($case['applicant_ip_group']) ?>" placeholder="Applicant IP Group">
                </div>

                <div class="col-12 mt-2">
                    <textarea name="applicant_address" class="form-control" placeholder="Applicant Address"><?= htmlspecialchars($case['applicant_address']) ?></textarea>
                </div>

            </div>
        </div>

        <!-- ================= REPRESENTATIVE ================= -->
        <div class="card-box mb-3">
            <div class="section-title">Representative</div>

            <div class="row g-2">

                <div class="col-md-6">
                    <input type="text" name="rep_name" class="form-control"
                        value="<?= htmlspecialchars($case['rep_name']) ?>" placeholder="Representative Fullname">
                </div>

                <div class="col-md-3">
                    <input type="text" name="rep_relationship" class="form-control"
                        value="<?= htmlspecialchars($case['rep_relationship']) ?>" placeholder="Relationship">
                </div>

                <div class="col-md-3">
                    <input type="text" name="rep_contact" class="form-control"
                        value="<?= htmlspecialchars($case['rep_contact']) ?>" placeholder="Representative Contact">
                </div>

            </div>

        </div>

        <!-- ================= CASE INFO ================= -->
        <div class="card-box mb-3">
            <div class="section-title">Case Information</div>

            <div class="row g-2">

                <div class="col-md-4">
                    <input type="text" name="case_title" class="form-control"
                        value="<?= htmlspecialchars($case['case_title']) ?>" placeholder="Case Title" required>
                </div>

                <div class="col-md-4">
                    <select name="case_type" class="form-select" required>
                        <option value="" <?= $case['case_type'] == '' ? 'selected' : '' ?>>Select Case Type</option>
                        <?php
                        $types = ['land_dispute', 'ancestral_domain_conflict', 'cultural_rights_violation', 'discrimination', 'environmental_issue', 'other'];
                        foreach ($types as $t): ?>
                            <option value="<?= $t ?>" <?= $case['case_type'] == $t ? 'selected' : '' ?>>
                                <?= ucwords(str_replace('_', ' ', $t)) ?>
                            </option>
                        <?php endforeach; ?>
                    </select>
                </div>

                <div class="col-md-4 mt-2">
                    <input type="date" name="incident_date" class="form-control" value="<?= $case['incident_date'] ?>">
                </div>

                <div class="col-12 mt-2">
                    <textarea name="case_description" class="form-control" placeholder="Case Description"><?= htmlspecialchars($case['case_description']) ?></textarea>
                </div>

            </div>
        </div>

        <!-- ========================= LOCATION ========================= -->
        <div class="card-box mb-3">
            <div class="section-title">Location</div>
            <div class="row g-2">
                <div class="col-md-4"> <input type="text" name="incident_barangay" class="form-control" value="<?= htmlspecialchars($case['incident_barangay']) ?>" placeholder="Incident Barangay"> </div>
                <div class="col-md-4"> <input type="text" name="incident_municipality" class="form-control" value="<?= htmlspecialchars($case['incident_municipality']) ?>" placeholder="Incident Municipality"> </div>
                <div class="col-md-4"> <input type="text" name="incident_province" class="form-control" value="<?= htmlspecialchars($case['incident_province']) ?>" placeholder="Incident Province"> </div>
            </div>
        </div>

        <!-- ================= PERSONS ================= -->
        <div class="card-box mb-3">
            <div class="section-title">Persons Involved</div>

            <div id="personsWrapper">
                <?php if (empty($persons)): ?>
                    <div class="text-muted">No persons involved added yet.</div>
                <?php else: ?>

                    <?php foreach ($persons as $p): ?>
                        <div class="row g-2 mb-2">

                            <div class="col-md-5">
                                <input type="text" name="person_name[]" class="form-control"
                                    value="<?= htmlspecialchars($p['person_name']) ?>" placeholder="Person Name">
                            </div>

                            <div class="col-md-4">
                                <select name="person_role[]" class="form-select">
                                    <option value="Complainant" <?= $p['role'] == 'Complainant' ? 'selected' : '' ?>>Complainant</option>
                                    <option value="Respondent" <?= $p['role'] == 'Respondent' ? 'selected' : '' ?>>Respondent</option>
                                    <option value="Witness" <?= $p['role'] == 'Witness' ? 'selected' : '' ?>>Witness</option>
                                </select>
                            </div>

                            <div class="col-md-3">
                                <input type="text" name="person_contact[]" class="form-control"
                                    value="<?= htmlspecialchars($p['contact']) ?>" placeholder="Person Contact">
                            </div>

                        </div>
                    <?php endforeach; ?>
                    <button type="button"
                        class="btn btn-sm btn-outline-primary my-2"
                        onclick="addPersonRow()">

                        <i class="bi bi-plus-circle"></i> Add Person
                    </button>
                <?php endif; ?>
            </div>
        </div>

        <!-- ================= ATTACHMENTS ================= -->
        <div class="card-box mb-3">
            <div class="section-title">Attachments</div>

            <div class="row g-2 mb-3">

                <?php foreach ($attachments as $file):
                    $ext = strtolower(pathinfo($file['file_name'], PATHINFO_EXTENSION));
                ?>

                    <div class="col-md-6">

                        <div class="border rounded p-2 d-flex justify-content-between align-items-center">

                            <div>
                                <div class="small fw-semibold"><?= htmlspecialchars($file['file_name']) ?></div>
                                <div class="text-muted" style="font-size:12px;"><?= strtoupper($ext) ?></div>
                            </div>

                            <div>
                                <input type="checkbox" name="delete_attachments[]" value="<?= $file['id'] ?>" class="form-check-input">
                                <label class="small">Remove</label>
                            </div>

                        </div>

                    </div>

                <?php endforeach; ?>

            </div>

            <input type="file" name="attachments[]" multiple class="form-control">

        </div>

        <!-- SUBMIT -->
        <div class="text-end">
            <button class="btn btn-primary">Update Case</button>
        </div>

    </form>

</div>

<script>
    function addPersonRow() {

        const wrapper = document.getElementById('personsWrapper');

        const row = document.createElement('div');
        row.className = "row g-2 person-row mb-2";

        row.innerHTML = `
        <div class="col-md-5">
            <input type="text" name="person_name[]" class="form-control" placeholder="Full Name">
        </div>

        <div class="col-md-4">
            <select name="person_role[]" class="form-select">
                <option value="Complainant">Complainant</option>
                <option value="Respondent">Respondent</option>
                <option value="Witness">Witness</option>
            </select>
        </div>

        <div class="col-md-3">
            <input type="text" name="person_contact[]" class="form-control" placeholder="Contact (optional)">
        </div>
    `;

        wrapper.appendChild(row);
    }
</script>


<?php require '../../../includes/case_participant_fields.php'; require '../../../includes/footer.php'; ?>
