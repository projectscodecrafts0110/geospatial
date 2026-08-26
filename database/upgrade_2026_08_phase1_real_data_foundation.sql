-- Phase 1: real-data schema alignment and normalization foundations.
-- Additive only. No LCE personal records are included or imported.
-- Validate on geo_case_test before applying once to geo_case.

CREATE TABLE `import_batches` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `source_type` enum('ip_family_workbook','case_document','other') NOT NULL,
    `source_name` varchar(255) NOT NULL,
    `source_hash` char(64) NOT NULL,
    `status` enum('pending','validated','importing','completed','failed') NOT NULL DEFAULT 'pending',
    `validation_summary` text DEFAULT NULL,
    `started_at` datetime DEFAULT NULL,
    `completed_at` datetime DEFAULT NULL,
    `created_by` int(11) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_import_batches_source_hash` (`source_hash`),
    KEY `idx_import_batches_status_created` (`status`, `created_at`),
    KEY `idx_import_batches_created_by` (`created_by`),
    CONSTRAINT `fk_import_batches_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ip_affiliations` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(50) NOT NULL,
    `name` varchar(100) NOT NULL,
    `status` enum('active','inactive') NOT NULL DEFAULT 'active',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_ip_affiliations_code` (`code`),
    UNIQUE KEY `uq_ip_affiliations_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `ip_affiliations` (`code`, `name`) VALUES
    ('isnag', 'Isnag'),
    ('isneg', 'Isneg'),
    ('itneg', 'Itneg'),
    ('kankanaey', 'Kankanaey'),
    ('tinguian', 'Tinguian'),
    ('yapayao', 'Yapayao');

CREATE TABLE `case_types` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `code` varchar(80) NOT NULL,
    `name` varchar(150) NOT NULL,
    `status` enum('active','inactive') NOT NULL DEFAULT 'active',
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_case_types_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `case_types` (`code`, `name`) VALUES
    ('land_dispute', 'Land Dispute'),
    ('ancestral_domain_conflict', 'Ancestral Domain Conflict'),
    ('cultural_rights_violation', 'Cultural Rights Violation'),
    ('discrimination', 'Discrimination'),
    ('environmental_issue', 'Environmental Issue'),
    ('other', 'Other');

CREATE TABLE `ip_families` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `family_reference` varchar(50) DEFAULT NULL,
    `affiliation_id` int unsigned DEFAULT NULL,
    `owning_tribe` varchar(150) DEFAULT NULL COMMENT 'Operational authorization scope; distinct from ethnic affiliation',
    `region` varchar(100) DEFAULT NULL,
    `province` varchar(150) DEFAULT NULL,
    `municipality_city` varchar(150) DEFAULT NULL,
    `barangay` varchar(150) DEFAULT NULL,
    `house_number` varchar(100) DEFAULT NULL,
    `sitio_street` varchar(200) DEFAULT NULL,
    `contact_number` varchar(30) DEFAULT NULL,
    `id_type` varchar(100) DEFAULT NULL,
    `id_number` varchar(150) DEFAULT NULL,
    `remarks` text DEFAULT NULL,
    `import_batch_id` bigint unsigned DEFAULT NULL,
    `source_reference` varchar(100) DEFAULT NULL,
    `imported_at` datetime DEFAULT NULL,
    `created_by` int(11) DEFAULT NULL,
    `updated_by` int(11) DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_ip_families_family_reference` (`family_reference`),
    UNIQUE KEY `uq_ip_families_batch_source` (`import_batch_id`, `source_reference`),
    KEY `idx_ip_families_affiliation` (`affiliation_id`),
    KEY `idx_ip_families_owning_tribe` (`owning_tribe`),
    KEY `idx_ip_families_location` (`municipality_city`, `barangay`),
    KEY `idx_ip_families_created_by` (`created_by`),
    KEY `idx_ip_families_updated_by` (`updated_by`),
    CONSTRAINT `fk_ip_families_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_ip_families_import_batch` FOREIGN KEY (`import_batch_id`) REFERENCES `import_batches` (`id`) ON DELETE RESTRICT,
    CONSTRAINT `fk_ip_families_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
    CONSTRAINT `fk_ip_families_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `ip_family_members` (
    `id` bigint unsigned NOT NULL AUTO_INCREMENT,
    `family_id` bigint unsigned NOT NULL,
    `member_role` enum('head','spouse') NOT NULL,
    `last_name` varchar(100) DEFAULT NULL,
    `first_name` varchar(100) DEFAULT NULL,
    `middle_name` varchar(100) DEFAULT NULL,
    `suffix` varchar(30) DEFAULT NULL,
    `sex` enum('Male','Female','Other') DEFAULT NULL,
    `birthdate` date DEFAULT NULL,
    `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
    `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
    PRIMARY KEY (`id`),
    UNIQUE KEY `uq_ip_family_members_family_role` (`family_id`, `member_role`),
    KEY `idx_ip_family_members_name` (`last_name`, `first_name`),
    CONSTRAINT `fk_ip_family_members_family` FOREIGN KEY (`family_id`) REFERENCES `ip_families` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `ip_records`
    ADD COLUMN `affiliation_id` int unsigned DEFAULT NULL AFTER `tribe`,
    ADD COLUMN `family_member_id` bigint unsigned DEFAULT NULL AFTER `affiliation_id`,
    ADD UNIQUE KEY `uq_ip_records_family_member` (`family_member_id`),
    ADD KEY `idx_ip_records_affiliation` (`affiliation_id`),
    ADD CONSTRAINT `fk_ip_records_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
    ADD CONSTRAINT `fk_ip_records_family_member` FOREIGN KEY (`family_member_id`) REFERENCES `ip_family_members` (`id`) ON DELETE SET NULL;

ALTER TABLE `case_applications`
    ADD COLUMN `applicant_affiliation_id` int unsigned DEFAULT NULL AFTER `applicant_ip_group`,
    ADD COLUMN `case_type_id` int unsigned DEFAULT NULL AFTER `case_type_other`,
    ADD KEY `idx_cases_applicant_affiliation` (`applicant_affiliation_id`),
    ADD KEY `idx_cases_case_type_id` (`case_type_id`),
    ADD CONSTRAINT `fk_cases_applicant_affiliation` FOREIGN KEY (`applicant_affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
    ADD CONSTRAINT `fk_cases_case_type` FOREIGN KEY (`case_type_id`) REFERENCES `case_types` (`id`) ON DELETE SET NULL;

ALTER TABLE `case_persons_involved`
    ADD COLUMN `family_member_id` bigint unsigned DEFAULT NULL AFTER `contact`,
    ADD COLUMN `affiliation_id` int unsigned DEFAULT NULL AFTER `family_member_id`,
    ADD KEY `idx_case_persons_family_member` (`family_member_id`),
    ADD KEY `idx_case_persons_affiliation` (`affiliation_id`),
    ADD CONSTRAINT `fk_case_persons_family_member` FOREIGN KEY (`family_member_id`) REFERENCES `ip_family_members` (`id`) ON DELETE SET NULL,
    ADD CONSTRAINT `fk_case_persons_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL;
