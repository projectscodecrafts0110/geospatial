# Real Data Requirements Audit

Audit date: 2026-08-21  
Database target reviewed: MariaDB `geo_case`, port `3307`  
Scope: planning only; no schema, form, GIS, seeder, import, or data changes were made.

## 1. Executive Summary

The working system covers a basic individual IP record, case intake, multiple case persons, attachments, point/polygon GIS parcels, role/tribe isolation, and audit logs. It does **not** yet model the LCE workbook's family unit, structured head/spouse names, complete address/contact/ID data, or relational links among cases, registry people, parcels, and Tax Declarations.

The smallest maintainable direction is a `families`/household record with related `family_members` (head and optional spouse), while preserving `ip_records` during a backward-compatible transition. Existing `case_persons_involved` should be extended rather than replaced. Tribe/IP affiliation values should be canonicalized in one reference structure while preserving tribe-scoped authorization.

Source review found 424 populated IP/family rows, 6 cases, 18 named case participants, and six raw affiliation spellings. `TAX DEC.pdf` contains seven scanned pages with no extractable text; detailed Tax Declaration fields remain **SOURCE DOCUMENT REVIEW REQUIRED**.

## 2. Current Relevant Schema

| Table | Relevant content and relationships |
|---|---|
| `ip_records` | One individual-like record: reference, full name, gender, birthdate, sitio/barangay/municipality, point coordinates, free-text tribe, workflow, remarks, creator/approver. No family, spouse, structured name, contact, ID, region/province, house number, parcel, or case FK. |
| `case_applications` | Applicant and optional representative fields, case details, fixed-plus-`other` case type enum, incident barangay/municipality/province, workflow and creator. No registry, parcel, or coordinate FK/columns in the reviewed schema. |
| `case_persons_involved` | Many rows per case through `case_id`; name, role enum (complainant/respondent/witness), contact. Cascade delete from case. |
| `case_attachments` | Many files per case; uploader FK. Can hold land/tax evidence only as an undifferentiated case attachment. |
| `ip_land_parcels` | Land label/description, textual location, nullable point, GeoJSON boundary, free-text owner, owner/status enums, one ownership-document path, audit users. No registry/family/case/tax relationship. |
| `user_tribes` / `users` | One tribe assignment per user after integrity upgrade; used to enforce tribe isolation. Tribe is text, not a tribe reference FK. |
| `audit_logs` | Generic actor/action/module/record/description log reused across records, cases and parcels. |

Relevant applied upgrades add indexes, settings/throttling tables, user-reference FKs, and one-user/one-tribe uniqueness. No import subsystem or seeders were found.

## 3. IP / Family Field Gap

Coverage codes include the database, create/edit/detail/list/search/filter and audit/import paths; a database column alone is not treated as complete support.

| Real field(s) | Classification | Current coverage / gap |
|---|---|---|
| IP affiliation / ethnicity / tribe | PARTIALLY SUPPORTED | `ip_records.tribe`, forms, detail, lists, filters/search, audit, and authorization use text. No canonical reference; source has spelling variants. No import. |
| Head last/first/middle/suffix | SUPPORTED UNDER DIFFERENT NAME / PARTIALLY SUPPORTED | Only combined `full_name`; create/detail/list/search support it, but components cannot be preserved or reliably searched. Edit variants expose fewer fields. |
| Head sex | ALREADY SUPPORTED / PARTIALLY SUPPORTED | `gender` exists and appears on create/detail/list, but admin edit does not edit it; values are loosely typed. |
| Head birthday | ALREADY SUPPORTED / PARTIALLY SUPPORTED | Nullable `birthdate` exists and is shown, but admin/tribe edit paths do not consistently edit it. |
| Spouse name components, sex, birthday | MISSING / INCORRECT RELATIONSHIP | No spouse or family relationship exists anywhere. |
| Region | MISSING | No DB/UI/search/audit/import support. |
| Province | MISSING | No IP-record support (case/parcel province is unrelated). |
| Municipality/city | ALREADY SUPPORTED / PARTIALLY SUPPORTED | Text column and UI/search exist; currently required by create processing although source completeness should govern nullability. |
| Barangay | ALREADY SUPPORTED / PARTIALLY SUPPORTED | Text column and UI/search/filter exist; create processing requires it. |
| House no. | MISSING | No support. |
| Sitio/street | PARTIALLY SUPPORTED | `sitio` can be reused, but it combines neither house number nor explicit street semantics; edit support is inconsistent and global search omits it. |
| Contact number | MISSING | User/case contacts are different domains; none on registry/family. |
| ID type and ID number | MISSING | No registry identification fields. |
| Remarks | PARTIALLY SUPPORTED | Nullable DB column exists and detail displays it, but create/edit forms and processing do not capture/update it; not searchable/audited at field level. |
| Coordinates | ALREADY SUPPORTED, source-optional | Nullable point exists. It is not present in the workbook and must never be fabricated. |

