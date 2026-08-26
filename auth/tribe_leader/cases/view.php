<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
require '../../../includes/db.php';
require_once '../../../includes/case_workflow.php';

requireRole(['tribe_leader']);

$id = (int) ($_GET['id'] ?? 0);

if ($id <= 0) {
    header("Location: cases.php?error=invalid_id");
    exit;
}

// ==========================
// FETCH CASE
// ==========================
$scopeTribe = mysqli_real_escape_string($conn, (string) current_user_tribe($conn));
$sql = "SELECT * FROM case_applications WHERE id = $id AND applicant_ip_group = '$scopeTribe' LIMIT 1";
$result = mysqli_query($conn, $sql);
$case = mysqli_fetch_assoc($result);

if (!$case) {
    header("Location: cases.php?error=not_found");
    exit;
}
$allowedStatusOptions = case_available_statuses((string) $_SESSION['role'], (string) $case['case_type'], (string) $case['status']);

$assignees = [];

$assigneeQuery = mysqli_query(
    $conn,
    "SELECT id, full_name, role
     FROM users
     WHERE role IN ('admin','staff','assessor','tribe_leader', 'tribe_rep')
     AND status='active'
     ORDER BY full_name ASC"
);

while ($row = mysqli_fetch_assoc($assigneeQuery)) {
    $assignees[] = $row;
}
?>

