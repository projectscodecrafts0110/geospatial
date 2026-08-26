<?php
declare(strict_types=1);

function case_initial_assignment(string $caseType): string
{
    return $caseType === 'land_dispute' ? 'assessor' : 'tribe_leader';
}

function case_effective_assignment(string $caseType, string $status, ?string $requested = null): string
{
    if ($caseType === 'land_dispute' && !in_array($status, ['resolved', 'closed'], true)) return 'assessor';
    $allowed = ['admin', 'tribe_leader', 'assessor', 'staff'];
    return in_array($requested, $allowed, true) ? $requested : case_initial_assignment($caseType);
}

function case_status_transition_allowed(string $role, string $caseType, string $from, string $to): bool
{
    if ($from === $to) return true;
    if ($role === 'admin') return in_array($to, ['pending', 'ongoing', 'under_review', 'resolved', 'closed'], true);
    $next = ['pending'=>['ongoing'], 'ongoing'=>['under_review'], 'under_review'=>['ongoing','resolved'], 'resolved'=>['under_review','closed'], 'closed'=>[]];
    if (!in_array($to, $next[$from] ?? [], true)) return false;
    if ($role === 'assessor') return $caseType === 'land_dispute' && in_array($to, ['ongoing', 'under_review'], true);
    if ($role === 'staff') return in_array($to, ['ongoing', 'under_review'], true);
    if ($role === 'tribe_leader') return in_array($to, ['ongoing', 'under_review', 'resolved', 'closed'], true);
    return false;
}

function case_available_statuses(string $role, string $caseType, string $current): array
{
    $all = ['pending', 'ongoing', 'under_review', 'resolved', 'closed'];
    return array_values(array_filter($all, static fn(string $status): bool => case_status_transition_allowed($role, $caseType, $current, $status)));
}

function case_workflow_label(string $caseType, string $status, string $assigned): string
{
    if (in_array($status, ['resolved', 'closed'], true)) return $status === 'closed' ? 'Closed' : 'Resolved — awaiting closure';
    if ($caseType === 'land_dispute' && $assigned === 'assessor') return 'Assessor technical review';
    return match ($status) {
        'pending' => 'Intake and triage',
        'ongoing' => 'Active handling',
        'under_review' => 'Decision review',
        default => ucwords(str_replace('_', ' ', $status)),
    };
}