## 4. Family / Household Architecture Assessment

Current `ip_records` represents an individual, not the workbook's one-row family/household. Option A (placing all spouse fields on `ip_records`) is initially simple but duplicates person attributes and cannot grow cleanly. Option B alone lacks the family-level address/contact/ID context. Recommended minimum is **D, a combination**:

- Add a family/household entity for source row identity, affiliation and shared geography/contact/ID/remarks.
- Add related members with a constrained role such as `head` or `spouse`; spouse is optional and member attributes are nullable.
- During migration, preserve and optionally link existing `ip_records`; do not discard or rewrite demonstration records. Decide in implementation design whether `ip_records` becomes the member table or is bridged to it, based on migration impact.

This supports the present two-person source without inventing a generalized genealogy system.

## 5. Tribe / Ethnicity Assessment

The source has raw values `Isnag`, `Isneg`, `Itneg`, `Kankanaey`, `Tinguian`, and `Yapayao`. Whether near-spellings are synonyms requires LCE/NCIP confirmation; they must not be automatically merged. Registry affiliation can reuse the same canonical tribe concept **if** it is the same organizational grouping used for ownership. If a person may affiliate with one ethnicity while a record is operationally owned by another office/tribe scope, retain separate `affiliation_id` and `owning_tribe_id` semantics.

Do not add a second free-text ethnicity column. Introduce/reuse one canonical affiliation reference and migrate `ip_records.tribe`, `case_applications.applicant_ip_group`, and `user_tribes.tribe` carefully. Authorization must continue to use an explicit ownership/scope key, not untrusted display text.

## 6. Case Field Gap

| Real field(s) | Classification | Current coverage / gap |
|---|---|---|
| Applicant full name | ALREADY SUPPORTED | Required field, forms/detail/list/search/audit summary; combined name only. |
| Gender, DOB, contact, email, address, affiliation | ALREADY/PARTIALLY SUPPORTED | Nullable case columns and create/edit/detail coverage. Affiliation is free text; no registry link. Source contacts/emails are mostly absent and must stay null. |
| Representative name, relationship, contact | ALREADY SUPPORTED / PARTIALLY SUPPORTED | Optional fixed fields in forms/detail. Not normalized or linkable to registry; not searched. |
| Case title, incident date, description | ALREADY SUPPORTED | Stored and displayed; title searchable. Incident date/description are not list filters. |
| Type of case | PARTIALLY SUPPORTED / INCORRECT DATA TYPE | Enum has the five observed types plus `other` and `case_type_other`. It works today but schema changes are needed for future categories; a reference table is safer than a permanent enum. |
| Incident location | PARTIALLY SUPPORTED | Three textual components exist. Source sometimes gives a free-form location (including Laoag City); no sitio/street/free-text preservation field, coordinates, GIS location, or parcel relation. |
| Multiple involved people | ALREADY SUPPORTED / PARTIALLY SUPPORTED | Related table and repeatable forms support complainant/respondent/witness. Participant details and registry links are missing; edit deletes/reinserts rows, weakening stable identity/audit history. |
| Attachments | ALREADY SUPPORTED | Secure many-per-case files; no document classification or parcel/tax relationship. |

