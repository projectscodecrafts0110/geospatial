<?php
require_once '../../../includes/security.php';
start_secure_session();
require_roles(['admin', 'staff']);
header('Location: ../../tribe_leader/records/create.php');
exit;
