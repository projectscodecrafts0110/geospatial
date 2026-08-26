# Improvement Status

Last updated: 2026-08-21  
Database target: `geo_case` on MariaDB port `3307`

## Phase 1 Real Data Foundation — Completed 2026-08-21

The additive real-data foundation migration was validated on `geo_case_test`, backed up, and applied to `geo_case`. It adds canonical IP affiliations, family/household and head/spouse member structures, minimal import provenance, extensible case-type references, and nullable compatibility links for existing IP/case records. Existing operational rows and tribe authorization behavior were preserved; no LCE personal records were imported. See `PHASE_1_REAL_DATA_FOUNDATION_REPORT.md`.

## Phase 2 IP/Family Management — Completed 2026-08-21

Family list/create/detail/edit workflows, head/spouse management, scoped search/filter/global-search integration, privacy-safe audits, an anonymized guarded seeder, and a private preview/confirm XLSX importer are complete. The real LCE workbook validates as 424 rows (420 valid, 4 warnings, 0 invalid) in `geo_case_test`; no LCE family data was imported into `geo_case`. See `PHASE_2_IP_FAMILY_IMPORT_REPORT.md`.

## Phase 3 Case/Participant Alignment — Completed 2026-08-21

Case types now use the Phase 1 reference alongside the legacy enum, participants support representative/affiliation/explicit registry links, reported incident location is preserved, participant search is active, and guarded anonymized seeding plus private DOCX preview/confirmation are complete. All six source cases validate in `geo_case_test`; none were imported to production. See `PHASE_3_CASES_PARTICIPANTS_REPORT.md`.

## Status Summary

| Area | Status | Notes |
|---|---|---|
| Authentication and sessions | Completed | Secure cookies, inactivity timeout, session regeneration, generic credential errors, persistent login throttling. |
| Authorization and IDOR | Completed | Server-side roles and tribe ownership are enforced for records, cases, actions, and attachments. |
| CSRF protection | Completed | Mutation endpoints require POST and a session-bound CSRF token, including logout. |
| File uploads | Completed | MIME/image validation, size limits, random names, execution blocking, and private attachment storage. |
| Attachment delivery | Completed | Direct web access is denied; authenticated downloads pass role and tribe checks. |
| Database configuration | Completed | Environment-aware host, port, database, user, and password settings; port defaults to 3307. |
| Database migration | Applied | Two backups created; settings, throttling, indexes, uniqueness, and user-reference foreign keys applied. |
| System settings | Completed | Admin-only logo upload/reset and global header/sidebar/accent theme colors. |
| Data fetching | Completed | Major records, cases, users, and audit listings use bounded pagination and aggregate queries. |
| Output encoding | Substantially completed | Shared escaping and high-risk audit/settings/attachment output fixed; continued escaping is required for every future template field. |
| Security headers | Completed | Frame, MIME-sniffing, referrer, and permissions protections are sent by PHP/Apache. |
| Sensitive web files | Completed | SQL files, environment files, development password tools, and direct uploads are blocked. |
| Automated test suite | Completed | Disposable database and nine authenticated Playwright scenarios cover every role, settings, resources, and responsive overflow. |
| Template consolidation | In progress | Shared record and case summary components are active; larger form/detail templates remain role-specific to limit regression risk. |
| Relational integrity | Completed | Orphans audited/remediated, one-user/one-tribe uniqueness enforced, and user references use `ON DELETE SET NULL`. |
| Scheduled maintenance | Completed | Windows task runs cleanup daily at 2:15 AM; cleanup command supports safe dry runs. |
| Global search | Completed | Topbar search is functional, role-aware, tribe-scoped, and searches records, cases, locations, people, and admin-visible users. |
| Account self-service | Completed | Every authenticated role can update profile details and securely change its password. |
| List filtering | Completed | Record, case, and user filters run server-side across the complete dataset and retain pagination parameters. |
| UI consistency and visibility | Completed | Shared spacing, focus, typography, responsive table, empty-state, tablet, and mobile visibility styles are active globally. |
| Case routing visibility | Completed | Assessor-routed land cases remain visible to the originating tribe; assessor/staff status changes redirect correctly. |

## Database Migration Status

- Pre-upgrade backup: `database/backup_before_upgrade_2026_08_11.sql`
- Pre-integrity backup: `database/backup_before_integrity_2026_08_11.sql`
- Applied migration: `database/upgrade_2026_08_security_and_indexes.sql`
- Applied integrity migration: `database/upgrade_2026_08_relational_integrity.sql`
- Confirmed new tables:
  - `system_settings`
  - `login_attempts`
- Confirmed indexes:
  - Case group/assignment/created date
  - Case status/created date
  - Record tribe/status/created date
  - Audit created date and action/created date
  - Creator/uploader lookup indexes

The integrity audit found two cases whose `created_by` values referenced deleted users (case IDs 2 and 4). Those invalid references were set to `NULL`; the case records and their business content were preserved. No duplicate tribe assignments were found. Foreign keys now prevent new orphans, while `ON DELETE SET NULL` preserves business and audit records when a user is removed.

## System Settings