The Word source contains 6 cases and maps cleanly to the five existing categories. One source gender typo (`Famale`) and mixed date formats require controlled normalization with retained import provenance/error reporting.

## 7. Persons-Involved Relationship Assessment

The architecture already supports `case -> many case_persons_involved` with a role. Reuse it. Add, rather than replace, optional participant attributes needed for independent persons (gender, DOB, email, address, affiliation), an optional registry/member link, and stable audit behavior. Consider a role reference or extensible validated string if roles may expand; the current enum excludes `Representative`. Enforce at least the business-required complainant/applicant role only after LCE rules are confirmed. Do not force non-registered people into the IP registry.

## 8. Representative Handling

Use the participant structure with role `representative` once it can carry `relationship_to_applicant`; this avoids duplicate person/contact models and permits more than one representative if later required. Preserve existing `rep_*` columns during transition and backfill/link additively. If policy guarantees exactly one representative, a case-level relationship remains acceptable, but the participant reuse is cleaner and matches current many-person architecture.

## 9. Case ↔ IP Registry Relationship

Add nullable `ip_record_id` or, preferably after the family design is settled, nullable `family_member_id` on each case participant. It should use a preserving delete policy (`SET NULL`) so case history survives registry removal. Optionally link the case's primary applicant to the corresponding participant instead of maintaining two unsynchronized copies. Matching must be explicit/user-confirmed; names alone are not a safe automatic key.

## 10. Current Land / Property Structure

`ip_land_parcels` supports a label, description, textual barangay/municipality/province, nullable latitude/longitude, valid GeoJSON boundary, owner name/type, ownership and record status, a single document path, and creator/updater audit references. The admin GIS page renders boundaries or point markers and permits edits to name, owner and ownership status.

Missing are parcel/title/tax identifiers, structured claimant/owner relationships, assessed/property values, document metadata/history, and joins to families/IP records, cases, or Tax Declarations. The current owner is free text and `ownership_document` is only a path, not an attachment entity.

## 11. Current GIS Structure

- IP records can have an optional point and appear on role dashboards/detail maps.
- Land parcels can have an optional point or GeoJSON boundary on the admin GIS map.
- Cases store only textual incident components. Case views reference latitude/longitude conditionally, but those columns are absent from the reviewed schema and forms, indicating incomplete/dead display logic rather than supported GIS.
- There are no relational paths for family → location, land case → parcel, tax declaration → parcel, or case → incident geometry.

Recommended links are nullable: family/household to a location/address (point only when supplied or legitimately geocoded), property to its parcel geometry, case to optional incident location, and land cases/tax declarations to optional parcel IDs. Never substitute the map's display center as record coordinates.

## 12. Tax Declaration Review Status

**SOURCE DOCUMENT REVIEW REQUIRED.** `TAX DEC.pdf` is present and has 7 pages, but all are scanned/image-based and yield no extractable text. Reliable OCR plus visual verification or manual transcription is required before defining fields or counting declarations/properties.

No Tax Declaration model or number exists. Owner/claimant is only free text on parcels; parcel location/geometry exists; assessed/property values do not; case attachments can hold a PDF but do not classify it; and no tax-to-parcel or tax-to-case relationship exists.

## 13. Proposed Additive Schema Changes

No SQL is proposed in this phase. Conceptually:

1. Canonical tribe/IP-affiliation reference with an explicit, preserved authorization ownership mapping.
2. Family/household entity with source identity, affiliation, shared address, contact, ID and remarks; related member rows for head/spouse and structured nullable names/demographics.
3. Extend case participants with optional registry/member link and representative support; retain existing case/applicant columns during transition.
4. Replace/bridge the case-type enum with a reference table supporting active/inactive categories and `other` detail.
5. Add nullable incident-location/parcel relationships and a case–parcel relationship suitable for land cases.
6. After verified Tax Declaration review, add a tax-declaration entity, document metadata, and nullable parcel/case/claimant relationships. Use the existing secure attachment architecture rather than raw public paths.

