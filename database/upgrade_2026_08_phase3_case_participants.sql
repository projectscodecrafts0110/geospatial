-- Phase 3 additive case-participant compatibility foundation.
-- Preserves all existing cases, participants, routing, attachments and GIS data.

ALTER TABLE `case_persons_involved`
    MODIFY COLUMN `role` enum('complainant','respondent','witness','representative') NOT NULL,
    ADD COLUMN `relationship_to_applicant` varchar(100) DEFAULT NULL AFTER `role`,
    ADD COLUMN `ip_record_id` int(11) DEFAULT NULL AFTER `family_member_id`,
    ADD KEY `idx_case_persons_ip_record` (`ip_record_id`),
    ADD CONSTRAINT `fk_case_persons_ip_record` FOREIGN KEY (`ip_record_id`) REFERENCES `ip_records` (`id`) ON DELETE SET NULL;

ALTER TABLE `case_applications`
    ADD COLUMN `incident_location_text` varchar(255) DEFAULT NULL AFTER `incident_province`;

-- Existing representative fields remain for backward compatibility. Populate a
-- related representative only on future create/edit/import actions; do not guess
-- or backfill legacy participant identity from names.
