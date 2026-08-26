-- Fresh operational-data reset for geo_case.
-- Preserves schema, reference catalogs, system settings, and the administrator user ID 1.
-- Apply only after verifying backup_before_fresh_start_2026_08_21.sql.

START TRANSACTION;

DELETE FROM tax_declaration_attachments;
DELETE FROM tax_declaration_assessments;
DELETE FROM case_tax_declarations;
DELETE FROM case_attachments;
DELETE FROM case_persons_involved;
DELETE FROM tax_declarations;
DELETE FROM case_applications;

UPDATE ip_records SET family_member_id = NULL;
DELETE FROM ip_records;
DELETE FROM ip_family_members;
DELETE FROM ip_families;
DELETE FROM import_batches;
DELETE FROM ip_land_parcels;

DELETE FROM audit_logs;
DELETE FROM login_attempts;
DELETE FROM user_tribes;
DELETE FROM users WHERE id <> 1;

COMMIT;

ALTER TABLE audit_logs AUTO_INCREMENT = 1;
ALTER TABLE case_applications AUTO_INCREMENT = 1;
ALTER TABLE case_attachments AUTO_INCREMENT = 1;
ALTER TABLE case_persons_involved AUTO_INCREMENT = 1;
ALTER TABLE case_tax_declarations AUTO_INCREMENT = 1;
ALTER TABLE import_batches AUTO_INCREMENT = 1;
ALTER TABLE ip_families AUTO_INCREMENT = 1;
ALTER TABLE ip_family_members AUTO_INCREMENT = 1;
ALTER TABLE ip_land_parcels AUTO_INCREMENT = 1;
ALTER TABLE ip_records AUTO_INCREMENT = 1;
ALTER TABLE login_attempts AUTO_INCREMENT = 1;
ALTER TABLE tax_declaration_assessments AUTO_INCREMENT = 1;
ALTER TABLE tax_declaration_attachments AUTO_INCREMENT = 1;
ALTER TABLE tax_declarations AUTO_INCREMENT = 1;
ALTER TABLE user_tribes AUTO_INCREMENT = 1;

-- Fail visibly during verification if the intended administrator was not preserved.
SELECT CASE
    WHEN COUNT(*) = 1 AND MIN(id) = 1 AND MIN(role) = 'admin' AND MIN(status) = 'active' THEN 'ADMIN_PRESERVED'
    ELSE 'ADMIN_VERIFICATION_FAILED'
END AS reset_verification
FROM users;