All changes should be additive, indexed for new searches, FK-backed, and deployed with reversible/backward-compatible data migration.

## 14. Existing Fields / Tables to Reuse

- Reuse `ip_records` identity/workflow/audit fields during transition; reuse `birthdate`, `gender`, `remarks`, textual geography and nullable coordinates where their meaning matches.
- Reuse a canonicalized form of existing tribe values and preserve `user_tribes` isolation.
- Reuse `case_applications`, `case_persons_involved`, `case_attachments`, case workflow/routing, and `case_type_other` semantics.
- Reuse `ip_land_parcels` point/GeoJSON and ownership workflow.
- Reuse `audit_logs` and existing authenticated attachment delivery.

## 15. Fields / Tables That Should NOT Be Added

- No duplicate free-text `ethnicity` beside a canonical tribe/affiliation key.
- No `spouse_*` block on both IP and family tables.
- No separate complainant/respondent/witness tables; roles belong on participant rows.
- No second representative table if participants support the role cleanly.
- No case-specific parcel clone, Tax Declaration values, or coordinates inferred from addresses.
- No new attachment security/audit subsystem and no permanent enum based only on observed examples.

## 16. Data Normalization Requirements

| Domain | Rule |
|---|---|
| Dates | Parse explicit source formats (`DD/MM/YYYY`, month-name dates); reject/flag ambiguous values for review; store as ISO dates only after validation. |
| Sex/gender | Trim/case-fold and map confirmed spelling variants (for example source `FEmale`/`Famale`) to canonical display values; preserve raw import value/provenance for exceptions. |
| Affiliations | Trim and canonicalize capitalization through a reviewed alias map. Do not merge Isnag/Isneg/Itneg without authority. |
| Names/suffixes | Trim/collapse whitespace; preserve source components and punctuation; normalize suffix display (`Sr`, `Sr.`) through reviewed rules without changing identity. |
| Missing values | Convert blank and explicit placeholders such as `n/a`/`none` to NULL only when they clearly mean absent; never make them people or literal data. |
| Contact/IDs | Store as strings, trim whitespace, retain leading zeros; validate format without inventing values. ID number uniqueness must wait for source/business verification. |
| Addresses/geography | Preserve components and original free-form text where needed; canonicalize verified place names, not approximate coordinates. |
| Case categories | Map source labels to controlled category records; retain unmatched source text for review/`other`. |

## 17. Nullable / Optional Field Recommendations

Allow NULL for middle name, suffix, spouse and all spouse attributes, birthday, sex/gender when absent, house number, sitio/street, contact, ID type/number, remarks, email, representative data, incident subcomponents, coordinates/geometries, parcel/case/registry links, assessed values, and source-document metadata not present. Head first/last name and affiliation appear foundational, but mandatory constraints should be enabled only after all 424 rows pass source validation. Do not use `N/A`, `Unknown`, zero dates, fake contacts/IDs/addresses, or fallback coordinates.

## 18. Search / Filter Impact

Eventually add role-scoped search for structured head/spouse/member names, affiliation, family/source reference, municipality, barangay, sitio/street, ID type (with sensitive ID-number search restricted and masked), case participant/role, case type, incident date/location, parcel/property identifier, and Tax Declaration number. Index canonical keys and dates. Extend existing server-side pagination/filtering and tribe isolation; do not expose cross-tribe results.

## 19. Audit Impact

Reuse `audit_logs` for family/member create/update/link changes, affiliation and ownership-scope changes, participant additions/edits/removals, representative changes, registry links, case fields, parcels/geometries, Tax Declaration metadata and associations, and import batches. Avoid personal data dumps in descriptions: log record IDs, changed field names, actor, reason and batch/source reference, with sensitive values masked. Replace participant delete-and-reinsert editing with stable row updates where practical so history is meaningful.

