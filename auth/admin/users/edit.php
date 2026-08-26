<?php
require '../../../includes/header.php';
require '../../../includes/role_guard.php';
requireRole(['admin']);
require '../../../includes/db.php';

$id = isset($_GET['id']) ? (int) $_GET['id'] : 0;

$result = mysqli_query($conn, "SELECT * FROM users WHERE id=$id");
$user = mysqli_fetch_assoc($result);
?>

<div class="main">

    <!-- HEADER -->
    <div class="mb-3">
        <h4 class="mb-1">Edit User</h4>
        <small class="text-muted">
            Update user information, role, and access status
        </small>
    </div>

    <!-- FORM -->
    <?php if (!$user): ?>
        <div class="alert alert-danger">
            User not found.
        </div>
    <?php else: ?>
        <div class="card-box p-4" style="max-width: 600px;">

            <form method="POST" action="../../../processes/users_action.php">

                <input type="hidden" name="id" value="<?= $user['id'] ?>">

                <div class="mb-3">
                    <label class="form-label">Full Name</label>
                    <input type="text" name="name" class="form-control"
                        value="<?= htmlspecialchars($user['full_name']) ?>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control"
                        value="<?= htmlspecialchars($user['username']) ?>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Role</label>
                    <select name="role" class="form-select">

                        <option value="admin" <?= $user['role'] == 'admin' ? 'selected' : '' ?>>Admin</option>
                        <option value="staff" <?= $user['role'] == 'staff' ? 'selected' : '' ?>>Staff</option>
                        <option value="assessor" <?= $user['role'] == 'assessor' ? 'selected' : '' ?>>Assessor</option>
                        <option value="tribe_leader" <?= $user['role'] == 'tribe_leader' ? 'selected' : '' ?>>Tribe Leader</option>
                        <option value="tribe_rep" <?= $user['role'] == 'tribe_rep' ? 'selected' : '' ?>>Tribe Representative</option>

                    </select>
                </div>

                <?php if ($user['role'] === 'tribe_leader' || $user['role'] === 'tribe_rep'):
                    $user_id = $user['id'];
                    $get_tribe = "SELECT tribe FROM user_tribes WHERE user_id = $user_id";
                    $gt_res = mysqli_query($conn, $get_tribe);

                    $tribe = mysqli_fetch_assoc($gt_res);
                ?>
                    <div class="mb-3">

                        <label class="form-label">
                            Assigned Tribe
                        </label>

                        <input type="text" class="form-control" placeholder="Enter Tribe" value="<?= htmlspecialchars($tribe['tribe']) ?>" name="tribe">
                    </div>
                <?php endif; ?>

                <div class="mb-4">
                    <label class="form-label">Status</label>
                    <select name="status" class="form-select">

                        <option value="active" <?= $user['status'] == 'active' ? 'selected' : '' ?>>Active</option>
                        <option value="inactive" <?= $user['status'] == 'inactive' ? 'selected' : '' ?>>Inactive</option>

                    </select>
                </div>

                <div class="d-flex justify-content-between">

                    <a href="../users.php" class="btn btn-light border">
                        <i class="bi bi-arrow-left"></i> Back
                    </a>

                    <button type="submit" name="update_user" class="btn btn-success">
                        <i class="bi bi-check2-circle"></i> Update User
                    </button>

                </div>

            </form>

        </div>
    <?php endif; ?>
</div>


<?php
require '../../../includes/right_panel.php';
require '../../../includes/footer.php'; ?>