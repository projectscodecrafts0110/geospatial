<?php
declare(strict_types=1);

function record_transition_allowed(string $role, string $from, string $to): bool
{
    if ($from === $to) return true;
    if ($to === 'for_approval') {
        return in_array($role, ['admin', 'staff', 'tribe_leader'], true)
            && in_array($from, ['for_assessment', 'rejected'], true);
    }
    if (in_array($to, ['approved', 'rejected'], true)) {
        return $role === 'admin' && $from === 'for_approval';
    }
    return $role === 'admin' && $to === 'for_assessment';
}