## 20. Seeder Mapping Plan

| Source | Source field(s) | Proposed table | Proposed column(s) | Normalization | Nullable | Notes |
|---|---|---|---|---|---|---|
| `ADAMS IP'S.xlsx` | Row/serial | family/household | `source_ref`, source batch | Preserve workbook row/declared serial | No after validation | Candidate repeatability key only after uniqueness check. |
| Workbook | IP affiliation | affiliation + family | canonical affiliation FK | Trim/case/approved aliases | Prefer no | Six raw spellings; synonym review required. |
| Workbook | Head name components, sex, birthday | family member | names, suffix, sex, DOB, role=`head` | Component-preserving; validated date/value map | Components/DOB yes | Do not collapse source components into one field only. |
| Workbook | Spouse components, sex, birthday | family member | same, role=`spouse` | Placeholders to NULL | Yes; entire row optional | Create no spouse member for explicit absence. |
| Workbook | Region/province/municipality/barangay/house/sitio | family/address | component columns | Canonical place labels; trim | Yes | Region value is `1`; confirm whether code/display should be `Region I`. |
| Workbook | Contact, ID type/number, remarks | family | corresponding string/text fields | Trim; preserve leading zeros | Yes | Workbook has 0 contacts, 1 ID type, 1 ID number, 0 remarks populated. |
| `BRGY ADAMS CASES.docx` | Applicant fields | case + primary participant | applicant/participant fields | Dates, gender typo, address parsing | Yes except confirmed primary name | Six cases. Email is present only where supplied. |
| Word document | Representative fields | case participant | role=`representative`, relationship, contact | Blanks to NULL | Yes | Two observed representatives; verify count during import QA. |
| Word document | Case title/type/date/location/description | case | existing case fields plus location preservation/link | Controlled type; validated dates | Mostly yes | Reuse existing five category records. |
| Word document | Persons involved | case participant | name, role, optional registry link/contact | Role map; explicit matching only | Contact/link yes | 18 named participants: 6 each complainant/respondent/witness. |
| `TAX DEC.pdf` | Unverified scanned fields | tax declaration/property | TBD | OCR + human verification | TBD | SOURCE DOCUMENT REVIEW REQUIRED; no seeder yet. |

Estimated seedable/source records: 424 family rows; up to 848 head/spouse members before excluding absent spouse placeholders/blanks; 6 cases; 18 named complainant/respondent/witness participants plus 2 observed representatives; 6 raw affiliation spellings pending canonical review; region/province/municipality/barangay values plus 9 distinct populated sitio/street values. Exact spouse/member count should be computed by the validated importer. Land/property and Tax Declaration record counts are **SOURCE DOCUMENT REVIEW REQUIRED**.

## 21. Seeder Dependency Order

1. Canonical affiliations and any verified geographic reference values.
2. Families/households, then head/spouse members.
3. Cases, then participants/representatives.
4. Explicit participant ↔ registry links only after reviewed matching.
5. Properties/parcels, Tax Declarations and case/property associations only after PDF verification.

Users/ownership scopes must exist before assigning source data; creator/import-batch references must use an authorized service/admin account. FKs should use source-preserving delete behavior appropriate to each relationship.

## 22. Source Data Normalization Plan

Stage source rows without changing the documents; record source file, sheet/page, row, raw values, normalized values, validation result and import batch. Produce an exception report for ambiguous dates, affiliations, duplicates and partially populated spouse/ID rows. Review exceptions with LCE, then import inside a transaction with row-level outcomes. Use a verified source key or source-file hash + sheet/row + business identity for safe repeatability; do not declare names alone unique.

## 23. Seeder vs Production Import Recommendation

Use **C: split workflows**:

- A development/test seeder containing anonymized, structurally representative data derived from source patterns and guarded to run only when the environment/database is explicitly development/test (`geo_case_test` or approved development DB). It must never truncate or overwrite operational data.
- A controlled, authenticated client import for exact LCE records, with preview/dry run, validation and exception reports, import batch/audit provenance, transactions, explicit duplicate handling, idempotency, and rollback/reconciliation support.

