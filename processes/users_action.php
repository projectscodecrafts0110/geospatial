<?php
require '../includes/db.php';
require 'audit.php';
require_once '../includes/security.php';
start_secure_session();
require_roles(['admin']);
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    exit('Method not allowed.');
}
require_csrf();

// ==========================
// EDIT USER
// ==========================
if (isset($_POST['update_user'])) {

    $id = (int) $_POST['id'];
    $name = trim($_POST['name'] ?? '');
    $username = trim($_POST['username'] ?? '');
    $role = $_POST['role'] ?? '';
    $status = $_POST['status'] ?? '';
    $tribe = $_POST['tribe'] ?? '';

    $allowedRoles = ['admin', 'tribe_leader', 'tribe_rep', 'assessor', 'staff'];
    $allowedStatuses = ['active', 'inactive', 'suspended'];
    if (!in_array($role, $allowedRoles, true) || !in_array($status, $allowedStatuses, true)) {
        header("Location: ../auth/admin/users.php?update=error&msg=invalid_input");
        exit;
    }
    $name = mysqli_real_escape_string($conn, $name);
    $username = mysqli_real_escape_string($conn, $username);
    $tribe = mysqli_real_escape_string($conn, trim($tribe));

    if ($id <= 0 || empty($name) || empty($username)) {
        header("Location: ../auth/admin/users.php?update=error&msg=invalid_input");
        exit;
    }

    // FETCH OLD DATA
    $old = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM users WHERE id=$id"));

    if (!$old) {
        header("Location: ../auth/admin/users.php?update=error&msg=not_found");
        exit;
    }
    if ($id === (int) $_SESSION['user_id'] && ($role !== 'admin' || $status !== 'active')) {
        header("Location: ../auth/admin/users.php?update=error&msg=self_lockout");
        exit;
    }
    if ($old['role'] === 'admin' && $old['status'] === 'active' && ($role !== 'admin' || $status !== 'active')) {
        $activeAdmins = (int) $conn->query("SELECT COUNT(*) FROM users WHERE role='admin' AND status='active'")->fetch_row()[0];
        if ($activeAdmins <= 1) {
            header("Location: ../auth/admin/users.php?update=error&msg=last_admin");
            exit;
        }
    }

    $changes = [];

    // FIELD CHANGE TRACKING
    if ($old['full_name'] !== $name) {
        $changes[] = "Name: {$old['full_name']} → {$name}";
    }

    if ($old['username'] !== $username) {
        $changes[] = "Username: {$old['username']} → {$username}";
    }

    if ($old['role'] !== $role) {
        $changes[] = "Role: {$old['role']} → {$role}";
    }

    if ($old['status'] !== $status) {
        $changes[] = "Status: {$old['status']} → {$status}";
    }

    $sql = "UPDATE users 
            SET full_name='$name',
                username='$username',
                role='$role',
                status='$status'
            WHERE id=$id";

    $result = mysqli_query($conn, $sql);

    if ($result) {

        if (
            in_array($role, ['tribe_leader', 'tribe_rep'])
        ) {

            $checkTribe = mysqli_query(
                $conn,
                "SELECT id
         FROM user_tribes
         WHERE user_id=$id"
            );

            if (mysqli_num_rows($checkTribe) > 0) {

                mysqli_query(
                    $conn,
                    "UPDATE user_tribes
             SET tribe='$tribe'
             WHERE user_id=$id"
                );
            } else {

                mysqli_query(
                    $conn,
                    "INSERT INTO user_tribes
            (
                user_id,
                tribe
            )
            VALUES
            (
                $id,
                '$tribe'
            )"
                );
            }
        } else {

            mysqli_query(
                $conn,
                "DELETE FROM user_tribes
         WHERE user_id=$id"
            );
        }

        $description = "Updated user account";

        if (!empty($changes)) {
            $description .= " | Changes: " . implode(", ", $changes);
        } else {
            $description .= " | No changes detected";
        }


        log_action(
            $conn,
            "UPDATE USER",
            "users",
            $id,
            $description
        );

        header("Location: ../auth/admin/users.php?update=success");
    } else {
        header("Location: ../auth/admin/users.php?update=error&msg=db_fail");
    }

    exit;
}


