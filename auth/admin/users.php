<?php
require '../../includes/header.php';
require '../../includes/role_guard.php';
requireRole(['admin']);
require '../../includes/db.php'; // make sure mysqli OR pdo is consistent

$temporaryPassword = $_SESSION['temporary_password'] ?? null;
unset($_SESSION['temporary_password']);

$filterQ=trim((string)($_GET['q']??'')); $filterRole=(string)($_GET['role']??''); $filterStatus=(string)($_GET['status']??''); $where=' WHERE 1=1';
if($filterQ!==''){ $safe=mysqli_real_escape_string($conn,$filterQ); $where.=" AND (full_name LIKE '%$safe%' OR username LIKE '%$safe%' OR email LIKE '%$safe%')"; }
$allowedRoles=['admin','staff','assessor','tribe_leader','tribe_rep']; if(in_array($filterRole,$allowedRoles,true)){$where.=" AND role='".mysqli_real_escape_string($conn,$filterRole)."'";}else{$filterRole='';}
$allowedStatuses=['active','inactive','suspended']; if(in_array($filterStatus,$allowedStatuses,true)){$where.=" AND status='".mysqli_real_escape_string($conn,$filterStatus)."'";}else{$filterStatus='';}
$totalUsers = (int) $conn->query("SELECT COUNT(*) FROM users $where")->fetch_row()[0];
[$page, $perPage, $offset, $pages] = pagination_values($totalUsers);
$userWhere=str_replace(['full_name','username','email','role','status'],['u.full_name','u.username','u.email','u.role','u.status'],$where);
$sql = "SELECT u.id,u.full_name,u.username,u.email,u.contact_number,u.role,u.status,ut.tribe tribe_name,(SELECT COUNT(*) FROM ip_families f WHERE f.owning_tribe=ut.tribe) scoped_family_count FROM users u LEFT JOIN user_tribes ut ON ut.user_id=u.id $userWhere ORDER BY u.id DESC LIMIT $perPage OFFSET $offset";
$result = mysqli_query($conn, $sql);

$users = [];

if ($result) {
    while ($row = mysqli_fetch_assoc($result)) {
        $users[] = $row;
    }
}
?>
<div class="main-no-right">

    <?php if ($temporaryPassword): ?>
        <div class="alert alert-warning" role="alert">
            Temporary password: <code><?= e($temporaryPassword) ?></code>. Copy it now; it will not be shown again.
        </div>
    <?php endif; ?>

    <!-- HEADER -->
    <div class="workspace-header">

        <div>
            <div class="eyebrow">Administration</div><h1>User &amp; Role Management</h1>
            <p>Manage accounts, operational tribe scope, and responsibility for family records.</p>
        </div>

        <button class="btn btn-success btn-sm d-flex align-items-center gap-2"
            data-bs-toggle="modal"
            data-bs-target="#addUserModal">
            <i class="bi bi-person-plus"></i>
        </button>

    </div>

    <!-- FILTERS -->
    <form class="card-box mb-3" method="get">

        <div class="row g-2 align-items-center">

            <div class="col-md-5">
                <div class="input-group input-group-sm">
                    <span class="input-group-text bg-white">
                        <i class="bi bi-search"></i>
                    </span>
                    <input type="search" name="q" value="<?= e($filterQ) ?>" class="form-control" placeholder="Search user...">
                </div>
            </div>

            <div class="col-md-3">
                <select name="role" class="form-select form-select-sm">
                    <option value="">All Roles</option>
                    <?php foreach($allowedRoles as $value): ?><option value="<?= e($value) ?>" <?= $filterRole===$value?'selected':'' ?>><?= e(ucwords(str_replace('_',' ',$value))) ?></option><?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-3">
                <select name="status" class="form-select form-select-sm">
                    <option value="">All Status</option>
                    <?php foreach($allowedStatuses as $value): ?><option value="<?= e($value) ?>" <?= $filterStatus===$value?'selected':'' ?>><?= e(ucfirst($value)) ?></option><?php endforeach; ?>
                </select>
            </div>

            <div class="col-md-1 text-end">
                <button class="btn btn-success btn-sm" aria-label="Apply filters"><i class="bi bi-funnel"></i></button>
                <a href="users.php" class="btn btn-light btn-sm border" aria-label="Reset filters"><i class="bi bi-arrow-counterclockwise"></i></a>
            </div>

        </div>

    </form>

    <!-- TABLE -->
    <div class="card-box p-0 overflow-hidden">

        <div class="table-responsive">

            <table class="table table-hover align-middle mb-0 administration-table">

                <thead class="table-light">
                    <tr>
                        <th>User</th>
                        <th>Role / Status</th>
                        <th>Tribe</th>
                        <th>Contact Information</th>
                        <th class="text-end">Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <?php if (!$users): ?><tr><td colspan="5"><div class="empty-state border-0"><i class="bi bi-people"></i><h5>No users found</h5><p>Try changing or clearing the filters.</p></div></td></tr><?php endif; ?>

                    <?php foreach ($users as $u): ?>

                        <tr>

                            <td data-label="User">
                                <div class="fw-semibold">
                                    <?= htmlspecialchars($u['full_name']) ?>
                                </div>
                                <small class="text-muted">ID: <?= (int) $u['id'] ?></small>
                                <small class="text-muted d-block">@<?= htmlspecialchars($u['username']) ?></small>
                            </td>

                            <td data-label="Role">
                                <?php
                                $role = $u['role'];
                                $badge = "bg-secondary text-dark border text-white";
                                ?>

                                <span class="badge <?= $badge ?>">
                                    <?= strtoupper($role) ?>
                                </span>
                                <?php if ($u['status'] === 'active'): ?>
                                    <span class="badge bg-success-subtle text-success border d-block mt-1">Active</span>
                                <?php else: ?>
                                    <span class="badge bg-secondary-subtle text-secondary border d-block mt-1">Inactive</span>
                                <?php endif; ?>
                            </td>

                            <td data-label="Operational Scope"><?php if($u['tribe_name']):?><span class="relationship-chip"><i class="bi bi-people-fill"></i><?=e($u['tribe_name'])?> · <?=(int)$u['scoped_family_count']?> families</span><?php else:?><span class="text-muted small">Global / no tribe scope</span><?php endif;?></td>

                            <td data-label="Contact Information" class="text-muted">
                                <span class="d-block text-break"><?= htmlspecialchars($u['email'] ?: 'No email') ?></span>
                                <small><?= htmlspecialchars($u['contact_number'] ?: 'No contact number') ?></small>
                            </td>

                            <td class="text-end">

                                <div class="btn-group">

                                    <a href="users/edit.php?id=<?= (int) $u['id'] ?>" class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-pencil"></i>
                                    </a>

                                    <form method="post" action="../../processes/users_action.php" class="d-inline" onsubmit="return confirm('Generate a temporary password for this user?')">
                                        <input type="hidden" name="reset" value="<?= (int) $u['id'] ?>">
                                        <button class="btn btn-sm btn-outline-warning" aria-label="Reset password"><i class="bi bi-key"></i></button>
                                    </form>

                                    <?php if ($u['status'] === 'active'): ?>

                                        <form method="post" action="../../processes/users_action.php" class="d-inline" onsubmit="return confirm('Deactivate this user?')">
                                            <input type="hidden" name="toggle" value="<?= (int) $u['id'] ?>">
                                            <button class="btn btn-sm btn-outline-danger" aria-label="Deactivate user"><i class="bi bi-person-dash"></i></button>
                                        </form>

                                    <?php else: ?>

                                        <form method="post" action="../../processes/users_action.php" class="d-inline" onsubmit="return confirm('Reactivate this user?')">
                                            <input type="hidden" name="toggle" value="<?= (int) $u['id'] ?>">
                                            <button class="btn btn-sm btn-outline-success" aria-label="Reactivate user"><i class="bi bi-person-check"></i></button>
                                        </form>

                                    <?php endif; ?>

                                </div>

                            </td>

                        </tr>

                    <?php endforeach; ?>

                </tbody>

            </table>

        </div>

    </div>

    <?php
    include '../../includes/right_panel.php';
    ?>

