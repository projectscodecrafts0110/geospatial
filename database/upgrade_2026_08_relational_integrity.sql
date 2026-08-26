-- One-time relational-integrity upgrade.
-- Run the orphan/duplicate audit queries in IMPROVEMENT_STATUS.md first.

UPDATE case_applications c
LEFT JOIN users u ON u.id = c.created_by
SET c.created_by = NULL
WHERE c.created_by IS NOT NULL AND u.id IS NULL;

ALTER TABLE user_tribes
    ADD CONSTRAINT uq_user_tribes_user_id UNIQUE (user_id);

ALTER TABLE audit_logs
    ADD CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE case_applications
    ADD CONSTRAINT fk_cases_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE case_attachments
    ADD CONSTRAINT fk_attachments_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE ip_records
    ADD CONSTRAINT fk_records_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_records_approved_by FOREIGN KEY (approved_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE ip_land_parcels
    ADD CONSTRAINT fk_parcels_created_by FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    ADD CONSTRAINT fk_parcels_updated_by FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL;

ALTER TABLE system_settings
    ADD CONSTRAINT fk_settings_updated_by FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL;
