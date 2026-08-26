-- Safe, additive upgrade for databases created from geo-case.sql.
-- Back up the database before applying. Statements are MariaDB 10.4 compatible.

CREATE TABLE IF NOT EXISTS `system_settings` (
    `setting_key` varchar(100) NOT NULL,
    `setting_value` text DEFAULT NULL,
    `updated_by` int(11) DEFAULT NULL,
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`setting_key`),
    KEY `idx_settings_updated_by` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS `login_attempts` (
    `attempt_key` char(64) NOT NULL,
    `attempt_count` int unsigned NOT NULL DEFAULT 0,
    `window_started_at` datetime NOT NULL,
    `last_attempt_at` datetime NOT NULL,
    PRIMARY KEY (`attempt_key`),
    KEY `idx_login_attempts_last` (`last_attempt_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO `system_settings` (`setting_key`, `setting_value`) VALUES
    ('logo_path', 'assets/images/logo.png'),
    ('theme_primary', '#177135'),
    ('theme_sidebar', '#163820'),
    ('theme_accent', '#198754');

ALTER TABLE `case_applications`
    ADD INDEX IF NOT EXISTS `idx_cases_group_assignment_created` (`applicant_ip_group`, `assigned_to`, `created_at`),
    ADD INDEX IF NOT EXISTS `idx_cases_status_created` (`status`, `created_at`),
    ADD INDEX IF NOT EXISTS `idx_cases_created_by` (`created_by`);

ALTER TABLE `ip_records`
    ADD INDEX IF NOT EXISTS `idx_records_tribe_status_created` (`tribe`, `status`, `created_at`),
    ADD INDEX IF NOT EXISTS `idx_records_created_by` (`created_by`);

ALTER TABLE `audit_logs`
    ADD INDEX IF NOT EXISTS `idx_audit_created` (`created_at`),
    ADD INDEX IF NOT EXISTS `idx_audit_action_created` (`action`, `created_at`);

ALTER TABLE `case_attachments`
    ADD INDEX IF NOT EXISTS `idx_attachments_uploaded_by` (`uploaded_by`);

-- A user should have at most one tribe assignment. Review duplicates before enabling:
-- SELECT user_id, COUNT(*) FROM user_tribes GROUP BY user_id HAVING COUNT(*) > 1;
-- ALTER TABLE user_tribes ADD UNIQUE KEY uq_user_tribes_user_id (user_id);

-- Foreign keys for creator/updater columns are intentionally not forced here. Existing
-- databases may contain orphaned legacy IDs; audit and clean those rows before adding FKs.
