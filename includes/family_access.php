<?php

declare(strict_types=1);

const FAMILY_ROLES = ['admin', 'staff', 'tribe_leader', 'tribe_rep'];

function family_scope_tribe(mysqli $conn): ?string
{
    return in_array($_SESSION['role'] ?? '', ['tribe_leader', 'tribe_rep'], true) ? current_user_tribe($conn) : null;
}

function require_family_access(mysqli $conn, int $familyId): array
{
    $stmt = $conn->prepare("SELECT f.*, a.name affiliation_name,
        CONCAT_WS(' ',h.first_name,h.middle_name,h.last_name,h.suffix) head_name,
        CONCAT_WS(' ',s.first_name,s.middle_name,s.last_name,s.suffix) spouse_name
        FROM ip_families f LEFT JOIN ip_affiliations a ON a.id=f.affiliation_id
        LEFT JOIN ip_family_members h ON h.family_id=f.id AND h.member_role='head'
        LEFT JOIN ip_family_members s ON s.family_id=f.id AND s.member_role='spouse'
        WHERE f.id=? LIMIT 1");
    $stmt->bind_param('i', $familyId); $stmt->execute();
    $family = $stmt->get_result()->fetch_assoc();
    if (!$family) { http_response_code(404); exit('Family record not found.'); }
    $scope = family_scope_tribe($conn);
    if ($scope !== null && !hash_equals($scope, (string) $family['owning_tribe'])) { http_response_code(403); exit('Access denied.'); }
    return $family;
}

function family_member(mysqli $conn, int $familyId, string $role): ?array
{
    $stmt = $conn->prepare('SELECT * FROM ip_family_members WHERE family_id=? AND member_role=? LIMIT 1');
    $stmt->bind_param('is', $familyId, $role); $stmt->execute();
    return $stmt->get_result()->fetch_assoc() ?: null;
}

function family_owning_tribe(mysqli $conn, ?string $requested): ?string
{
    $scope = family_scope_tribe($conn);
    if ($scope !== null) return $scope;
    $requested = normalize_source_text($requested);
    return $requested;
}

function family_person_payload(string $prefix): array
{
    return [
        'last_name' => normalize_source_text($_POST[$prefix . '_last_name'] ?? null),
        'first_name' => normalize_source_text($_POST[$prefix . '_first_name'] ?? null),
        'middle_name' => normalize_source_text($_POST[$prefix . '_middle_name'] ?? null),
        'suffix' => normalize_source_suffix($_POST[$prefix . '_suffix'] ?? null),
        'sex' => normalize_source_sex($_POST[$prefix . '_sex'] ?? null),
        'birthdate' => normalize_source_text($_POST[$prefix . '_birthdate'] ?? null),
    ];
}

function family_person_is_empty(array $person): bool
{
    return count(array_filter($person, static fn($value) => $value !== null)) === 0;
}
