<?php

declare(strict_types=1);

/** Phase 1 normalization helpers. Ambiguous values return null for explicit review. */
function normalize_source_text(?string $value): ?string
{
    if ($value === null) return null;
    $value = preg_replace('/\s+/u', ' ', trim($value));
    if ($value === '' || preg_match('/^(n\/?a|none)$/i', $value)) return null;
    return $value;
}

function normalize_source_sex(?string $value): ?string
{
    $value = normalize_source_text($value);
    if ($value === null) return null;
    return match (strtolower($value)) {
        'male', 'm' => 'Male',
        'female', 'f', 'famale' => 'Female',
        'other' => 'Other',
        default => null,
    };
}

function normalize_source_suffix(?string $value): ?string
{
    $value = normalize_source_text($value);
    if ($value === null) return null;
    return match (strtolower(rtrim($value, '.'))) {
        'jr' => 'Jr.', 'sr' => 'Sr.', 'ii' => 'II', 'iii' => 'III', 'iv' => 'IV',
        default => $value,
    };
}

function parse_source_date(?string $value, string $format = 'd/m/Y'): ?string
{
    $value = normalize_source_text($value);
    if ($value === null) return null;
    $date = DateTimeImmutable::createFromFormat('!' . $format, $value);
    $errors = DateTimeImmutable::getLastErrors();
    if (!$date || ($errors !== false && ($errors['warning_count'] || $errors['error_count']))) return null;
    return $date->format('Y-m-d');
}
