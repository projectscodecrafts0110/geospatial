# Phase 4 Tax Declaration, Property and GIS Relationship Report

Completed: 2026-08-21  
Production: MariaDB `geo_case`, port `3307`  
Validation: `geo_case_test`

## 1. Source Fields Implemented

Implemented the reviewed common business fields from the seven scanned forms: TD/PIN identification, printed owner, optional administrator/beneficial user, nullable location and title/survey data, textual cardinal boundaries, property kind, totals/tax status, effectivity, approval, prior declaration data, and memoranda. Missing values remain NULL.

## 2. Schema

The additive migration creates `property_types`, `tax_declarations`, `tax_declaration_assessments`, `case_tax_declarations`, and `tax_declaration_attachments`. Money uses `DECIMAL(18,2)`, area `DECIMAL(18,4)`, and assessment percentage `DECIMAL(5,2)`. A unique TD number and one nullable `taxable`/`exempt` enum prevent duplicate identifiers and contradictory tax states.

## 3. Assessment Rows

Each declaration has zero or more normalized child assessment rows. The responsive form supports repeatable add/remove controls, while the server independently validates all numeric values and preserves entered assessed values.

## 4. Property/Parcel Relationship

`ip_land_parcels` remains the sole GIS property parent. A declaration has one optional parcel FK; a parcel can therefore have many declarations over time. No competing parcel table was created.

## 5. Owner/Registry Relationship

The printed owner is always preserved. Optional `ip_record`, family-member, and family FKs are selected explicitly from authorized records. Names are never automatically matched.

## 6. Case Relationship

`case_tax_declarations` provides an optional many-to-many relationship without changing case routing. Submitted case links are reauthorized server-side.

## 7. GIS Behavior

Tax Declaration detail links to its verified parcel/map, and the parcel panel links to related declarations. Existing parcel coordinates and GeoJSON remain authoritative. Text boundaries remain text; no coordinates, polygons, or fallback geometry are generated. Parcels without geometry are safely omitted from rendering.

## 8. History/Prior Declaration

The printed previous TD/ARP number, owner, and assessed value are preserved independently. An optional self-FK records a deterministic predecessor; no fuzzy linking or deletion of history occurs.

## 9. UI

Authorized users have list, server-side search/filter, create, grouped edit, detail, assessment-row management, history/registry/case/parcel selectors, and responsive views. Search covers TD number, PIN, owner, barangay, lot, classification, and actual use.

## 10. Authorization

Admin and staff use the existing global behavior. Tribe leader/representative access is controlled by `tax_declarations.owning_tribe`, matched server-side to `current_user_tribe()`. Printed owner identity, affiliation, parcel, and case links never grant access.

## 11. Attachment Security

PDF/JPEG/PNG source documents are MIME-validated, limited to 10 MB, randomly named, and stored under `C:\xampp\private\geospatial_tax_attachments`, outside the web root. Downloads require authentication, role and declaration-scope checks, canonical path containment, and forced attachment delivery.

## 12. Seeder

`scripts/seed_anonymized_tax_declarations.php` is idempotent and refuses non-development/test databases. It creates fictional linked/unlinked current/historical land examples with nullable contacts, a predecessor, and two assessment rows. It contains no LCE Tax Declaration values.

## 13. Import Recommendation

OCR and production ingestion were intentionally not implemented. Use reviewed manual entry now; a future structured spreadsheet workflow should use human transcription, preview, validation, explicit confirmation, and transactional import.

## 14. Tests

Phase 4 has 22 focused assertions covering schema, nullability, identifiers, owners, property type, repeatable decimals, tax status, history, optional parcel/registry/case links, no geometry fabrication/name matching, scope isolation, private delivery, searchability, and the seeder production guard. All passed.

## 15. Regression Results

All Phase 1–3 schema/import assertions passed (21 + 25 + 21), all PHP syntax checks passed, and the complete Playwright suite passed 23/23 scenarios, including Phase 4 CRUD/search and cross-tribe isolation.

## 16. Production Data Status

Backup `database/backup_before_phase4_tax_2026_08_21.sql` was verified at 39,648 bytes before migration. Production counts remained 2 legacy IP records, 0 families, 9 cases, 14 participants, 13 parcels, 7 case attachments, and 27 audits. Phase 4 production contains four non-PII property-type references and zero declarations/assessments. No scanned LCE record or attachment was imported.

## 17. Remaining Final Work

Final system verification and any authorized, human-reviewed production transcription/import remain separate future work. No OCR ingestion, GIS redesign, or source-record import was started.
