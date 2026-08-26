<?php
$role = $_SESSION['role'] ?? '';
$path = str_replace('\\', '/', $_SERVER['SCRIPT_NAME'] ?? '');
$menus = [
    'admin' => [['Overview', 'speedometer2', '/auth/admin/dashboard.php'], ['People & Registry', 'people', '/auth/admin/records.php'], ['IP Families', 'people-fill', '/auth/families.php'], ['Case Management', 'folder2-open', '/auth/admin/cases.php'], ['Tax Declarations', 'file-earmark-spreadsheet', '/auth/tax_declarations.php'], ['Parcel Map', 'geo-alt', '/auth/admin/gis.php'], ['Administration', 'person-check', '/auth/admin/users.php'], ['System Settings', 'gear', '/auth/admin/settings.php'], ['Audit Logs', 'journal-text', '/auth/admin/logs.php'], ['Reports', 'bar-chart', '/auth/admin/reports.php']],
    'tribe_leader' => [['Overview', 'speedometer2', '/auth/tribe_leader/dashboard.php'], ['Tribe Records', 'folder2-open', '/auth/tribe_leader/records.php'], ['Families', 'people-fill', '/auth/families.php'], ['Approvals', 'check2-circle', '/auth/tribe_leader/approvals.php'], ['Case Management', 'folder', '/auth/tribe_leader/cases.php'], ['Tax Declarations', 'file-earmark-spreadsheet', '/auth/tax_declarations.php']],
    'tribe_rep' => [['Overview', 'speedometer2', '/auth/tribe_rep/dashboard.php'], ['Tribe Records', 'folder2-open', '/auth/tribe_rep/records.php'], ['Families', 'people-fill', '/auth/families.php'], ['Case Intake', 'folder-plus', '/auth/tribe_rep/cases.php'], ['Tax Declarations', 'file-earmark-spreadsheet', '/auth/tax_declarations.php']],
    'assessor' => [['Assessment Queue', 'clipboard-check', '/auth/admin/cases.php'], ['Assigned Records', 'folder', '/auth/admin/records.php'], ['Tax Evidence', 'file-earmark-spreadsheet', '/auth/tax_declarations.php'], ['Parcel Map', 'geo-alt', '/auth/admin/gis.php']],
    'staff' => [['Encode Record', 'plus-circle', '/auth/admin/records/create.php'], ['Records', 'folder', '/auth/admin/records.php'], ['Families', 'people-fill', '/auth/families.php'], ['Case Support', 'folder2-open', '/auth/admin/cases.php'], ['Tax Declarations', 'file-earmark-spreadsheet', '/auth/tax_declarations.php']]
];
$items = $menus[$role] ?? [];
function sidebar_links(array $items, string $path, bool $mobile = false): void
{
    foreach ($items as [$label, $icon, $url]) {
        $active = str_contains($path, $url) || (str_contains($url, '/cases.php') && str_contains($path, '/cases/')) || (str_contains($url, 'tax_declarations.php') && str_contains($path, '/tax_declarations/'));
        echo '<a class="' . ($active ? 'active ' : '') . ($mobile ? 'mobile-nav-link ' : '') . '" href="' . BASE_URL . $url . '"><i class="bi bi-' . $icon . '"></i><span>' . e($label) . '</span></a>';
    }
}
?>
<style>
    .sidebar {
        width: 244px;
        height: calc(100vh - 60px);
        background: var(--theme-sidebar, #163820);
        color: #fff;
        position: fixed;
        top: 60px;
        left: 0;
        padding: 18px 14px;
        overflow-y: auto;
        z-index: 1000
    }

    .sidebar-brand {
        padding: 4px 12px 14px;
        border-bottom: 1px solid rgba(255, 255, 255, .12);
        margin-bottom: 12px
    }

    .sidebar-brand small,
    .sidebar-label {
        color: rgba(255, 255, 255, .65);
        font-size: .7rem;
        text-transform: uppercase;
        letter-spacing: .08em
    }

    .sidebar a,
    .mobile-nav-link {
        display: flex;
        align-items: center;
        gap: 11px;
        color: rgba(255, 255, 255, .88);
        text-decoration: none;
        padding: 10px 12px;
        border-radius: 9px;
        margin-bottom: 4px;
        transition: .18s
    }

    .sidebar a:hover,
    .sidebar a.active,
    .mobile-nav-link:hover,
    .mobile-nav-link.active {
        color: #fff;
        background: rgba(255, 255, 255, .14)
    }

    .sidebar a.active {
        box-shadow: inset 3px 0 var(--theme-accent, #75b798)
    }

    .sidebar i,
    .mobile-nav-link i {
        font-size: 1.05rem;
        width: 20px;
        text-align: center
    }

    .content-area {
        margin-left: 244px;
        transition: .25s
    }

    @media(max-width:991px) {
        .sidebar {
            display: none
        }

        .content-area {
            margin-left: 0;
            width: 100%
        }
    }
</style>
<aside class="sidebar" aria-label="Primary navigation">
    <div class="sidebar-brand"><strong><?= e(ucwords(str_replace('_', ' ', $role))) ?></strong><small class="d-block">Authorized workspace</small></div>
    <div class="sidebar-label px-2 mb-2">Navigation</div><?php sidebar_links($items, $path); ?>
</aside>
<div class="offcanvas offcanvas-start text-bg-dark" tabindex="-1" id="mobileSidebar">
    <div class="offcanvas-header">
        <div>
            <h5 class="offcanvas-title mb-0">Navigation</h5><small><?= e(ucwords(str_replace('_', ' ', $role))) ?></small>
        </div><button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body"><?php sidebar_links($items, $path, true); ?></div>
</div>