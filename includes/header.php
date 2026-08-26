<?php
require_once 'auth.php';
require_once __DIR__ . '/db.php';
define('BASE_URL', '/geospatial'); // change this to your folder name
$csrfToken = csrf_token();
$systemSettings = system_settings($conn);
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="csrf-token" content="<?= e($csrfToken) ?>">

    <!-- Favicon -->
    <link rel="icon" href="<?= BASE_URL . '/' . e($systemSettings['logo_path']) ?>">

    <title>IP Rights Monitoring System</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.css">
    <link rel="stylesheet" href="https://unpkg.com/leaflet.markercluster/dist/MarkerCluster.Default.css">

    <style>
        :root {
            --theme-primary: <?= e($systemSettings['theme_primary']) ?>;
            --theme-sidebar: <?= e($systemSettings['theme_sidebar']) ?>;
            --theme-accent: <?= e($systemSettings['theme_accent']) ?>;
        }
        .btn-success { --bs-btn-bg: var(--theme-accent); --bs-btn-border-color: var(--theme-accent); }
        .text-success { color: var(--theme-accent) !important; }
        a { --bs-link-color-rgb: 23, 113, 53; }
        body {
            background: #f5f7f6;
            overflow-x: hidden;
            color: #1f2937;
            line-height: 1.5;
        }

        .topbar {
            height: 65px;
            background: var(--theme-primary);
            color: white;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 15px;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1050;
        }

        .main-wrapper {
            padding-top: 65px;
        }

        .content-area {
            min-height: calc(100vh - 65px);
        }

        /* MOBILE MENU BUTTON */
        .menu-toggle {
            display: none;
            border: none;
            background: transparent;
            color: white;
            font-size: 22px;
        }

        .main {
            margin-left: 30px;
            margin-right: 280px;
            padding: 20px;
        }

        .main-no-right {
            margin-left: 30px;
            margin-right: 30px;
            padding: 20px;
        }

        .right-panel {
            width: 280px;
            height: calc(100vh - 60px);
            position: fixed;
            right: 0;
            top: 60px;
            background: white;
            border-left: 1px solid #e5e7eb;
            padding: 15px;
            overflow-y: auto;
        }

        .card-box {
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            padding: 18px;
            box-shadow: 0 2px 8px rgba(15, 23, 42, .04);
        }

        .page-heading { display:flex;justify-content:space-between;align-items:flex-start;gap:1rem;margin-bottom:1rem; }
        .page-heading h4 { margin:0 0 .25rem;font-weight:700;color:#111827; }
        .page-heading p { margin:0;color:#6b7280;font-size:.875rem; }
        .section-title { font-weight:700;color:#111827;margin-bottom:.75rem; }
        .form-label, form label { font-weight:600;color:#374151;font-size:.875rem;margin-bottom:.4rem; }
        .form-control, .form-select { border-color:#d1d5db;min-height:40px; }
        .form-control:focus, .form-select:focus { border-color:var(--theme-accent);box-shadow:0 0 0 .2rem color-mix(in srgb,var(--theme-accent) 18%,transparent); }
        .table-responsive { scrollbar-width:thin; }
        .table > :not(caption) > * > * { padding:.8rem .75rem;vertical-align:middle; }
        .table thead th { color:#4b5563;font-size:.76rem;text-transform:uppercase;letter-spacing:.035em;white-space:nowrap; }
        .empty-state { background:#fff;border:1px dashed #cbd5e1;border-radius:12px;padding:2.5rem 1.25rem;text-align:center;color:#64748b; }
        .empty-state i { display:block;font-size:2rem;margin-bottom:.5rem;color:var(--theme-accent); }
        .empty-state h5 { color:#334155;margin-bottom:.35rem; }
        .empty-state p { max-width:540px;margin:0 auto; }

        @media (max-width:1199px) {
            .main { margin-right:30px; }
            .right-panel { display:none; }
        }

        @media (max-width: 768px) {
            .main {
                margin: 0;
            }

            .main-no-right {
                margin: 0;
            }

            .right-panel {
                display: none;
            }
        }

        /* MOBILE */
        @media (max-width: 768px) {

            .menu-toggle {
                display: block;
            }

            .system-subtitle {
                display: none;
            }

            .topbar-title {
                font-size: 13px;
            }

            .top-search {
                display: none !important;
            }

            .role-badge {
                display: none;
            }

            .username-mobile {
                display: none;
            }

            .content-area {
                padding: 10px !important;
            }

            .main, .main-no-right { padding:12px; }
            .card-box { padding:14px; }
            .page-heading { align-items:stretch;flex-direction:column; }
        }

        @media (max-width: 768px) {

            .table thead {
                display: none;
            }

            .table tbody tr {
                display: block;
                border: 1px solid #e5e7eb;
                border-radius: 10px;
                margin-bottom: 12px;
                padding: 10px;
                background: #fff;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
            }

            .table tbody td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 6px 0;
                border: none;
                font-size: 13px;
            }

            /* LEFT LABEL */
            .table tbody td::before {
                content: attr(data-label);
                font-weight: 600;
                color: #6b7280;
                flex: 1;
            }

            /* RIGHT VALUE */
            .table tbody td>* {
                text-align: right;
                flex: 1;
            }

            .btn-group {
                width: 100%;
                justify-content: flex-end;
                gap: 5px;
            }

            .btn-group .btn {
                flex: unset;
            }
        }
    </style>
    <link rel="stylesheet" href="<?= BASE_URL ?>/assets/css/app.css?v=20260821-ui-final">
</head>

<body>
    <a class="skip-link" href="#mainContent">Skip to main content</a>

    <!-- TOPBAR -->
    <div class="topbar d-flex align-items-center justify-content-between px-3">

        <!-- LEFT: SYSTEM IDENTITY -->
        <div class="d-flex align-items-center gap-2">

            <button class="btn text-white d-lg-none me-2"
                data-bs-toggle="offcanvas"
                data-bs-target="#mobileSidebar" aria-label="Open navigation">

                <i class="bi bi-list fs-4"></i>

            </button>

            <div style="
            width: 34px;
            height: 34px;
            display:flex;
            align-items:center;
            justify-content:center;
        ">
                <img src="<?= BASE_URL . '/' . e($systemSettings['logo_path']) ?>" alt="System logo" style="width: 45px; height: 45px; object-fit: contain;">
            </div>

            <div class="d-flex flex-column">

                <strong class="topbar-title">
                    IP Rights Monitoring System
                </strong>

                <small class="system-subtitle"
                    style="font-size:11px;opacity:.75;">
                    LGU Monitoring & GIS Platform
                </small>

            </div>

        </div>

        <form class="top-search d-none d-md-block" action="<?= BASE_URL ?>/auth/search.php" method="get" role="search" style="flex:1;max-width:420px;margin:0 20px">
            <label class="visually-hidden" for="globalSearch">Search the system</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text bg-white border-0"><i class="bi bi-search"></i></span>
                <input id="globalSearch" type="search" name="q" class="form-control border-0" value="<?= e($_GET['q'] ?? '') ?>" placeholder="Search records, cases, people..." minlength="2" required>
            </div>
        </form>

        <!-- RIGHT: USER DROPDOWN -->
        <div class="dropdown">

            <!-- TRIGGER -->
            <a class="d-flex align-items-center text-decoration-none dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
                aria-expanded="false"
                style="color: inherit;">

                <!-- ROLE BADGE (kept visible) -->
                <span class="badge bg-light text-dark me-2 role-badge">
                    <?= ucfirst($_SESSION['role'] ?? 'user') ?>
                </span>

                <!-- AVATAR -->
                <div style="
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: #ffffff;
            color: #1f4d2e;
            display:flex;
            align-items:center;
            justify-content:center;
            font-weight:600;
            font-size: 12px;
        ">
                    <?= e(strtoupper(substr($_SESSION['username'] ?? 'U', 0, 1))) ?>
                </div>

            </a>

            <!-- DROPDOWN MENU -->
            <ul class="dropdown-menu dropdown-menu-end mt-2 shadow-sm">

                <li class="px-3 py-2">
                    <div class="fw-semibold">
                        <?= e($_SESSION['username'] ?? '') ?>
                    </div>
                    <small class="text-muted">
                        Logged in as <?= e($_SESSION['role'] ?? 'user') ?>
                    </small>
                </li>

                <li>
                    <hr class="dropdown-divider">
                </li>

                <li>
                    <a class="dropdown-item d-flex align-items-center gap-2" href="<?= BASE_URL ?>/auth/profile.php">
                        <i class="bi bi-person"></i>
                        My Profile
                    </a>
                </li>

                <li>
                    <hr class="dropdown-divider">
                </li>

                <li>
                    <form method="post" action="<?= BASE_URL ?>/processes/logout.php">
                    <button type="submit" class="dropdown-item text-danger d-flex align-items-center gap-2">
                        <i class="bi bi-box-arrow-right" aria-hidden="true"></i> Logout
                    </button></form>
                </li>

            </ul>

        </div>

    </div>

    <div class="main-wrapper">

        <?php require __DIR__ . '/sidebar.php'; ?>

        <div class="content-area p-3" id="mainContent" tabindex="-1">