</div>

<!-- ADD USER MODAL -->
<div class="modal fade" id="addUserModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <form method="POST" action="../../processes/users_action.php">

                <div class="modal-header">
                    <h5 class="modal-title">Add New User</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <div class="mb-2">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="name" class="form-control" placeholder="Enter Full Name" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Username</label>
                        <input type="text" name="username" class="form-control" placeholder="Enter Username" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Enter Email" required>
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Contact Number</label>
                        <input type="text" name="contact" class="form-control" placeholder="Enter Contact Number">
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Role</label>

                        <select name="role"
                            id="roleSelect"
                            class="form-select"
                            required>

                            <option value="" selected disabled>
                                Select Role
                            </option>

                            <option value="admin">Admin</option>
                            <option value="staff">Staff</option>
                            <option value="assessor">Assessor</option>
                            <option value="tribe_leader">Tribe Leader</option>
                            <option value="tribe_rep">Tribe Representative</option>

                        </select>
                    </div>

                    <!-- TRIBE ASSIGNMENT -->
                    <div class="mb-2 d-none" id="tribeField">

                        <label class="form-label">
                            Assigned Tribe
                        </label>

                        <input type="text" class="form-control" placeholder="Enter Tribe" name="tribe">
                    </div>

                    <div class="mb-2">
                        <label class="form-label">Password</label>
                        <input type="password" name="password" class="form-control" placeholder="Enter Password" required>
                    </div>

                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">
                        Cancel
                    </button>

                    <button type="submit" name="add_user" class="btn btn-success">
                        Create User
                    </button>
                </div>

            </form>

        </div>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {

        const roleSelect = document.getElementById('roleSelect');
        const tribeField = document.getElementById('tribeField');

        roleSelect.addEventListener('change', function() {

            if (
                this.value === 'tribe_leader' ||
                this.value === 'tribe_rep'
            ) {

                tribeField.classList.remove('d-none');

            } else {

                tribeField.classList.add('d-none');

            }

        });

    });
</script>
<?php include '../../includes/toast.php'; ?>

<?php render_pagination($page, $pages); ?>
<?php require '../../includes/footer.php'; ?>
