<?php

require_once __DIR__ . '/security.php';

function requireRole($roles = [])
{
    require_roles($roles);
}
