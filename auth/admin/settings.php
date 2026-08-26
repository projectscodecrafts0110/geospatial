<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin']);

$settings = system_settings($conn);
?>

<div class="main-no-right">
    <div class="d-flex justify-content-between align-items-start mb-3">
        <div>
            <h4 class="mb-1">System Settings</h4>
            <small class="text-muted">Manage the system logo and interface theme.</small>
        </div>
    </div>

    <?php if (($_GET['update'] ?? '') === 'success'): ?>
        <div class="alert alert-success" role="status">System settings were updated.</div>
    <?php elseif (isset($_GET['error'])): ?>
        <div class="alert alert-danger" role="alert">The settings could not be updated. Check the selected file and colors.</div>
    <?php endif; ?>

    <form method="post" action="../../processes/settings_update.php" enctype="multipart/form-data" class="row g-3">
        <section class="col-lg-5">
            <div class="card-box h-100">
                <h5>System Logo</h5>
                <p class="small text-muted">PNG, JPEG, or WebP; maximum 2 MB.</p>
                <div class="p-4 border rounded bg-light text-center mb-3">
                    <img src="<?= BASE_URL . '/' . e($settings['logo_path']) ?>" alt="Current system logo" style="max-width:180px;max-height:180px;object-fit:contain">
                </div>
                <label for="systemLogo" class="form-label">Choose a new logo</label>
                <input id="systemLogo" type="file" name="logo" class="form-control" accept="image/png,image/jpeg,image/webp">
                <div class="form-check mt-3">
                    <input id="resetLogo" class="form-check-input" type="checkbox" name="reset_logo" value="1">
                    <label class="form-check-label" for="resetLogo">Restore the default logo</label>
                </div>
            </div>
        </section>

        <section class="col-lg-7">
            <div class="card-box h-100">
                <h5>Theme Colors</h5>
                <p class="small text-muted">Choose colors with sufficient contrast for readable navigation.</p>
                <?php foreach (['theme_primary' => 'Header color', 'theme_sidebar' => 'Sidebar color', 'theme_accent' => 'Accent color'] as $key => $label): ?>
                    <div class="row align-items-center mb-3">
                        <label class="col-sm-4 col-form-label" for="<?= e($key) ?>"><?= e($label) ?></label>
                        <div class="col-sm-8 d-flex gap-2">
                            <input id="<?= e($key) ?>" type="color" name="<?= e($key) ?>" value="<?= e($settings[$key]) ?>" class="form-control form-control-color">
                            <input type="text" value="<?= e($settings[$key]) ?>" class="form-control" readonly aria-label="<?= e($label) ?> hexadecimal value">
                        </div>
                    </div>
                <?php endforeach; ?>
                <div class="d-flex gap-2 mt-4">
                    <button class="btn btn-success" name="save_settings" value="1"><i class="bi bi-check-lg"></i> Save Settings</button>
                    <button class="btn btn-outline-secondary" name="reset_theme" value="1" onclick="return confirm('Restore the default theme colors?')">Restore Default Theme</button>
                </div>
            </div>
        </section>
    </form>
</div>

<?php require '../../includes/footer.php'; ?>
