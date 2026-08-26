# Phase 2 IP/Family Management and Controlled Import Report

Completed: 2026-08-21  
Production target protected: MariaDB `geo_case`, port `3307`  
Validation target: `geo_case_test`

## 1. Family Management

Implemented role-authorized family list, create, detail and edit pages using the Phase 1 `ip_families` structure. Forms support affiliation, operational ownership, complete nullable address fields, contact, ID type/number and remarks. The responsive list prioritizes head, spouse, affiliation, location and contact.

## 2. Head/Spouse Workflow

Head first and last name are required. Structured head and spouse data use `ip_family_members`. Spouse is optional: a row is created only when at least one spouse value is supplied; clearing all spouse fields removes it. Family and member changes are transactional.

## 3. Authorization

Administrators and staff retain their existing global operational access. Tribe leaders and representatives are scoped by `owning_tribe` through the existing `current_user_tribe()` authority; request-supplied ownership is ignored for those roles. Ethnic `affiliation_id` never grants access. Detail/edit and list/search paths enforce the same scope. Import is administrator-only and requires an explicit operational ownership selection.

## 4. Search/Filters

Family list search covers head/spouse names, affiliation, barangay, sitio, contact and ID number, with affiliation and barangay filters plus existing pagination. Global search now includes family records and applies operational tribe isolation before returning results.

## 5. Seeder

`scripts/seed_anonymized_families.php` provides three fictional, structurally representative families with spouse/no-spouse and nullable variations. It is idempotent by stable fictional family references and refuses any database name that is not explicitly development/test. No LCE PII is embedded.

## 6. Workbook Import Architecture

The administrator workflow is: private XLSX upload → parse headers → preview → validate and summarize → explicit confirmation → transactional import. Upload alone performs no database mutation. Temporary workbooks are stored under the operating-system temporary directory, outside public web storage, with random names and one-hour preview expiry.

## 7. Mapping

The parser verifies the workbook's grouped headers, then maps affiliation; structured head/spouse components; sex/birthdate; region, province, municipality/city, barangay, sitio/street; contact; ID type/number; and remarks to `ip_families` and `ip_family_members`. The workbook's combined “House No., Sitio/Street” source maps conservatively to `sitio_street`; `house_number` remains NULL rather than being guessed.

## 8. Normalization

Phase 1 helpers handle whitespace, explicit absence markers, sex spelling/case, suffixes and dates. Excel date serials and known explicit text formats are supported. Unknown affiliations are invalid and are never created automatically. Isnag, Isneg and Itneg remain separate canonical values.

## 9. Validation

Preview reports total, valid, warning and invalid rows; affiliation distribution; spouse/no-spouse totals; probable duplicates; and safe row-number issues. Validation of `ADAMS IP'S.xlsx` against `geo_case_test` found **424 rows: 420 valid, 4 warnings, 0 invalid; 303 with spouse and 121 without spouse**. Warnings remain visible for review and are not silently hidden.

## 10. Duplicate Handling

SHA-256 uniqueness on `import_batches.source_hash` blocks repeat submission of the same source file. `(import_batch_id, source_reference)` prevents duplicate rows within a batch. Conservative existing-family comparison uses affiliation plus exact case-insensitive head first/last name and only flags probable matches; it never merges records.

## 11. Import Transactions

A confirmed batch moves through existing `validated`, `importing`, `completed` or `failed` states. Family/member inserts are one transaction. Fatal failure rolls back every family/member row and records a safe failed-batch summary. Invalid rows are retained in preview exceptions and skipped; valid/warning rows are counted in the completed summary.

## 12. Privacy

Raw workbook contents and sensitive values are not written to audit descriptions. Audit events contain family or batch IDs and high-level changed-field/member actions. Temporary source files are random and non-public, then removed after completion. The real workbook is not embedded in fixtures or migrations.

## 13. Tests

Phase 2 adds 25 focused PHP assertions covering workbook preview/mapping, nullable data, distinct affiliations, dates, family/head/spouse CRUD behavior, search/filter bases, ownership isolation, source-file/source-row duplicates, transaction rollback and the production seeder guard. Focused browser tests cover family creation/search, optional spouse behavior, cross-tribe list/global-search isolation, and the complete preview/confirm workflow in `geo_case_test`.

## 14. Regression Results

The complete suite passes 19 browser scenarios plus all Phase 1 and Phase 2 schema assertions. Existing authentication, role routing, tribe isolation, settings, records/cases, global search, profiles, responsive layouts, mobile tables and password changes remain operational. PHP syntax checks pass.

## 15. Actual LCE Import Status

**NOT IMPORTED TO PRODUCTION.** The real workbook was parsed, previewed and transactionally exercised only in the disposable `geo_case_test` database. `geo_case` retains zero `ip_families`, zero `ip_family_members` and zero `import_batches` rows until a later explicitly authorized client import.

## 16. Remaining Phase 3 Work

Phase 3 may extend case participants, representatives, optional family-member links and case-type references. It must not infer registry matches by name, weaken ownership scope, or begin Tax Declaration/GIS parcel work.