Administrators can open **System Settings** from the sidebar.

Available controls:

- Upload PNG, JPEG, or WebP logo up to 2 MB.
- Restore the original system logo.
- Change header, sidebar, and accent colors.
- Restore default theme colors.

Settings are validated server-side, stored in `system_settings`, protected by administrator authorization and CSRF validation, and written to the audit log.

## Security Controls Implemented

- Five failed logins per username/IP pair trigger a 15-minute throttle window.
- Login attempts persist in the database, with a session fallback before migration.
- User-generated attachment paths are never trusted directly.
- Attachments are resolved under the expected directory using canonical paths.
- Attachment downloads are `private, no-store` and revalidate the detected MIME type.
- Tribe users cannot select or modify another tribe through request manipulation.
- Administrative audit JSON is not available to non-administrators.
- Audit data is escaped in both server-rendered pages and the live activity JavaScript.

## Planned Work Completion

1. **Completed:** `tests/bootstrap_test_db.php` recreates only `geo_case_test`, seeds every role, applies both migrations, and refuses non-test database names.
2. **Completed:** Playwright tests installed Chrome at mobile, tablet, and desktop sizes; settings theme/logo behavior and failed HTTP resources are asserted.
3. **Partially completed safely:** repeated record and case summary cards now use shared components. Large role-specific forms/details were intentionally retained because their permissions and actions differ.
4. **Completed:** all creator/updater/uploader/approver references were audited. Two invalid case creators were preserved as `NULL`, then foreign keys were enabled.
5. **Completed:** no duplicate tribe assignments existed; `uq_user_tribes_user_id` now enforces one assignment per user.
6. **Completed:** `scripts/maintenance_cleanup.php` removes expired throttle rows and old unreferenced logos. Windows task `Geospatial System Maintenance` is installed daily at 2:15 AM.

## Verification Performed

- All PHP files pass PHP 8.2 syntax validation.
- Public home and login pages return HTTP 200.
- Unauthenticated settings requests redirect to login.
- Unauthenticated attachment requests return HTTP 401.
- Direct attachment and SQL backup requests return HTTP 403.
- MariaDB 10.4.32 on port 3307 reports the new tables and indexes.
- `npm test` recreated the isolated database and passed all 16 authenticated browser tests.
- Role coverage passed for admin, tribe leader, tribe representative, assessor, and staff.
- Settings logo/theme update passed.
- Responsive overflow checks passed at 390px, 768px, and 1440px.
- Per-test HTTP monitoring reported no failed page, asset, or AJAX resources.
- Maintenance cleanup dry run completed with zero expired rows and zero eligible obsolete logos.
- Production orphan and duplicate counts are both zero after the integrity migration.

The disposable test credentials exist only in `geo_case_test`; production credentials and data are not used by the browser suite.

## Implementation Log

### 2026-08-11 — Feature Completeness and UI/UX Pass

Recommendations implemented immediately:

- Replaced the decorative topbar field with functional global search.
- Added role-aware result routing and server-side tribe isolation to global search.
- Activated the previously commented profile/password menu as a real **My Profile** workflow.
- Added profile contact/name/email editing with prepared statements, validation, CSRF protection, audit logging, and duplicate-email handling.
- Added current-password verification, 10-character minimum, confirmation matching, password hashing, session regeneration, and audit logging for password changes.
- Converted administrator record, case, and user filters from current-page-only JavaScript filtering to server-side full-dataset filtering.
- Converted tribe record and case filters to server-side, tribe-scoped filtering.
- Added filter-aware pagination and clear empty states.
- Fixed land-dispute cases disappearing from tribe lists when initially routed to the assessor.
- Fixed missing redirect handling after assessor/staff case status changes.
- Aligned case assignment validation with the roles available in the interface.
- Removed misleading placeholder comments from the established case-routing rule.
- Added automatic responsive wrappers around Bootstrap tables.
- Standardized card borders, shadows, spacing, headings, labels, input height, focus visibility, table headers, and empty states.
- Fixed the tablet layout retaining space for a hidden activity panel.
- Improved mobile content padding and page-heading stacking.

Tests added and verified:

- Global search returns authorized records, cases, and users.
- Record filters search the complete dataset and display empty states.
- Assessor-routed land cases remain visible to their tribe.
- Tribe search and filters do not expose another tribe’s records or cases.
- Users can update their own profiles.
- Users can change passwords and authenticate with the replacement.
- Record, case, and user pages have no horizontal page overflow at 390px.
- Existing role authentication, settings, failed-resource monitoring, and responsive tests continue to pass.

Final result for this pass: **16/16 Playwright tests passed**, and all PHP files passed PHP 8.2 syntax validation.

### 2026-08-21 — Phase 4 Tax Declaration and GIS Relationships

- Added normalized Tax Declaration, repeatable assessment, property-type, case-link, history, owner-registry link, and private-document structures.
- Reused `ip_land_parcels` as the only GIS parent; added bidirectional navigation without creating or inferring geometry.
- Added role/scoped CRUD, search/filter, grouped responsive forms, audit-safe save behavior, and private attachment delivery.
- Added production-guarded anonymized fixtures and 22 focused assertions.
- Verified the additive migration on `geo_case_test`, backed up production, then migrated `geo_case` without changing existing business counts or importing source records.
- Regression result: Phase 1–4 schema assertions passed and Playwright passed 23/23 scenarios.

