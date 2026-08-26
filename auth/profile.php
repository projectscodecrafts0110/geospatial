<?php
require '../includes/header.php';
require '../includes/db.php';

$userId = (int) $_SESSION['user_id'];
$stmt = $conn->prepare('SELECT username, email, full_name, contact_number, role, last_login FROM users WHERE id = ?');
$stmt->bind_param('i', $userId);
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();
if (!$user) { http_response_code(404); exit('Account not found.'); }
?>

<main class="main-no-right">
    <div class="page-heading">
        <div><h4>My Profile</h4><p>Update your contact details or change your password.</p></div>
    </div>

    <?php if (($_GET['update'] ?? '') === 'profile'): ?><div class="alert alert-success" role="status">Profile details updated.</div><?php endif; ?>
    <?php if (($_GET['update'] ?? '') === 'password'): ?><div class="alert alert-success" role="status">Password changed successfully.</div><?php endif; ?>
    <?php if (isset($_GET['error'])): ?><div class="alert alert-danger" role="alert">The requested change could not be completed. Check the provided information.</div><?php endif; ?>

    <div class="row g-3">
        <section class="col-lg-7">
            <form class="card-box h-100" method="post" action="../processes/account_update.php">
                <h5 class="mb-3">Profile Information</h5>
                <div class="row g-3">
                    <div class="col-md-6"><label class="form-label" for="profileName">Full Name</label><input id="profileName" class="form-control" name="full_name" value="<?= e($user['full_name']) ?>" maxlength="150" required></div>
                    <div class="col-md-6"><label class="form-label" for="profileUsername">Username</label><input id="profileUsername" class="form-control" value="<?= e($user['username']) ?>" readonly></div>
                    <div class="col-md-6"><label class="form-label" for="profileEmail">Email</label><input id="profileEmail" type="email" class="form-control" name="email" value="<?= e($user['email']) ?>" maxlength="150" required></div>
                    <div class="col-md-6"><label class="form-label" for="profileContact">Contact Number</label><input id="profileContact" class="form-control" name="contact_number" value="<?= e($user['contact_number']) ?>" maxlength="30"></div>
                    <div class="col-12 small text-muted">Role: <?= e(ucwords(str_replace('_', ' ', $user['role']))) ?><?php if ($user['last_login']): ?> · Last login: <?= e(date('M d, Y h:i A', strtotime($user['last_login']))) ?><?php endif; ?></div>
                </div>
                <button class="btn btn-success mt-3" name="update_profile" value="1">Save Profile</button>
            </form>
        </section>
        <section class="col-lg-5">
            <form class="card-box h-100" method="post" action="../processes/account_update.php">
                <h5 class="mb-3">Change Password</h5>
                <label class="form-label" for="currentPassword">Current Password</label><input id="currentPassword" type="password" class="form-control mb-3" name="current_password" autocomplete="current-password" required>
                <label class="form-label" for="newPassword">New Password</label><input id="newPassword" type="password" class="form-control" name="new_password" minlength="10" autocomplete="new-password" required aria-describedby="passwordHelp">
                <div id="passwordHelp" class="form-text mb-3">Use at least 10 characters.</div>
                <label class="form-label" for="confirmPassword">Confirm New Password</label><input id="confirmPassword" type="password" class="form-control" name="confirm_password" minlength="10" autocomplete="new-password" required>
                <button class="btn btn-outline-success mt-3" name="change_password" value="1">Change Password</button>
            </form>
        </section>
    </div>
</main>

<?php require '../includes/footer.php'; ?>
