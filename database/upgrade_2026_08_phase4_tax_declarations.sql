-- Phase 4 additive Tax Declaration/property relationships. No source records or geometry.
CREATE TABLE `property_types` (`id` int unsigned NOT NULL AUTO_INCREMENT,`code` varchar(50) NOT NULL,`name` varchar(100) NOT NULL,`status` enum('active','inactive') NOT NULL DEFAULT 'active',PRIMARY KEY(`id`),UNIQUE KEY `uq_property_types_code`(`code`)) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
INSERT INTO `property_types`(`code`,`name`) VALUES ('land','Land'),('building','Building'),('machinery','Machinery'),('other','Others');

CREATE TABLE `tax_declarations` (
 `id` bigint unsigned NOT NULL AUTO_INCREMENT,`td_number` varchar(100) NOT NULL,`pin` varchar(100) DEFAULT NULL,
 `owning_tribe` varchar(150) NOT NULL COMMENT 'Operational authorization scope; not owner identity',
 `owner_name` varchar(255) NOT NULL,`owner_tin` varchar(50) DEFAULT NULL,`owner_address` text DEFAULT NULL,`owner_phone` varchar(30) DEFAULT NULL,
 `administrator_name` varchar(255) DEFAULT NULL,`administrator_tin` varchar(50) DEFAULT NULL,`administrator_address` text DEFAULT NULL,`administrator_phone` varchar(30) DEFAULT NULL,
 `location_street` varchar(200) DEFAULT NULL,`location_barangay` varchar(150) DEFAULT NULL,`location_municipality_province_city` varchar(255) DEFAULT NULL,
 `title_number` varchar(150) DEFAULT NULL,`cct` varchar(100) DEFAULT NULL,`title_date` date DEFAULT NULL,`survey_number` varchar(100) DEFAULT NULL,`lot_number` varchar(100) DEFAULT NULL,`block_number` varchar(100) DEFAULT NULL,
 `boundary_north` text DEFAULT NULL,`boundary_south` text DEFAULT NULL,`boundary_east` text DEFAULT NULL,`boundary_west` text DEFAULT NULL,
 `property_type_id` int unsigned DEFAULT NULL,`number_of_storeys` smallint unsigned DEFAULT NULL,`brief_description` text DEFAULT NULL,`other_property_specify` varchar(255) DEFAULT NULL,
 `total_area_sqm` decimal(18,4) DEFAULT NULL,`total_market_value` decimal(18,2) DEFAULT NULL,`total_assessed_value` decimal(18,2) DEFAULT NULL,`total_assessed_value_words` text DEFAULT NULL,
 `tax_status` enum('taxable','exempt') DEFAULT NULL,`effectivity_quarter` tinyint unsigned DEFAULT NULL,`effectivity_year` smallint unsigned DEFAULT NULL,
 `approved_by` varchar(255) DEFAULT NULL,`approver_position` varchar(150) DEFAULT NULL,`approval_date` date DEFAULT NULL,
 `previous_td_arp_number` varchar(100) DEFAULT NULL,`previous_owner` varchar(255) DEFAULT NULL,`previous_assessed_value` decimal(18,2) DEFAULT NULL,`previous_tax_declaration_id` bigint unsigned DEFAULT NULL,
 `memoranda` text DEFAULT NULL,`parcel_id` int(11) DEFAULT NULL,`owner_ip_record_id` int(11) DEFAULT NULL,`owner_family_member_id` bigint unsigned DEFAULT NULL,`owner_family_id` bigint unsigned DEFAULT NULL,
 `declaration_status` enum('current','historical','cancelled') NOT NULL DEFAULT 'current',`created_by` int(11) DEFAULT NULL,`updated_by` int(11) DEFAULT NULL,`created_at` timestamp NOT NULL DEFAULT current_timestamp(),`updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
 PRIMARY KEY(`id`),UNIQUE KEY `uq_tax_declarations_td_number`(`td_number`),KEY `idx_tax_owner`(`owner_name`),KEY `idx_tax_location`(`location_barangay`),KEY `idx_tax_scope`(`owning_tribe`),KEY `idx_tax_parcel`(`parcel_id`),
 CONSTRAINT `fk_tax_property_type` FOREIGN KEY(`property_type_id`) REFERENCES `property_types`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_previous` FOREIGN KEY(`previous_tax_declaration_id`) REFERENCES `tax_declarations`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_parcel` FOREIGN KEY(`parcel_id`) REFERENCES `ip_land_parcels`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_owner_ip` FOREIGN KEY(`owner_ip_record_id`) REFERENCES `ip_records`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_owner_member` FOREIGN KEY(`owner_family_member_id`) REFERENCES `ip_family_members`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_owner_family` FOREIGN KEY(`owner_family_id`) REFERENCES `ip_families`(`id`) ON DELETE SET NULL,
 CONSTRAINT `fk_tax_created_by` FOREIGN KEY(`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,CONSTRAINT `fk_tax_updated_by` FOREIGN KEY(`updated_by`) REFERENCES `users`(`id`) ON DELETE SET NULL,
 CONSTRAINT `chk_tax_quarter` CHECK (`effectivity_quarter` IS NULL OR `effectivity_quarter` BETWEEN 1 AND 4)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `tax_declaration_assessments` (`id` bigint unsigned NOT NULL AUTO_INCREMENT,`tax_declaration_id` bigint unsigned NOT NULL,`classification` varchar(150) DEFAULT NULL,`area_sqm` decimal(18,4) DEFAULT NULL,`market_value` decimal(18,2) DEFAULT NULL,`actual_use` varchar(150) DEFAULT NULL,`assessment_level_percent` decimal(5,2) DEFAULT NULL,`assessed_value` decimal(18,2) DEFAULT NULL,`created_at` timestamp NOT NULL DEFAULT current_timestamp(),`updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),PRIMARY KEY(`id`),KEY `idx_tax_assessment_parent`(`tax_declaration_id`),CONSTRAINT `fk_tax_assessment_parent` FOREIGN KEY(`tax_declaration_id`) REFERENCES `tax_declarations`(`id`) ON DELETE CASCADE,CONSTRAINT `chk_assessment_level` CHECK (`assessment_level_percent` IS NULL OR (`assessment_level_percent` BETWEEN 0 AND 100))) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `case_tax_declarations` (`case_id` int(11) NOT NULL,`tax_declaration_id` bigint unsigned NOT NULL,`created_by` int(11) DEFAULT NULL,`created_at` timestamp NOT NULL DEFAULT current_timestamp(),PRIMARY KEY(`case_id`,`tax_declaration_id`),CONSTRAINT `fk_case_tax_case` FOREIGN KEY(`case_id`) REFERENCES `case_applications`(`id`) ON DELETE CASCADE,CONSTRAINT `fk_case_tax_td` FOREIGN KEY(`tax_declaration_id`) REFERENCES `tax_declarations`(`id`) ON DELETE CASCADE,CONSTRAINT `fk_case_tax_creator` FOREIGN KEY(`created_by`) REFERENCES `users`(`id`) ON DELETE SET NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE `tax_declaration_attachments` (`id` bigint unsigned NOT NULL AUTO_INCREMENT,`tax_declaration_id` bigint unsigned NOT NULL,`file_name` varchar(255) NOT NULL,`file_path` varchar(255) NOT NULL,`file_type` varchar(100) DEFAULT NULL,`uploaded_by` int(11) DEFAULT NULL,`created_at` timestamp NOT NULL DEFAULT current_timestamp(),PRIMARY KEY(`id`),KEY `idx_tax_attachment_parent`(`tax_declaration_id`),CONSTRAINT `fk_tax_attachment_parent` FOREIGN KEY(`tax_declaration_id`) REFERENCES `tax_declarations`(`id`) ON DELETE CASCADE,CONSTRAINT `fk_tax_attachment_user` FOREIGN KEY(`uploaded_by`) REFERENCES `users`(`id`) ON DELETE SET NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