if (isset($_POST['toggle'])) {

    $id = (int) $_POST['toggle'];

    if ($id <= 0) {
        header("Location: ../auth/admin/users.php?error=invalid_id");
        exit;
    }
    if ($id === (int) $_SESSION['user_id']) {
        header("Location: ../auth/admin/users.php?error=self_lockout");
        exit;
    }

    $old = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM users WHERE id=$id"));

    if (!$old) {
        header("Location: ../auth/admin/users.php?error=not_found");
        exit;
    }

    // Toggle status
    $newStatus = ($old['status'] === 'active') ? 'inactive' : 'active';
    if ($old['role'] === 'admin' && $newStatus !== 'active') {
        $activeAdmins = (int) $conn->query("SELECT COUNT(*) FROM users WHERE role='admin' AND status='active'")->fetch_row()[0];
        if ($activeAdmins <= 1) {
            header("Location: ../auth/admin/users.php?error=last_admin");
            exit;
        }
    }

    $sql = "UPDATE users SET status='$newStatus' WHERE id=$id";
    $result = mysqli_query($conn, $sql);

    if ($result) {

        $action = $newStatus === 'active' ? "REACTIVATE USER" : "DEACTIVATE USER";

        log_action(
            $conn,
            $action,
            "users",
            $id,
            "User '{$old['username']}' status changed from '{$old['status']}' to '{$newStatus}'"
        );

        header("Location: ../auth/admin/users.php?status=success");
    } else {
        header("Location: ../auth/admin/users.php?status=error&msg=db_fail");
    }

    exit;
}


// ==========================
// RESET PASSWORD
// ==========================
if (isset($_POST['reset'])) {

    $id = (int) $_POST['reset'];

    if ($id <= 0) {
        header("Location: ../auth/admin/users.php?reset=error&msg=invalid_id");
        exit;
    }

    $old = mysqli_fetch_assoc(mysqli_query($conn, "SELECT * FROM users WHERE id=$id"));
    if (!$old) {
        header("Location: ../auth/admin/users.php?reset=error&msg=not_found");
        exit;
    }

    $temporaryPassword = bin2hex(random_bytes(6));
    $defaultPassword = password_hash($temporaryPassword, PASSWORD_DEFAULT);

    $sql = "UPDATE users SET password='$defaultPassword' WHERE id=$id";
    $result = mysqli_query($conn, $sql);

    if ($result) {

        log_action(
            $conn,
            "RESET PASSWORD",
            "users",
            $id,
            "Password reset for user '{$old['username']}' to a generated temporary password"
        );

        $_SESSION['temporary_password'] = $temporaryPassword;
        header("Location: ../auth/admin/users.php?reset=success");
    } else {
        header("Location: ../auth/admin/users.php?reset=error&msg=db_fail");
    }

    exit;
}

if (isset($_POST['add_user'])) {

    $name = trim($_POST['name']);
    $username = trim($_POST['username']);
    $role = $_POST['role'];
    $email = trim($_POST['email']);
    $contact = trim($_POST['contact']);
    $tribe = trim($_POST['tribe'] ?? '');

    $allowedRoles = ['admin', 'tribe_leader', 'tribe_rep', 'assessor', 'staff'];
    if (!in_array($role, $allowedRoles, true) || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
        header("Location: ../auth/admin/users.php?add=error&msg=invalid_input");
        exit;
    }
    if (strlen((string) ($_POST['password'] ?? '')) < 10) {
        header("Location: ../auth/admin/users.php?add=error&msg=weak_password");
        exit;
    }
    $name = mysqli_real_escape_string($conn, $name);
    $username = mysqli_real_escape_string($conn, $username);
    $email = mysqli_real_escape_string($conn, $email);
    $contact = mysqli_real_escape_string($conn, $contact);
    $tribe = mysqli_real_escape_string($conn, $tribe);

    $password = password_hash(
        $_POST['password'],
        PASSWORD_DEFAULT
    );

    if (empty($name) || empty($username)) {

        header("Location: ../auth/admin/users.php?add=error&msg=invalid_input");
        exit;
    }

    $check = mysqli_query(
        $conn,
        "SELECT id
         FROM users
         WHERE username='$username'"
    );

    if (mysqli_num_rows($check) > 0) {

        header("Location: ../auth/admin/users.php?add=error&msg=username_taken");
        exit;
    }

    $sql = "
        INSERT INTO users
        (
            full_name,
            username,
            role,
            email,
            contact_number,
            password,
            status
        )
        VALUES
        (
            '$name',
            '$username',
            '$role',
            '$email',
            '$contact',
            '$password',
            'active'
        )
    ";

    $result = mysqli_query($conn, $sql);

    if ($result) {

        $newId = mysqli_insert_id($conn);

        /* ==========================
           SAVE TRIBE ASSIGNMENT
        ========================== */

        if (
            !empty($tribe)
            &&
            in_array(
                $role,
                ['tribe_leader', 'tribe_rep']
            )
        ) {

            mysqli_query(
                $conn,
                "INSERT INTO user_tribes
                (
                    user_id,
                    tribe
                )
                VALUES
                (
                    $newId,
                    '$tribe'
                )"
            );
        }

        log_action(
            $conn,
            "ADD USER",
            "users",
            $newId,
            "New user '{$username}' created with role '{$role}'"
        );

        header("Location: ../auth/admin/users.php?add=success");
    } else {

        header("Location: ../auth/admin/users.php?add=error&msg=db_error");
    }

    exit;
}