<div class="main-no-right">

    <!-- HEADER -->
    <div class="d-flex justify-content-between align-items-center mb-3">

        <div>
            <h4 class="mb-1"><?= htmlspecialchars($case['case_title']) ?></h4>
            <small class="text-muted">
                Case ID: #<?= $case['id'] ?>
            </small>
        </div>

        <a href="../cases.php" class="btn btn-light border btn-sm">
            <i class="bi bi-arrow-left"></i> Back
        </a>

    </div>

    <!-- STATUS -->
    <div class="card-box d-flex justify-content-between align-items-center mb-1">

        <?php
        $status = $case['status'];

        $badge = "bg-secondary";
        if ($status == "pending") $badge = "bg-secondary";
        if ($status == "ongoing") $badge = "bg-primary";
        if ($status == "under_review") $badge = "bg-warning text-dark";
        if ($status == "resolved") $badge = "bg-success";
        if ($status == "closed") $badge = "bg-dark";
        ?>

        <span class="badge <?= $badge ?>">
            <?= strtoupper(str_replace('_', ' ', $status)) ?>
        </span>

        <div class="small text-muted">
            Created on <?= date('M d, Y h:i A', strtotime($case['created_at'])) ?>
        </div>

        <div class="d-flex align-items-center gap-2">
            <div class="small text-muted mb-1">
                Current Assignee
            </div>

            <form method="POST"
                action="../../../processes/case_assign_update.php">

                <input type="hidden"
                    name="case_id"
                    value="<?= $case['id'] ?>">

                <select
                    name="assigned_to"
                    class="form-select form-select-sm"
                    onchange="this.form.submit()">

                    <option value=""
                        <?= empty($case['assigned_to']) ? 'selected' : '' ?>>
                        Unassigned
                    </option>

                    <option value="admin"
                        <?= $case['assigned_to'] == 'admin' ? 'selected' : '' ?>>
                        Administrator
                    </option>

                    <option value="tribe_leader"
                        <?= $case['assigned_to'] == 'tribe_leader' ? 'selected' : '' ?>>
                        Tribe Leader
                    </option>

                    <option value="tribe_rep"
                        <?= $case['assigned_to'] == 'tribe_rep' ? 'selected' : '' ?>>
                        Tribe Representative
                    </option>

                    <option value="staff"
                        <?= $case['assigned_to'] == 'staff' ? 'selected' : '' ?>>
                        Staff
                    </option>

                    <option value="assessor"
                        <?= $case['assigned_to'] == 'assessor' ? 'selected' : '' ?>>
                        Assessor
                    </option>

                </select>

            </form>

        </div>
    </div>

    <!-- STATUS UPDATE -->
    <?php if (in_array($_SESSION['role'], ['admin', 'tribe_leader', 'assessor', 'staff'])): ?>

        <div class="card-box mb-1">

            <div class="section-title">Update Status</div>

            <form method="POST" action="../../../processes/case_status_update.php">

                <input type="hidden" name="case_id" value="<?= $case['id'] ?>">

                <div class="row g-2">

                    <div class="col-md-10">
                        <select name="status" class="form-select" required>
                            <?php foreach ($allowedStatusOptions as $option): ?><option value="<?= $option ?>" <?= $case['status'] === $option ? 'selected' : '' ?>><?= ucwords(str_replace('_', ' ', $option)) ?></option><?php endforeach; ?>
                        </select>
                    </div>

                    <div class="col-md-2">
                        <button class="btn btn-success w-100">
                            Update Status
                        </button>
                    </div>

                </div>

            </form>

        </div>

    <?php endif; ?>

    <!-- APPLICANT INFO -->
    <div class="card-box mb-1">

        <div class="section-title">Applicant Information</div>

        <div class="row g-2">

            <div class="col-md-6">
                <div class="label">Full Name</div>
                <div class="value"><?= htmlspecialchars($case['applicant_fullname']) ?></div>
            </div>

            <div class="col-md-3">
                <div class="label">Gender</div>
                <div class="value"><?= htmlspecialchars($case['applicant_gender']) ?></div>
            </div>

            <div class="col-md-3">
                <div class="label">Date of Birth</div>
                <div class="value"><?= htmlspecialchars($case['applicant_dob']) ?></div>
            </div>

            <div class="col-md-6">
                <div class="label">Contact</div>
                <div class="value"><?= htmlspecialchars($case['applicant_contact']) ?></div>
            </div>

            <div class="col-md-6">
                <div class="label">Email</div>
                <div class="value"><?= htmlspecialchars($case['applicant_email']) ?></div>
            </div>

            <div class="col-md-12">
                <div class="label">Address</div>
                <div class="value"><?= htmlspecialchars($case['applicant_address']) ?></div>
            </div>

            <div class="col-md-12">
                <div class="label">IP Group</div>
                <div class="value"><?= htmlspecialchars($case['applicant_ip_group']) ?></div>
            </div>

        </div>
    </div>

    <!-- REPRESENTATIVE -->
    <div class="card-box mb-1">

        <div class="section-title">Representative</div>

        <?php if (empty($case['rep_name'])): ?>
            <div class="text-muted small">
                No representative assigned for this case.
            </div>
        <?php else: ?>

            <div class="row g-2">

                <div class="col-md-6">
                    <div class="label">Name</div>
                    <div class="value"><?= htmlspecialchars($case['rep_name']) ?></div>
                </div>

                <div class="col-md-3">
                    <div class="label">Relationship</div>
                    <div class="value"><?= htmlspecialchars($case['rep_relationship']) ?></div>
                </div>

                <div class="col-md-3">
                    <div class="label">Contact</div>
                    <div class="value"><?= htmlspecialchars($case['rep_contact']) ?></div>
                </div>

            </div>
        <?php endif; ?>
    </div>

    <!-- CASE INFO -->
    <div class="card-box mb-1">

        <div class="section-title">Case Information</div>

        <div class="row g-2">

            <div class="col-md-6">
                <div class="label">Type</div>
                <div class="value">
                    <?= ucwords(str_replace('_', ' ', $case['case_type'])) ?>
                </div>
            </div>

            <div class="col-md-6">
                <div class="label">Incident Date</div>
                <div class="value"><?= htmlspecialchars($case['incident_date']) ?></div>
            </div>

            <div class="col-md-12">
                <div class="label">Title</div>
                <div class="value"><?= htmlspecialchars($case['case_title']) ?></div>
            </div>

            <div class="col-md-12">
                <div class="label">Description</div>
                <div class="value">
                    <?= nl2br(htmlspecialchars($case['case_description'])) ?>
                </div>
            </div>

        </div>
    </div>

    <?php
    $persons = [];

    $pq = mysqli_query(
        $conn,
        "SELECT p.*,a.name affiliation_name,ir.full_name registry_name,CONCAT_WS(' ',fm.first_name,fm.middle_name,fm.last_name,fm.suffix) member_name
     FROM case_persons_involved p LEFT JOIN ip_affiliations a ON a.id=p.affiliation_id LEFT JOIN ip_records ir ON ir.id=p.ip_record_id LEFT JOIN ip_family_members fm ON fm.id=p.family_member_id
     WHERE p.case_id = $id
     ORDER BY p.id ASC"
    );

    while ($row = mysqli_fetch_assoc($pq)) {
        $persons[] = $row;
    }
    ?>
    <!-- PERSONS INVOLVED -->
    <div class="card-box mb-1">

        <div class="section-title">Persons Involved</div>

        <?php if (count($persons) > 0): ?>

            <div class="table-responsive">

                <table class="table table-sm align-middle mb-0">

                    <thead>
                        <tr>
                            <th width="40%" class="label text-secondary">Name</th>
                            <th width="30%" class="label text-secondary">Role</th>
                            <th width="30%" class="label text-secondary">Contact</th>
                        </tr>
                    </thead>

                    <tbody>

                        <?php foreach ($persons as $person): ?>

                            <tr>

                                <td class="value">
                                    <?= htmlspecialchars($person['person_name']) ?>
                                </td>

                                <td class="value">
                                    <span class="badge bg-info text-dark">
                                        <?= htmlspecialchars($person['role']) ?>
                                    </span>
                                </td>

                                <td class="value">
                                    <?= !empty($person['contact'])
                                        ? htmlspecialchars($person['contact'])
                                        : '<span class="text-muted">N/A</span>' ?>
                                    <?php if(!empty($person['affiliation_name'])||!empty($person['registry_name'])||!empty($person['member_name'])):?><small class="d-block text-muted"><?=e(implode(' · ',array_filter([$person['affiliation_name'],$person['registry_name'],$person['member_name']])))?></small><?php endif;?>
                                </td>

                            </tr>

                        <?php endforeach; ?>

                    </tbody>

                </table>

            </div>

        <?php else: ?>

            <div class="text-muted small">
                No persons involved recorded for this case.
            </div>

        <?php endif; ?>

    </div>

    <!-- LOCATION -->
    <div class="card-box mb-1">

        <div class="section-title">Location</div>

        <div class="row g-2">

            <div class="col-md-4">
                <div class="label">Barangay</div>
                <div class="value"><?= htmlspecialchars($case['incident_barangay']) ?></div>
            </div>

            <div class="col-md-4">
                <div class="label">Municipality</div>
                <div class="value"><?= htmlspecialchars($case['incident_municipality']) ?></div>
            </div>

            <div class="col-md-4">
                <div class="label">Province</div>
                <div class="value"><?= htmlspecialchars($case['incident_province']) ?></div>
            </div>

        </div>

        <?php if (!empty($case['latitude']) && !empty($case['longitude'])): ?>
            <hr>
            <div class="small text-muted">
                📍 Coordinates: <?= $case['latitude'] ?>, <?= $case['longitude'] ?>
            </div>
        <?php endif; ?>

    </div>

    <!-- ATTACHMENTS -->
    <?php
    $attachments = [];

    $att_sql = "SELECT * FROM case_attachments WHERE case_id = $id ORDER BY id DESC";
    $att_result = mysqli_query($conn, $att_sql);

    if ($att_result) {
        while ($row = mysqli_fetch_assoc($att_result)) {
            $attachments[] = $row;
        }
    }
    ?>

    <div class="card-box mb-1">

        <div class="section-title">Attachments</div>

        <?php if (count($attachments) > 0): ?>

            <div class="row g-2">

                <?php foreach ($attachments as $file): ?>

                    <?php
                    $filePath = "../../../processes/case_attachment.php?id=" . (int) $file['id'];
                    $fileName = (string) $file['file_name'];
                    $ext = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
                    $isImage = in_array($ext, ['jpg', 'jpeg', 'png', 'gif', 'webp']);
                    $isPdf = $ext === 'pdf';
                    ?>

                    <div class="col-md-6">

                        <div class="border rounded p-2 d-flex justify-content-between align-items-center">

                            <div>
                                <div class="fw-semibold small"><?= e($fileName) ?></div>
                                <div class="text-muted" style="font-size:12px;">
                                    <?= strtoupper($ext) ?>
                                </div>
                            </div>

                            <button class="btn btn-sm btn-outline-primary"
                                onclick='previewFile(<?= json_encode($filePath) ?>, <?= json_encode($fileName) ?>, <?= json_encode($ext) ?>)'>

                                <i class="bi bi-eye"></i>
                            </button>

                        </div>

                        <!-- <?php if ($isImage): ?>
                            <div class="mt-2">
                                <img src="<?= $filePath ?>"
                                    class="img-fluid rounded border"
                                    style="max-height:160px; object-fit:cover;">
                            </div>
                        <?php endif; ?> -->

                    </div>

                <?php endforeach; ?>

            </div>

        <?php else: ?>

            <div class="text-muted small">
                No attachments uploaded for this case.
            </div>

        <?php endif; ?>

    </div>