Actual personal records should not be shipped as an ordinary source-controlled seeder. Exact seed/import natural keys require source and duplicate analysis before implementation.

## 24. Privacy / Sensitive Data Considerations

The workbook and case document contain real names, birthdates, affiliations, addresses and relationships. Keep originals outside public repositories and web roots where possible; restrict filesystem and application access. Use anonymized developer fixtures, masked UI/log output for IDs/contact data, no sensitive screenshots, and encrypted/controlled backups. Exact imports belong only in the authorized client environment with retention, access and disclosure rules agreed with LCE. Do not include source PII in audit descriptions or error traces.

## 25. Regression Risks

- Replacing free-text tribe values can break tribe authorization, case visibility and routing; map ownership explicitly and test every role.
- Changing `ip_records` semantics can break approvals, reports, global search, lists and point maps; transition additively.
- Participant normalization can duplicate the fixed applicant or lose history if current delete/reinsert editing persists.
- Replacing the case enum affects filters/status dashboards and existing values.
- New parcel/case/tax relationships can expose attachments or cross-tribe data if access checks are not inherited.
- Nullable source data conflicts with current create validation and empty-string writes; implementation must distinguish NULL safely.
- GIS rendering currently assumes a parcel without GeoJSON has coordinates; nullable geometry needs a no-location path.

Preserve authentication, sessions, authorization/IDOR controls, CSRF, secure uploads/downloads, settings, pagination, server filters, search, audit logs, integrity migrations, maintenance, case routing, and `geo_case_test` isolation.

## 26. Recommended Implementation Order

1. **Phase 1 — Schema alignment and normalization foundations:** canonical affiliations/ownership distinction, family/member design, source staging/import provenance and additive compatibility plan.
2. **Phase 2 — IP/family registry and data workflow:** forms/search/audit updates, anonymized development seeder, and controlled workbook import with validation.
3. **Phase 3 — Cases and participants:** extend participants/representatives, optional registry links, extensible case types, source-based case import/seeder.
4. **Phase 4 — Tax Declaration, property and GIS:** OCR/manual source verification first; then verified tax/property fields, secure documents and nullable parcel/case/GIS links.
5. **Phase 5 — Regression and data verification:** role/tribe isolation, privacy, import idempotency, counts/reconciliation, NULL handling, search, audit, attachments and maps.

## Final Gap Matrix

| Domain | Existing Coverage | Missing / Incorrect | DB Change Needed | Seeder/Import Needed |
|---|---|---|---|---|
| IP Registry | Basic individual, tribe, demographics, locality, point, workflow | Structured name, full address, contact/ID; inconsistent edit/audit coverage | Yes, additive | Workbook import + anonymized seeder |
| Family / Household | None | Family entity, head/spouse roles/shared data | Yes | 424 source rows |
| Tribe / Ethnicity | Free text plus user tribe scope | Canonical reference; ownership vs affiliation distinction | Yes, carefully | Six raw values pending review |
| Cases | Most source intake fields, workflow, attachments | Extensible type; preserved free-form/GIS location; registry/property links | Yes | 6 cases |
| Case Participants | Many per case with 3 roles | Rich details, stable updates/audit, optional registry link | Yes | 18 named persons |
| Representatives | Optional fixed fields | Unified participant role/linking | Yes/transition | 2 observed; verify |
| Land / Property | Parcel point/polygon, free-text owner/status/document path | Structured identifiers/owners/documents and relationships | Yes | Await verified source |
| Tax Declaration | None | Entire verified model, values, documents and links | Yes after review | SOURCE DOCUMENT REVIEW REQUIRED |
| GIS Relationships | IP points and parcel point/GeoJSON | Family/case/tax/parcel links; safe missing-geometry handling | Yes | No fabricated coordinates |

