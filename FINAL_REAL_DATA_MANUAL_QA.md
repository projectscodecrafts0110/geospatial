# Final Real-Data Manual QA Checklist

Use an authorized test/staging environment unless a step is explicitly read-only. Never upload LCE source files to an unintended database.

## Roles

- **Administrator:** Open Overview, People & Registry, Families, Cases, Tax Declarations, Parcel Map, Users, Audit Logs, Reports, and Settings. Expected: global authorized visibility and mutation controls.
- **Tribe Leader:** Verify only the assigned operational tribe appears in families, cases, global search, and Tax Declarations. Attempt a copied cross-tribe detail URL. Expected: HTTP 403/no data.
- **Tribe Representative:** Create a scoped family/case and verify request-supplied ownership cannot change the account's tribe. Expected: saved under the account scope.
- **Assessor:** Open the assessment queue, Tax evidence, and parcel map. Expected: only assessor-assigned cases; read-only Tax Declaration/map evidence; no final resolution or parcel edit.
- **Staff:** Verify assigned/created work, family and Tax Declaration entry, and inability to resolve a case. Expected: support functions without approval authority.

## Families and Registry

- Create a family with structured head fields and blank optional spouse. Expected: one head and no spouse row.
- Add, edit, then clear spouse fields. Expected: spouse row added/updated/removed transactionally.
- Verify nullable address/contact/ID/remarks values stay blank rather than becoming placeholders.
- Search head/spouse/location and filter affiliation/barangay. Expected: full-dataset server results and pagination.
- Open family detail. Expected: explicit individual, case, Tax Declaration, and parcel-related context only; no name-inferred links.

## Controlled Imports

- Upload the workbook to preview in `geo_case_test`. Expected: no database mutation before confirmation; current source result 424 total, 420 valid, 4 warnings, 0 invalid, 303 spouse, 121 without spouse.
- Confirm only in disposable test. Expected: one transaction, batch provenance, reviewed operational ownership, duplicate file/row rejection.
- Upload the case DOCX to preview. Expected: 6 valid cases, extracted participant roles, no registry auto-match, and no mutation before confirmation.
- Confirm in disposable test. Expected: cases then participants inserted transactionally; land disputes routed to assessor.

## Cases and Participants

- Create/edit applicant, representative, location, description, and multiple participant roles.
- Link one participant explicitly to a family member and leave another unregistered. Expected: both valid.
- Attempt to route an active land dispute away from assessor. Expected: server restores assessor assignment.
- Move land case pending → ongoing → under review as assessor, then resolve as tribe leader/admin. Expected: hierarchy enforced.
- Search by participant and incident location; filter type/status. Expected: full-dataset authorized results.

## Tax Declarations and GIS

- Create taxable and exempt examples with nullable owner/admin/title fields and multiple decimal assessment rows.
- Link a new declaration to an existing historical declaration. Expected: old record remains and printed prior reference is retained.
- Link/unlink a parcel, family/member, and case explicitly. Expected: relationships update without changing printed owner.
- Leave parcel blank. Expected: declaration remains valid and no coordinates/GeoJSON are created.
- Open linked parcel map. Expected: authoritative existing geometry plus linked TD boundary descriptions; textual N/S/E/W values are not drawn as geometry.
- Open a parcel without geometry if available. Expected: map does not crash or invent a marker.

## Attachments, Audit, and Privacy

- Upload allowed case/TD PDF or image under size limit; reject disallowed MIME/oversized file.
- Attempt direct URL access and copied cross-scope download. Expected: direct access denied and authenticated endpoint reauthorizes.
- Review audit filters and linked records. Expected: IDs/change categories without TIN, contact, monetary tables, or full source content.

## Search and Responsive Layout

- Use global search for a person, family, participant/case, and TD number. Expected: role-scoped results from each module.
- Repeat key list/create/detail/import workflows at 390px, 768px, and 1440px. Expected: no page-level horizontal overflow; repeatable rows and actions remain usable.

## Release Gate

- Confirm `.env` targets the intended database, backups are current, Apache honors `uploads/.htaccess`, `C:\xampp\private\geospatial_tax_attachments` is access-restricted, maintenance is scheduled, and source files are outside public/versioned locations.
- Record production counts immediately before and after any authorized import and reconcile batch totals/exceptions.