</div>

<!-- FILE PREVIEW MODAL -->
<div class="modal fade" id="filePreviewModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title" id="fileModalTitle">Attachment Preview</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body text-center" id="filePreviewBody">
                <!-- dynamic content -->
            </div>

        </div>
    </div>
</div>
<script>
    function previewFile(path, name, ext) {

        // sanitize extension
        ext = (ext || '').toLowerCase();

        document.getElementById('fileModalTitle').innerText = name;

        let html = '';

        // IMAGE PREVIEW
        if (['jpg', 'jpeg', 'png', 'gif', 'webp'].includes(ext)) {

            html = `
            <img src="${path}" 
                 class="img-fluid rounded shadow-sm"
                 style="max-height:75vh; object-fit:contain;">
        `;

            // PDF PREVIEW
        } else if (ext === 'pdf') {

            html = `
            <iframe src="${path}" 
                    style="width:100%;height:75vh;border:none;border-radius:8px;">
            </iframe>
        `;

            // OTHER FILE TYPES
        } else {

            html = `
            <div class="text-center p-4">
                <p class="text-muted mb-3">
                    Preview not available for <strong>.${ext}</strong> files.
                </p>

                <a href="${path}" 
                   class="btn btn-primary" 
                   download>
                    Download File
                </a>
            </div>
        `;
        }

        document.getElementById('filePreviewBody').innerHTML = html;

        new bootstrap.Modal(
            document.getElementById('filePreviewModal')
        ).show();
    }
</script>
<?php require '../../../includes/footer.php'; ?>
