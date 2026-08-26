# Phase 1 Real Data Foundation Report

Completed: 2026-08-21  
Target: MariaDB `geo_case`, port `3307`  
Scope: schema/model foundations only; no LCE source records were imported.

## 1. Schema Changes

Added `ip_affiliations`, `ip_families`, `ip_family_members`, `import_batches`, and the minimal future-facing `case_types` reference. Added nullable compatibility/link columns to `ip_records`, `case_applications`, and `case_persons_involved`. Existing columns, enums, rows, coordinates, GeoJSON, attachments, workflows, and authorization data were not rewritten.

## 2. Family Architecture

`ip_families` represents one future workbook row. It stores an optional internal reference, canonical affiliation, separate operational `owning_tribe`, nullable geographic/address/contact/ID/remarks fields, source provenance, and audit-user timestamps. `(import_batch_id, source_reference)` is unique to prevent the same source row being imported twice within a batch.

## 3. Member Architecture

`ip_family_members` stores structured names, suffix, sex, birthdate and `head`/`spouse` role. A unique `(family_id, member_role)` constraint permits one head and at most one spouse under the current source requirements. Members cascade only when their new family is deleted. No empty spouse rows are created.

## 4. Affiliation Architecture

`ip_affiliations` contains six non-PII reference values: Isnag, Isneg, Itneg, Kankanaey, Tinguian and Yapayao. Unique codes/names prevent exact duplicates. Near-spellings remain separate and no synonym mapping was introduced. Nullable affiliation links were added to families, legacy IP records, cases and case participants for phased adoption.

## 5. Ownership vs Affiliation

Ethnic/IP affiliation uses `affiliation_id`. Operational authorization remains based on the existing tribe scope and text values; `ip_families.owning_tribe` explicitly carries that separate meaning for Phase 2. Existing `user_tribes`, security helpers, filters and case routing were unchanged, so tribe isolation was not weakened.

## 6. Existing `ip_records` Compatibility

`ip_records` remains the active legacy workflow. Nullable `affiliation_id` and unique nullable `family_member_id` provide an optional one-to-one bridge to a structured member. Existing records were not converted or matched automatically. Deleting a referenced affiliation/member sets the link to NULL and preserves the IP record.

## 7. Import Provenance Foundation

`import_batches` records source type/name, SHA-256 source hash, lifecycle status, validation summary, timestamps and creator. The source hash prevents duplicate file batches. Each family can record batch, source reference and import timestamp. No importer, source PII or LCE row was added.

## 8. Nullability/Normalization

Real-data fields permit NULL as required. `includes/real_data_normalization.php` provides conservative helpers for whitespace/placeholders, sex, suffix and explicitly formatted dates. Unknown/ambiguous values return NULL for review. It does not merge affiliation spellings or fabricate missing values.

## 9. Migration Safety

- Baseline counts recorded: 2 IP records, 9 cases, 14 case persons, 13 parcels, 7 attachments, 3 users, 2 tribe assignments and 27 audit rows.
- Migration validated first on `geo_case_test`.
- Verified production backup: `database/backup_before_phase1_real_data_2026_08_21.sql` (28,956 bytes).
- Applied migration: `database/upgrade_2026_08_phase1_real_data_foundation.sql`.
- Post-migration baseline counts are unchanged. New family/member/import tables contain zero operational rows; only six affiliation and six case-type reference rows were inserted.

## 10. Tests

`tests/phase1_foundation_test.php` runs only when the database name ends in `_test` and uses a transaction/rollback. Its 21 assertions cover family/head creation, optional spouse, head+spouse, nullable birthday, canonical affiliations, distinct near-spellings, conservative normalization, source duplicate protection, legacy IP bridging, existing cases/parcels/tribe data, rollback preservation and the production guard.

## 11. Regression Results

All existing browser tests pass after the migration: authentication for every role, settings, global search, filters, tribe isolation, case routing, profile/password workflows, mobile tables and responsive overflow. PHP syntax validation remains clean.

## 12. Remaining Phase 2 Work

Phase 2 should build family/member forms and role-scoped list/detail/search behavior, audit those changes without logging sensitive values, create anonymized development fixtures, and implement a preview/validation-driven controlled workbook import. It must explicitly assign operational ownership from the authenticated scope, retain import exceptions, and avoid automatically matching or converting legacy records unless reviewed and deterministic.