### 2026-08-21 — Role, Case Hierarchy, Sidebar and Map Workflow

- Rebuilt desktop/mobile navigation from one role-aware menu definition, with active states and complete representative/assessor workspaces.
- Enforced case routing through shared server-side workflow rules. New, imported, edited, and manually assigned active land disputes remain routed to the assessor.
- Limited the assessor queue to assessor-assigned cases and the staff queue to staff-assigned/created cases.
- Enforced ordered status transitions: assessors perform land technical review, tribe leaders decide reviewed cases, staff cannot resolve, and only administrators can override lifecycle order.
- Added read-only Tax Declaration and parcel-map evidence access for assessors while retaining edit authority with existing authorized roles.
- Connected parcel map panels to linked Tax Declarations and displayed their textual North/South/East/West boundary references without treating them as geometry.
- Added parcel deep-link selection/zoom and retained safe handling for parcels without coordinates or GeoJSON.
- Corrected one older active production land-dispute assignment to `assessor` and recorded one `NORMALIZE_CASE_ROUTING` audit event; both production land disputes are now correctly routed.
- Added 14 hierarchy/map assertions and two role-navigation browser scenarios. Result: all schema assertions and 25/25 browser tests passed.

### 2026-08-21 — Authenticated UI/UX and Family-Centered Integration

- Added a shared authenticated design language for workspace headers, actions, metrics, module cards, filter bars, relationship chips, tables, and responsive layouts.
- Replaced the administrator overview's sample markers and hard-coded counters with live family, member, case, assessor queue, parcel, Tax Declaration, and user indicators.
- Made IP Families the relationship hub: family detail now shows explicitly linked individual records, case participants, Tax Declarations, and parcels without name-based inference.
- Added family membership context to People & Registry and family/Tax Declaration connection counts to Case Management.
- Extended reports with household/member and explicit record/case/parcel linkage indicators.
- Added audit module filtering and contextual links back to supported family, person, case, and Tax Declaration records.
- Updated user administration to show operational tribe scope and its family count without per-row database queries.
- Enhanced parcel map evidence cards with linked Tax Declaration boundary descriptions and explicit registered-family references.
- Removed the disconnected demonstration map from the administrator overview; the authoritative parcel map remains the GIS source.
- All schema/hierarchy assertions, the existing 25-scenario browser regression, and a focused connected-administration browser pass succeeded.

### 2026-08-21 — Phase 5 Final Real-Data Verification

- Verified the live Phase 1–4 schema, columns, FKs/delete rules, checks, uniqueness, indexes, nullable fields, DECIMAL types, provenance, and production counts against actual MariaDB metadata.
- Reparsed the available workbook (424 total; 420 valid; 4 warnings; 303 spouse; 121 without spouse) and DOCX (6/6 valid) only through `geo_case_test`.
- Added a 15-assertion transactional cross-phase workflow covering family/head/spouse, linked/unlinked case participants, assessor routing, Tax Declaration assessment, parcel/case/family links, audit, scope denial, and rollback.
- Re-ran all anonymized seeders twice with stable counts and verified their production refusal assertions.
- Repaired global search to return bounded, role-scoped Tax Declaration results.
- Added Phase 1–4 responsive coverage at 390px, 768px, and 1440px plus connected module verification.
- All PHP files and 118 schema/workflow assertions passed. Browser outcomes are clean after repairing and rerunning one ambiguous test locator; no test was skipped.
- Production business counts were preserved. Actual pre-existing production state includes one completed 424-family workbook batch; cases remain 9 and Tax Declarations remain zero. Two unrelated production role-login audits occurred during verification.
- Final evidence: `FINAL_REAL_DATA_VERIFICATION_REPORT.md` and `FINAL_REAL_DATA_MANUAL_QA.md`.

### 2026-08-21 — Final UI/UX Professionalization

- Consolidated the authenticated interface around one institutional design system for navigation, workspace headers, cards, metrics, filters, forms, tables, relationships, status indicators, alerts, modals, and empty states.
- Added accessible skip navigation, keyboard focus treatment, reduced-motion behavior, improved mobile navigation semantics, and consistent responsive action stacking.
- Reorganized the family form into clear classification, address, contact/identification, head, and optional spouse sections without changing submitted fields or validation rules.
- Added a shared five-stage progress presentation to the controlled family and case import workflows.
- Visually reviewed 15 representative authenticated pages at 1440px, 768px, and 390px; all 45 captures passed horizontal-overflow checks, including desktop pages with the reserved live audit/detail rail.
- Re-ran the complete suite: all 118 schema/workflow assertions and 30/30 Playwright scenarios passed.
- No intentional changes were made to business logic, routes, permissions, schema, case hierarchy, record relationships, parcel geometry, imports, or production data.
- Final evidence: `FINAL_UI_UX_REVIEW_REPORT.md`.
