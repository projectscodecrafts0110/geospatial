# Phase 3 Cases and Participants Report

Completed: 2026-08-21  
Production: MariaDB `geo_case`, port `3307`  
Validation/import testing: `geo_case_test`

## 1. Case Model Changes

The existing `case_applications` workflow remains authoritative. An additive `incident_location_text` preserves the complete reported location without inventing coordinates. Existing applicant, representative, routing, status, attachment and incident component fields remain compatible.

## 2. Case Types

Create/edit processing now validates the selected code against active Phase 1 `case_types` and stores both `case_type_id` and the legacy enum code. The five observed categories plus `other` remain available; adding future reference rows does not require a second case system.

## 3. Participant Architecture

`case_persons_involved` now supports `complainant`, `respondent`, `witness` and `representative`, optional affiliation, contact, relationship to applicant, legacy `ip_record_id`, and Phase 1 `family_member_id`. Forms support repeatable add/remove rows. Unregistered people remain valid.

## 4. Representative Handling

Legacy `rep_*` fields are preserved for compatibility. New saves/imports also create a related `representative` participant when fixed representative fields are supplied and no representative row exists in the submitted participants. This is an incremental synchronization path, not a second permanent representative model.

## 5. Registry Links

Participant links are optional and explicitly selected from authorized lists. Foreign keys use `ON DELETE SET NULL`. The DOCX importer never performs name, fuzzy or silent matching; imported links remain NULL.

## 6. Authorization

Case visibility and routing still use the established operational tribe field and existing access helpers. Applicant/participant `affiliation_id` is descriptive only and cannot grant access. Tribe-scoped registry/member choices are restricted to the authenticated operational scope.

## 7. Form/UI Changes

Existing role-specific forms retain their workflow and attachments. Lightweight shared enhancements add applicant affiliation, reported incident location, representative participant role, participant affiliation, optional registry/member links, relationship, and row removal. Detail pages show participant role/contact and linked affiliation/registry context.

## 8. Search/Filters

Existing status/type filters and pagination remain. Admin, tribe-leader and representative case search now includes participant names and reported incident location while preserving the existing tribe predicate.

## 9. Seeder

`scripts/seed_anonymized_cases.php` creates five fictional, idempotent development/test cases covering every observed category, complainant/respondent/witness roles, and one representative example. It refuses production database names and contains no source PII.

## 10. LCE Case Import

The administrator-only workflow privately uploads DOCX, reliably extracts its six structured tables and accompanying description/participant paragraphs, previews validation/type distribution/issues, requires explicit confirmation, then transactionally inserts cases before participants. Temporary files use random names outside public web storage and are removed after completion.

Source validation in `geo_case_test`: **6 cases, 6 valid, 0 warnings, 0 invalid**, with all five observed case types and structured participant roles detected.

## 11. Duplicate Handling

Existing import-batch SHA-256 uniqueness blocks the same DOCX source. Preview conservatively flags a probable duplicate only when applicant, title, case type and incident date agree. It never merges cases.

## 12. Privacy

Actual case content is not embedded in migrations, seeders or audit descriptions. Audits record case/batch IDs, type and participant counts/change categories rather than names, contacts, birthdates or descriptions. The real DOCX was used only in disposable test validation.

## 13. Tests

Twenty-one Phase 3 assertions cover reference types, applicant/source mapping, nullable fields, representative/multiple roles, affiliation and explicit registry links, no automatic matching, participant CRUD, participant search, type filtering, duplicates, rollback and seeder guard. Browser tests cover extended participant creation/search and full DOCX preview/confirmation in `geo_case_test`.

## 14. Regression Results

All Phase 1–3 assertions and the complete 21-scenario Playwright suite pass. Authentication, routing, tribe isolation, attachments, family workflows/import, settings, profiles, responsive behavior, legacy records/cases and GIS remain operational.

## 15. Actual Production Import Status

**No LCE cases were imported into `geo_case`.** Production retains 9 existing cases and 14 existing participants. The migration was applied after `database/backup_before_phase3_cases_2026_08_21.sql`; counts for cases, participants, attachments and parcels were preserved.

## 16. Remaining Phase 4 Work

Phase 4 remains limited to verified Tax Declaration review, property/document modeling and nullable parcel/case/GIS relationships. It must not fabricate source fields, property values or coordinates.
