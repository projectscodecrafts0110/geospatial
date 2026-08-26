<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
require '../../../includes/db.php';

requireRole(['admin']);
?>

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div>
            <h4 class="mb-0">Create Case Application</h4>
            <small class="text-muted">Full intake form for IP case applications</small>
        </div>

        <a href="../cases.php" class="btn btn-light border btn-sm">
            <i class="bi bi-arrow-left"></i> Back
        </a>
    </div>

    <!-- IMPORTANT: enctype added -->
    <form method="POST"
        action="../../../processes/case_application_create.php"
        enctype="multipart/form-data">

        <!-- =========================
            I. APPLICANT INFORMATION
        ========================== -->
        <div class="card-box mb-3">

            <div class="section-title">Applicant Information</div>

            <div class="row g-2">

                <div class="col-md-6">
                    <label>Full Name *</label>
                    <input type="text" name="applicant_fullname" class="form-control" required>
                </div>

                <div class="col-md-3">
                    <label>Gender</label>
                    <select name="applicant_gender" class="form-select">
                        <option value="">Select</option>
                        <option value="Male">Male</option>
                        <option value="Female">Female</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="col-md-3">
                    <label>Date of Birth</label>
                    <input type="date" name="applicant_dob" class="form-control">
                </div>

                <div class="col-md-4 mt-2">
                    <label>Contact</label>
                    <input type="text" name="applicant_contact" class="form-control">
                </div>

                <div class="col-md-4 mt-2">
                    <label>Email</label>
                    <input type="email" name="applicant_email" class="form-control">
                </div>

                <div class="col-md-4 mt-2">
                    <label>IP Group</label>
                    <input type="text" name="applicant_ip_group" class="form-control">
                </div>

                <div class="col-12 mt-2">
                    <label>Address</label>
                    <textarea name="applicant_address" class="form-control" rows="2"></textarea>
                </div>

            </div>
        </div>

        <!-- =========================
            II. REPRESENTATIVE INFO
        ========================== -->
        <div class="card-box mb-3">

            <div class="section-title">Representative (Optional)</div>

            <div class="row g-2">

                <div class="col-md-6">
                    <label>Name</label>
                    <input type="text" name="rep_name" class="form-control">
                </div>

                <div class="col-md-3">
                    <label>Relationship</label>
                    <input type="text" name="rep_relationship" class="form-control">
                </div>

                <div class="col-md-3">
                    <label>Contact</label>
                    <input type="text" name="rep_contact" class="form-control">
                </div>

            </div>
        </div>

        <!-- =========================
            III. CASE INFORMATION
        ========================== -->
        <div class="card-box mb-3">

            <div class="section-title">Case Information</div>

            <div class="row g-2">

                <div class="col-md-6">
                    <label>Case Title</label>
                    <input type="text" name="case_title" class="form-control" required>
                </div>

                <div class="col-md-6">
                    <label>Case Type</label>
                    <select name="case_type" class="form-select" required>
                        <option value="land_dispute">Land Dispute</option>
                        <option value="ancestral_domain_conflict">Ancestral Domain Conflict</option>
                        <option value="cultural_rights_violation">Cultural Rights Violation</option>
                        <option value="discrimination">Discrimination</option>
                        <option value="environmental_issue">Environmental Issue</option>
                        <option value="other">Other</option>
                    </select>
                </div>

                <div class="col-md-6 mt-2">
                    <label>Other Case Type</label>
                    <input type="text" name="case_type_other" class="form-control">
                </div>

                <div class="col-md-6 mt-2">
                    <label>Incident Date</label>
                    <input type="date" name="incident_date" class="form-control">
                </div>

                <div class="col-12 mt-2">
                    <label>Description</label>
                    <textarea name="case_description" class="form-control" rows="3"></textarea>
                </div>

            </div>
        </div>

        <!-- =========================
            IV. LOCATION
        ========================== -->
        <div class="card-box mb-3">

            <div class="section-title">Incident Location</div>

            <div class="row g-2">

                <div class="col-md-4">
                    <input type="text" name="incident_barangay" class="form-control" placeholder="Barangay">
                </div>

                <div class="col-md-4">
                    <input type="text" name="incident_municipality" class="form-control" placeholder="Municipality">
                </div>

                <div class="col-md-4">
                    <input type="text" name="incident_province" class="form-control" placeholder="Province">
                </div>

            </div>
        </div>

        <!-- =========================
    V. PERSONS INVOLVED
========================= -->
        <div class="card-box mb-3">

            <div class="section-title">Persons Involved</div>

            <div id="personsWrapper">

                <!-- DEFAULT ROW -->
                <div class="row g-2 person-row mb-2">

                    <div class="col-md-5">
                        <input type="text"
                            name="person_name[]"
                            class="form-control"
                            placeholder="Full Name">
                    </div>

                    <div class="col-md-4">
                        <select name="person_role[]" class="form-select">
                            <option value="Complainant">Complainant</option>
                            <option value="Respondent">Respondent</option>
                            <option value="Witness">Witness</option>
                        </select>
                    </div>

                    <div class="col-md-3">
                        <input type="text"
                            name="person_contact[]"
                            class="form-control"
                            placeholder="Contact (optional)">
                    </div>

                </div>

            </div>

            <button type="button"
                class="btn btn-sm btn-outline-primary mt-2"
                onclick="addPersonRow()">

                <i class="bi bi-plus-circle"></i> Add Person
            </button>

        </div>

        <!-- =========================
            VI. ATTACHMENTS (NEW)
        ========================== -->
        <div class="card-box mb-3">

            <div class="section-title">Attachments</div>

            <input type="file"
                name="attachments[]"
                class="form-control"
                multiple
                accept=".jpg,.jpeg,.png,.pdf,.doc,.docx">

            <small class="text-muted">
                You can upload multiple files (images, PDFs, documents).
            </small>

        </div>

        <!-- STATUS -->
        <input type="hidden" name="status" value="Pending">

        <!-- SUBMIT -->
        <div class="text-end">
            <button type="submit" class="btn btn-success">
                <i class="bi bi-check-circle"></i> Submit Case
            </button>
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
