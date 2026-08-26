<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin']);
require '../../includes/db.php';

$from = preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['from'] ?? '') ? $_GET['from'] : null;
$to = preg_match('/^\d{4}-\d{2}-\d{2}$/', $_GET['to'] ?? '') ? $_GET['to'] : null;
$action = $_GET['action'] ?? null;
$module = trim((string)($_GET['module'] ?? ''));

$where = " WHERE 1=1";

if ($from && $to) {
    $where .= " AND created_at >= '{$from} 00:00:00' AND created_at < DATE_ADD('{$to} 00:00:00', INTERVAL 1 DAY)";
}

if ($action && $action != 'all') {
    $action_safe = mysqli_real_escape_string($conn, $action);
    $where .= " AND action = '$action_safe'";
}
if($module!==''){$where.=" AND module='".$conn->real_escape_string($module)."'";}

$totalLogs = (int) $conn->query("SELECT COUNT(*) FROM audit_logs $where")->fetch_row()[0];
[$page, $perPage, $offset, $pages] = pagination_values($totalLogs, 50);
$sql = "SELECT id, username, role, action, module, record_id, description, created_at FROM audit_logs $where ORDER BY id DESC LIMIT $perPage OFFSET $offset";

$result = mysqli_query($conn, $sql);
$actionsResult = mysqli_query($conn, "SELECT DISTINCT action FROM audit_logs ORDER BY action ASC");
$modulesResult = mysqli_query($conn, "SELECT DISTINCT module FROM audit_logs WHERE module IS NOT NULL AND module<>'' ORDER BY module ASC");
function audit_record_url(string$module,int$id):?string{return match($module){'ip_families'=>'../families/view.php?id='.$id,'case_applications'=>'cases/view.php?id='.$id,'tax_declarations'=>'../tax_declarations/view.php?id='.$id,'ip_records'=>'records/view.php?id='.$id,default=>null};}
?>

<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css">

<div class="main-no-right">

    <div class="workspace-header"><div><div class="eyebrow">Accountability</div><h1>Audit Logs</h1><p>Trace actions across people, families, cases, parcels, Tax Declarations, and administration.</p></div></div>

    <div class="card-box mb-3">

        <form method="GET" class="row g-2 align-items-end">

            <!-- FROM -->
            <div class="col-md-2">
                <label class="form-label small text-muted">From</label>
                <input type="date" name="from" class="form-control form-control-sm"
                    value="<?= e($from ?? '') ?>">
            </div>

            <div class="col-md-2"><label class="form-label small text-muted">Module</label><select name="module" class="form-select form-select-sm"><option value="">All Modules</option><?php while($m=$modulesResult->fetch_assoc()):?><option value="<?=e($m['module'])?>" <?=$module===$m['module']?'selected':''?>><?=e(ucwords(str_replace('_',' ',$m['module'])))?></option><?php endwhile;?></select></div>

            <!-- TO -->
            <div class="col-md-2">
                <label class="form-label small text-muted">To</label>
                <input type="date" name="to" class="form-control form-control-sm"
                    value="<?= e($to ?? '') ?>">
            </div>

            <!-- ACTION FILTER -->
            <div class="col-md-2">
                <label class="form-label small text-muted">Action</label>

                <select name="action" class="form-select form-select-sm">
                    <option value="all">All Actions</option>

                    <?php while ($a = mysqli_fetch_assoc($actionsResult)): ?>
                        <option value="<?= htmlspecialchars($a['action']) ?>"
                            <?= ($action == $a['action']) ? 'selected' : '' ?>>
                            <?= htmlspecialchars($a['action']) ?>
                        </option>
                    <?php endwhile; ?>

                </select>
            </div>

            <!-- FILTER BUTTON -->
            <div class="col-md-2">
                <button class="btn btn-success btn-sm w-100">
                    <i class="bi bi-funnel"></i> Filter
                </button>
            </div>

            <!-- PRINT BUTTON -->
            <div class="col-md-2">
                <button type="button" onclick="printLogs()" class="btn btn-outline-dark btn-sm w-100">
                    <i class="bi bi-printer"></i> Print
                </button>
            </div>

            <!-- RESET -->
            <div class="col-md-2">
                <a href="logs.php" class="btn btn-light btn-sm border w-100">
                    Reset
                </a>
            </div>

        </form>

    </div>

    <div class="card-box p-0">

        <table class="table table-hover mb-0">

            <thead class="table-light">
                <tr>
                    <th>User</th>
                    <th>Action</th>
                    <th>Module</th>
                    <th>Record</th>
                    <th>Description</th>
                    <th>Time</th>
                </tr>
            </thead>

            <tbody>

                <?php while ($log = mysqli_fetch_assoc($result)): ?>

                    <tr>
                        <td data-label="User">
                            <b><?= e($log['username']) ?></b><br>
                            <small class="text-muted"><?= e($log['role']) ?></small>
                        </td>

                        <td data-label="Action"><?= e($log['action']) ?></td>
                        <td data-label="Module"><?= e($log['module']) ?></td>
                        <td data-label="Record"><?php $recordUrl=audit_record_url((string)$log['module'],(int)$log['record_id']);if($recordUrl):?><a class="relationship-chip" href="<?=e($recordUrl)?>">#<?=(int)$log['record_id']?> <i class="bi bi-arrow-up-right"></i></a><?php else:?>#<?=(int)$log['record_id']?><?php endif;?></td>
                        <td class="text-muted"><?= e($log['description']) ?></td>
                        <td class="text-muted" data-label="Time">
                            <?= date('M d, Y • h:i A', strtotime($log['created_at'])) ?>
                        </td>
                    </tr>

                <?php endwhile; ?>

            </tbody>

        </table>

    </div>

</div>
<script>
    function printLogs() {
        const printContent = document.querySelector('.card-box table').outerHTML;

        const win = window.open('', '', 'width=900,height=700');

        win.document.write(`
        <html>
        <head>
            <title>Audit Logs Report</title>

            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

            <style>
                body {
                    padding: 20px;
                    font-family: Arial;
                }

                h3 {
                    text-align: center;
                    margin-bottom: 20px;
                }

                table {
                    font-size: 12px;
                }
            </style>

        </head>

        <body>

            <h3>LGU IP Records System<br>Audit Logs Report</h3>

            ${printContent}

            <script>
                window.onload = function() {
                    window.print();
                    window.onafterprint = function() {
                        window.close();
                    }
                }
            <\/script>

        </body>
        </html>
    `);

        win.document.close();
    }
</script>
<?php render_pagination($page, $pages); ?>
<?php require '../../includes/footer.php'; ?>
