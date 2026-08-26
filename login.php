<?php
require_once __DIR__ . '/includes/security.php';
require_once __DIR__ . '/includes/db.php';
$publicSettings = system_settings($conn);
$errors = [
    'empty_fields' => 'Enter both your username and password.',
    'invalid_credentials' => 'The username or password is incorrect.',
    'inactive_account' => 'This account is not active. Contact the system administrator.',
    'too_many_attempts' => 'Too many unsuccessful attempts. Please wait 15 minutes and try again.',
    'invalid_role' => 'This account does not have a valid system role.'
];
$errorKey = (string) ($_GET['error'] ?? '');
$errorMessage = $errors[$errorKey] ?? '';
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Secure Login | IP Rights Monitoring System</title>
    <link rel="icon" href="<?= e($publicSettings['logo_path']) ?>">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        :root{--green:#175b37;--dark:#0b2e1c;--muted:#647168;--line:#dce5df}*{box-sizing:border-box}body{min-height:100vh;margin:0;font-family:"Segoe UI",system-ui,sans-serif;background:#f3f7f4;color:#17231c}.login-layout{min-height:100vh}.login-visual{position:relative;isolation:isolate;display:flex;align-items:flex-end;min-height:100vh;padding:clamp(2rem,6vw,5.5rem);color:#fff;background:url('assets/images/login-left-panel.jpg') center/cover no-repeat}.login-visual:before{content:"";position:absolute;inset:0;z-index:-1;background:linear-gradient(180deg,rgba(7,31,19,.35),rgba(7,31,19,.95))}.seal{width:72px;height:72px;object-fit:contain}.visual-copy{max-width:650px}.visual-copy h1{font-size:clamp(2.2rem,4vw,4.25rem);line-height:1.05;letter-spacing:-.04em;font-weight:780}.visual-copy p{max-width:570px;color:rgba(255,255,255,.76);line-height:1.75}.login-side{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:2rem}.login-box{width:100%;max-width:430px}.office-mark{font-size:.72rem;font-weight:800;letter-spacing:.1em;text-transform:uppercase;color:var(--green)}.login-box h2{font-size:1.8rem;font-weight:760;letter-spacing:-.025em;color:var(--dark)}.login-card{margin-top:1.5rem;padding:1.8rem;background:#fff;border:1px solid var(--line);border-radius:16px;box-shadow:0 18px 55px rgba(11,46,28,.1)}.form-label{font-size:.85rem;font-weight:700;color:#34463b}.form-control{min-height:48px;border-color:#cbd8d0;border-radius:10px}.form-control:focus{border-color:var(--green);box-shadow:0 0 0 .2rem rgba(23,91,55,.13)}.input-group-text{border-color:#cbd8d0;background:#f7faf8;color:#637168}.btn-login{min-height:48px;border:0;border-radius:10px;background:var(--green);color:#fff;font-weight:750}.btn-login:hover{background:#10492b;color:#fff}.security-note{display:flex;gap:.65rem;color:var(--muted);font-size:.78rem;line-height:1.5}.back-link{color:var(--green);font-weight:650;text-decoration:none}.back-link:hover{text-decoration:underline}@media(max-width:767px){.login-side{min-height:100vh;padding:1.25rem}.login-card{padding:1.35rem}.login-box{max-width:480px}}
    </style>
</head>
<body>
<main class="container-fluid p-0"><div class="row g-0 login-layout">
    <section class="col-md-7 login-visual d-none d-md-flex" aria-label="System introduction"><div class="visual-copy"><img src="<?= e($publicSettings['logo_path']) ?>" class="seal mb-4" alt="LGU Adams seal"><div class="text-warning fw-bold text-uppercase small mb-3">Local Government Unit of Adams</div><h1>Secure information for responsive public service.</h1><p class="mt-4 mb-0">The Indigenous Peoples Rights Monitoring System supports authorized personnel in managing registry information, cases, geospatial records, and accountable service workflows.</p></div></section>
    <section class="col-md-5 login-side"><div class="login-box">
        <a class="back-link small" href="index.php"><i class="bi bi-arrow-left me-1"></i>Return to public website</a>
        <div class="d-flex align-items-center gap-3 mt-4 d-md-none"><img src="<?= e($publicSettings['logo_path']) ?>" class="seal" alt="LGU Adams seal"><div><div class="office-mark">LGU Adams</div><strong>IP Rights Monitoring System</strong></div></div>
        <div class="office-mark mt-4">Authorized access</div><h2 class="mt-2 mb-2">Welcome back</h2><p class="text-secondary mb-0">Sign in using your assigned system account.</p>
        <div class="login-card">
            <?php if ($errorMessage !== ''): ?><div class="alert alert-danger d-flex gap-2 align-items-start small" role="alert"><i class="bi bi-exclamation-circle-fill mt-1"></i><span><?= e($errorMessage) ?></span></div><?php endif; ?>
            <form action="processes/login.php" method="post">
                <div class="mb-3"><label class="form-label" for="username">Username</label><div class="input-group"><span class="input-group-text"><i class="bi bi-person"></i></span><input id="username" type="text" name="username" class="form-control" placeholder="Username" autocomplete="username" required autofocus></div></div>
                <div class="mb-4"><label class="form-label" for="password">Password</label><div class="input-group"><span class="input-group-text"><i class="bi bi-lock"></i></span><input id="password" type="password" name="password" class="form-control" placeholder="Password" autocomplete="current-password" required><button class="btn btn-outline-secondary" type="button" id="togglePassword" aria-label="Show password"><i class="bi bi-eye"></i></button></div></div>
                <button class="btn btn-login w-100" type="submit">Access System <i class="bi bi-arrow-right ms-2"></i></button>
            </form>
            <div class="security-note mt-4 pt-3 border-top"><i class="bi bi-shield-check text-success fs-5"></i><span>Access is limited to authorized personnel. Sign-in attempts and system activity may be recorded for security and accountability.</span></div>
        </div>
        <p class="text-center text-secondary small mt-4 mb-0">For account assistance, contact your system administrator.</p>
    </div></section>
</div></main>
<script>document.getElementById('togglePassword').addEventListener('click',function(){const input=document.getElementById('password');const showing=input.type==='text';input.type=showing?'password':'text';this.innerHTML=showing?'<i class="bi bi-eye"></i>':'<i class="bi bi-eye-slash"></i>';this.setAttribute('aria-label',showing?'Show password':'Hide password')});</script>
</body></html>
