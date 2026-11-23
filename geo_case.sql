-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2026 at 06:50 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `geo_case`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `module` varchar(100) DEFAULT NULL,
  `record_id` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `username`, `role`, `action`, `module`, `record_id`, `description`, `ip_address`, `created_at`) VALUES
(1, 1, 'harvzrpv', 'admin', 'LOGIN', 'users', 1, 'Admin \'harvzrpv\' logged in successfully at 2026-08-22 14:32:21', '::1', '2026-08-22 12:32:21'),
(2, 1, 'harvzrpv', 'admin', 'ADD USER', 'users', 9, 'New user \'juan.dc\' created with role \'tribe_leader\'', '::1', '2026-08-22 12:34:40'),
(3, 1, 'harvzrpv', 'admin', 'ADD USER', 'users', 10, 'New user \'gabriel.inayat\' created with role \'tribe_rep\'', '::1', '2026-08-22 12:36:01'),
(4, 1, 'harvzrpv', 'admin', 'ADD USER', 'users', 11, 'New user \'hero.mapispisi\' created with role \'assessor\'', '::1', '2026-08-22 12:37:58'),
(5, 1, 'harvzrpv', 'admin', 'IMPORT_FAMILIES', 'import_batches', 1, 'Completed family import batch; imported=424; skipped=0', '::1', '2026-08-22 12:38:48'),
(6, 1, 'harvzrpv', 'admin', 'IMPORT_CASES', 'import_batches', 2, 'Completed case import batch; imported=6; skipped=0', '::1', '2026-08-22 12:39:36'),
(7, 1, 'harvzrpv', 'admin', 'LOGIN', 'users', 1, 'Admin \'harvzrpv\' logged in successfully at 2026-08-22 14:40:55', '::1', '2026-08-22 12:40:55'),
(8, 1, 'harvzrpv', 'admin', 'LOGIN', 'users', 1, 'Admin \'harvzrpv\' logged in successfully at 2026-08-22 14:51:26', '::1', '2026-08-22 12:51:26'),
(9, 1, 'harvzrpv', 'admin', 'LOGIN', 'users', 1, 'Admin \'harvzrpv\' logged in successfully at 2026-08-27 14:27:38', '::1', '2026-08-27 12:27:38'),
(10, 1, 'harvzrpv', 'admin', 'LOGIN', 'users', 1, 'Admin \'harvzrpv\' logged in successfully at 2026-08-27 14:50:43', '::1', '2026-08-27 12:50:43'),
(11, 1, 'harvzrpv', 'admin', 'UPDATE_CASE_STATUS', 'case_applications', 6, 'Status changed from pending to under_review by User ID: 1 (admin)', '::1', '2026-08-27 13:08:53'),
(12, 1, 'harvzrpv', 'admin', 'UPDATE_CASE', 'case_applications', 6, 'Updated case fields: case type changed; participants synchronized from 3 to 1', '::1', '2026-08-27 13:11:09'),
(13, 1, 'harvzrpv', 'admin', 'UPDATE_CASE', 'case_applications', 6, 'Updated case fields: case type retained; participants synchronized from 1 to 2', '::1', '2026-08-27 13:12:05'),
(14, 1, 'harvzrpv', 'admin', 'RESET PASSWORD', 'users', 11, 'Password reset for user \'hero.mapispisi\' to a generated temporary password', '::1', '2026-08-27 13:20:13'),
(15, 1, 'harvzrpv', 'admin', 'DEACTIVATE USER', 'users', 9, 'User \'juan.dc\' status changed from \'active\' to \'inactive\'', '::1', '2026-08-27 13:20:50'),
(16, 1, 'harvzrpv', 'admin', 'REACTIVATE USER', 'users', 9, 'User \'juan.dc\' status changed from \'inactive\' to \'active\'', '::1', '2026-08-27 13:20:58'),
(17, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:22:59'),
(18, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:05'),
(19, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:08'),
(20, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:12'),
(21, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:17'),
(22, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:21'),
(23, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:24'),
(24, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:23:37'),
(25, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:24:15'),
(26, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:24:23'),
(27, 1, 'harvzrpv', 'admin', 'UPDATE_SETTINGS', 'system_settings', NULL, 'Updated system logo/theme settings', '::1', '2026-08-27 13:24:41'),
(28, 1, 'harvzrpv', 'admin', 'UPDATE_PROFILE', 'users', 1, 'Updated own profile information', '::1', '2026-08-27 13:28:09'),
(29, 1, 'harvzrpv', 'admin', 'CHANGE_PASSWORD', 'users', 1, 'Changed own account password', '::1', '2026-08-27 13:28:37'),
(30, 1, 'harvzrpv', 'admin', 'UPDATE USER', 'users', 1, 'Updated user account | Changes: Username: harvzrpv → admin', '::1', '2026-08-27 13:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `case_applications`
--

CREATE TABLE `case_applications` (
  `id` int(11) NOT NULL,
  `applicant_fullname` varchar(150) NOT NULL,
  `applicant_gender` enum('Male','Female','Other') DEFAULT NULL,
  `applicant_dob` date DEFAULT NULL,
  `applicant_contact` varchar(20) DEFAULT NULL,
  `applicant_email` varchar(150) DEFAULT NULL,
  `applicant_address` text DEFAULT NULL,
  `applicant_ip_group` varchar(100) DEFAULT NULL,
  `applicant_affiliation_id` int(10) UNSIGNED DEFAULT NULL,
  `rep_name` varchar(150) DEFAULT NULL,
  `rep_relationship` varchar(100) DEFAULT NULL,
  `rep_contact` varchar(20) DEFAULT NULL,
  `case_title` varchar(255) DEFAULT NULL,
  `case_type` enum('land_dispute','ancestral_domain_conflict','cultural_rights_violation','discrimination','environmental_issue','other') DEFAULT 'other',
  `case_type_other` varchar(255) DEFAULT NULL,
  `case_type_id` int(10) UNSIGNED DEFAULT NULL,
  `incident_date` date DEFAULT NULL,
  `incident_barangay` varchar(150) DEFAULT NULL,
  `incident_municipality` varchar(150) DEFAULT NULL,
  `incident_province` varchar(150) DEFAULT NULL,
  `incident_location_text` varchar(255) DEFAULT NULL,
  `case_description` text DEFAULT NULL,
  `status` enum('pending','ongoing','under_review','resolved','closed') DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `assigned_to` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_applications`
--

INSERT INTO `case_applications` (`id`, `applicant_fullname`, `applicant_gender`, `applicant_dob`, `applicant_contact`, `applicant_email`, `applicant_address`, `applicant_ip_group`, `applicant_affiliation_id`, `rep_name`, `rep_relationship`, `rep_contact`, `case_title`, `case_type`, `case_type_other`, `case_type_id`, `incident_date`, `incident_barangay`, `incident_municipality`, `incident_province`, `incident_location_text`, `case_description`, `status`, `created_by`, `assigned_to`, `created_at`, `updated_at`) VALUES
(1, 'Rose Marie S. Aman', 'Female', '1979-01-04', NULL, NULL, 'Poblacion 1, Adams, Ilocos Norte', 'Yapayao', 6, 'Juan P. Yadan', 'Brother', NULL, 'Dispute Over Traditional Agricultural Land', '', NULL, 1, '2025-07-10', NULL, NULL, NULL, 'Brgy. Adams, Adams, Ilocos Norte', 'The applicant claims that another individual has been using and cultivating a portion of land traditionally used by her family for farming. The applicant states that the land has been passed down through generations and that the family has continuously used the area for agricultural purposes.', 'pending', 1, 'assessor', '2026-08-22 12:39:36', '2026-08-22 12:39:36'),
(2, 'Rodolfo Purdos', 'Male', '1958-01-05', NULL, NULL, 'Brgy. Bucarot, Adams, Ilocos Norte', 'Yapayao', 6, 'Editha Purdos', 'Wife', NULL, 'Alleged Unauthorized Use of Ancestral Domain', '', NULL, 2, '2024-06-22', NULL, NULL, NULL, 'Brgy. Bucarot, Adams, Ilocos Norte', 'The applicant reports that an outside party allegedly entered and conducted activities within an area traditionally used and claimed by the Indigenous community without prior consultation with the affected community. The applicant requests assistance in documenting the incident and determining the appropriate process for resolving the concern.', 'pending', 1, 'tribe_leader', '2026-08-22 12:39:36', '2026-08-22 12:39:36'),
(3, 'Editha M. Tubay', 'Female', '1970-12-06', NULL, NULL, 'Poblacion 1, Adams, Ilocos Norte', 'Yapayao', 6, NULL, NULL, NULL, 'Unauthorized Use of Indigenous Cultural Practice', '', NULL, 3, '2025-08-02', NULL, NULL, NULL, 'Poblacion 2, Adams, Ilocos Norte', 'The applicant reports that an individual allegedly used an Indigenous cultural practice and related traditional designs for a public activity without proper consultation or acknowledgment of the community. The applicant requests documentation and appropriate action to protect the community\'s cultural rights and traditions.', 'pending', 1, 'tribe_leader', '2026-08-22 12:39:36', '2026-08-22 12:39:36'),
(4, 'Virgie S. Walleng', 'Female', '1969-04-01', NULL, NULL, 'Brgy. Maligligay, Adams, Ilocos Norte', 'Yapayao', 4, NULL, NULL, NULL, 'Alleged Discrimination Based on Indigenous Identity', '', NULL, 4, '2026-07-28', NULL, NULL, NULL, 'Laoag City, Ilocos Norte', 'The applicant alleges that he experienced discriminatory treatment because of his Indigenous identity and cultural background while accessing a service. The applicant states that he was treated differently from other individuals and seeks assistance in documenting and addressing the incident.', 'pending', 1, 'tribe_leader', '2026-08-22 12:39:36', '2026-08-22 12:39:36'),
(5, 'Oron Tumbed', 'Male', '1980-07-25', NULL, NULL, 'Sinidangan, Adams, Ilocos Norte', 'Yapayao', 6, NULL, NULL, NULL, 'Reported Removal of Vegetation in a Community Resource Area', '', NULL, 5, '2024-08-01', NULL, NULL, NULL, 'Brgy. Adams, Adams, Ilocos Norte', 'The applicant reports that vegetation was allegedly removed from an area traditionally accessed by members of the Indigenous community. According to the applicant, the activity may affect the availability of plants and other natural resources commonly gathered and used by community members.', 'pending', 1, 'tribe_leader', '2026-08-22 12:39:36', '2026-08-22 12:39:36'),
(6, 'Annie Budao', 'Female', '1969-10-09', '', '', 'Poblacion 2, Adams, Ilocos Norte', 'Yapayao', 6, '', '', '', 'Misrepresentation of an Indigenous Traditional Practice', 'cultural_rights_violation', '', 3, '2026-05-27', 'Adams', 'Adams', 'Ilocos Norte', 'Adams, Ilocos Norte', 'The applicant reports that an Indigenous traditional practice was presented during a public activity without proper consultation with knowledgeable members of the community. The applicant claims that some of the information presented did not accurately represent their traditional practice and requests that the concern be documented.', 'under_review', 1, 'tribe_leader', '2026-08-22 12:39:36', '2026-08-27 13:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `case_attachments`
--

CREATE TABLE `case_attachments` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(50) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_attachments`
--

INSERT INTO `case_attachments` (`id`, `case_id`, `file_name`, `file_path`, `file_type`, `uploaded_by`, `created_at`) VALUES
(1, 6, 'Repellent Capability of Neem (Azadirachta Indica) Leaf and Bay Leaf (Laurus nobilis) Extract as a Natural Cockroach Repellent.pdf', '../uploads/case_attachments/ffd854b3b424f84ef3eeb9a2b76f1672.pdf', 'application/pdf', 1, '2026-08-27 13:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `case_persons_involved`
--

CREATE TABLE `case_persons_involved` (
  `id` int(11) NOT NULL,
  `case_id` int(11) NOT NULL,
  `person_name` varchar(150) NOT NULL,
  `role` enum('complainant','respondent','witness','representative') NOT NULL,
  `relationship_to_applicant` varchar(100) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `family_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_record_id` int(11) DEFAULT NULL,
  `affiliation_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_persons_involved`
--

INSERT INTO `case_persons_involved` (`id`, `case_id`, `person_name`, `role`, `relationship_to_applicant`, `contact`, `family_member_id`, `ip_record_id`, `affiliation_id`, `created_at`) VALUES
(1, 1, 'Rose Marie S. Aman', 'complainant', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(2, 1, 'Tyrone Dupagen', 'respondent', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(3, 1, 'James Aman', 'witness', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(4, 1, 'Juan P. Yadan', 'representative', 'Brother', NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(5, 2, 'Rodolfo Purdos', 'complainant', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(6, 2, 'Daniel R. Cruz', 'respondent', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(7, 2, 'Jamae Bassingan', 'witness', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(8, 2, 'Editha Purdos', 'representative', 'Wife', NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(9, 3, 'Editha M. Tubay', 'complainant', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(10, 3, 'Arjay Abian', 'respondent', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(11, 3, 'Rosa S. Aglipay', 'witness', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(12, 4, 'Virgie S. Walleng', 'complainant', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(13, 4, 'Alex P. Aguda', 'respondent', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(14, 4, 'Banjo Aguinaldo', 'witness', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(15, 5, 'Oron Tumbed', 'complainant', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(16, 5, 'Ricardo P. Alicay', 'respondent', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(17, 5, 'Gabby Purdos', 'witness', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:39:36'),
(22, 6, 'Annie Budao', 'respondent', '', '', NULL, NULL, NULL, '2026-08-27 13:12:05'),
(23, 6, 'Harvy Raphael Pascua Virocel', 'witness', '', '', 613, NULL, 1, '2026-08-27 13:12:05');

-- --------------------------------------------------------

--
-- Table structure for table `case_tax_declarations`
--

CREATE TABLE `case_tax_declarations` (
  `case_id` int(11) NOT NULL,
  `tax_declaration_id` bigint(20) UNSIGNED NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `case_types`
--

CREATE TABLE `case_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(80) NOT NULL,
  `name` varchar(150) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_types`
--

INSERT INTO `case_types` (`id`, `code`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'land_dispute', 'Land Dispute', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15'),
(2, 'ancestral_domain_conflict', 'Ancestral Domain Conflict', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15'),
(3, 'cultural_rights_violation', 'Cultural Rights Violation', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15'),
(4, 'discrimination', 'Discrimination', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15'),
(5, 'environmental_issue', 'Environmental Issue', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15'),
(6, 'other', 'Other', 'active', '2026-08-20 18:53:15', '2026-08-20 18:53:15');

-- --------------------------------------------------------

--
-- Table structure for table `import_batches`
--

CREATE TABLE `import_batches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `source_type` enum('ip_family_workbook','case_document','other') NOT NULL,
  `source_name` varchar(255) NOT NULL,
  `source_hash` char(64) NOT NULL,
  `status` enum('pending','validated','importing','completed','failed') NOT NULL DEFAULT 'pending',
  `validation_summary` text DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `import_batches`
--

INSERT INTO `import_batches` (`id`, `source_type`, `source_name`, `source_hash`, `status`, `validation_summary`, `started_at`, `completed_at`, `created_by`, `created_at`) VALUES
(1, 'ip_family_workbook', 'ADAMS IP\'S.xlsx', '8a130610870d021cbfabd2e44fbcc35c52051807b9b2f82388b4ac724d05defb', 'completed', '{\"imported\":424,\"skipped\":0,\"total\":424}', '2026-08-22 20:38:45', '2026-08-22 20:38:48', 1, '2026-08-22 12:38:45'),
(2, 'case_document', 'BRGY ADAMS CASES.docx', 'a1e1f76615f8765ba9e4c6b6c01b7d8b45de96c1fa65da24803ebc68c274cebe', 'completed', '{\"imported\":6,\"skipped\":0}', '2026-08-22 20:39:36', '2026-08-22 20:39:36', 1, '2026-08-22 12:39:36');

-- --------------------------------------------------------

--
-- Table structure for table `ip_affiliations`
--

CREATE TABLE `ip_affiliations` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ip_affiliations`
--

INSERT INTO `ip_affiliations` (`id`, `code`, `name`, `status`, `created_at`, `updated_at`) VALUES
(1, 'isnag', 'Isnag', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14'),
(2, 'isneg', 'Isneg', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14'),
(3, 'itneg', 'Itneg', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14'),
(4, 'kankanaey', 'Kankanaey', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14'),
(5, 'tinguian', 'Tinguian', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14'),
(6, 'yapayao', 'Yapayao', 'active', '2026-08-20 18:53:14', '2026-08-20 18:53:14');

-- --------------------------------------------------------

--
-- Table structure for table `ip_families`
--

CREATE TABLE `ip_families` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `family_reference` varchar(50) DEFAULT NULL,
  `affiliation_id` int(10) UNSIGNED DEFAULT NULL,
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
  `import_batch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `source_reference` varchar(100) DEFAULT NULL,
  `imported_at` datetime DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ip_families`
--

INSERT INTO `ip_families` (`id`, `family_reference`, `affiliation_id`, `owning_tribe`, `region`, `province`, `municipality_city`, `barangay`, `house_number`, `sitio_street`, `contact_number`, `id_type`, `id_number`, `remarks`, `import_batch_id`, `source_reference`, `imported_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'FAM-2026-43BCF087', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-3', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(2, 'FAM-2026-8C7DECBA', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-4', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(3, 'FAM-2026-43114193', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-5', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(4, 'FAM-2026-568AEBA6', 2, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-6', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(5, 'FAM-2026-F920AE37', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-7', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(6, 'FAM-2026-DA3A2850', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-8', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(7, 'FAM-2026-EA9EAC6C', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-9', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(8, 'FAM-2026-9F69BE86', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-10', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(9, 'FAM-2026-29577DCB', 5, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-11', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(10, 'FAM-2026-62BE0F0F', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-12', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(11, 'FAM-2026-8F3DCFDD', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-13', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(12, 'FAM-2026-1A5220D6', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-14', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(13, 'FAM-2026-85F200C2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-15', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(14, 'FAM-2026-5C179509', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-16', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(15, 'FAM-2026-0693F746', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-17', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(16, 'FAM-2026-E51FC0E8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-18', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(17, 'FAM-2026-11ECDB87', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-19', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(18, 'FAM-2026-22515D75', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-20', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(19, 'FAM-2026-0AC7DD11', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-21', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(20, 'FAM-2026-C287C377', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-22', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(21, 'FAM-2026-78EF07B6', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-23', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(22, 'FAM-2026-54AF0719', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-24', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(23, 'FAM-2026-06DD0635', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-25', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(24, 'FAM-2026-4AC20713', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-26', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(25, 'FAM-2026-642B81E3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-27', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(26, 'FAM-2026-EC5496CA', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-28', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(27, 'FAM-2026-77A78A23', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-29', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(28, 'FAM-2026-3120D8A9', 5, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-30', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(29, 'FAM-2026-1C0E3382', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-31', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(30, 'FAM-2026-001A218C', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-32', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(31, 'FAM-2026-877013F4', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-33', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(32, 'FAM-2026-FB5109FF', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-34', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(33, 'FAM-2026-7EB03301', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-35', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(34, 'FAM-2026-A51B923B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-36', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(35, 'FAM-2026-4D22F9F0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-37', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(36, 'FAM-2026-6CAE9AAB', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-38', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(37, 'FAM-2026-A2CA5B05', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-39', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(38, 'FAM-2026-03D93AAC', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-40', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(39, 'FAM-2026-60F1ED1B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-41', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(40, 'FAM-2026-7C32C0A0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-42', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(41, 'FAM-2026-798F5B55', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-43', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(42, 'FAM-2026-D2D6E8D8', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-44', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(43, 'FAM-2026-156F5EFD', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-45', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(44, 'FAM-2026-26C44B4C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-46', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(45, 'FAM-2026-FA298B16', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-47', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(46, 'FAM-2026-ADE71B24', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-48', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(47, 'FAM-2026-A711BDD5', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-49', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(48, 'FAM-2026-C56A6602', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-50', '2026-08-22 20:38:45', 1, 1, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(49, 'FAM-2026-E22364C8', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-51', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(50, 'FAM-2026-FDD2C97A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-52', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(51, 'FAM-2026-3B743FCC', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-53', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(52, 'FAM-2026-46B56059', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-54', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(53, 'FAM-2026-1A9DF94D', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-55', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(54, 'FAM-2026-BC1780CE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-56', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(55, 'FAM-2026-C8FA59A0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-57', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(56, 'FAM-2026-2F7D9F84', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-58', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(57, 'FAM-2026-E6B74C15', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-59', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(58, 'FAM-2026-5F1CCEAD', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-60', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(59, 'FAM-2026-F55CAE50', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-61', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(60, 'FAM-2026-5D982AA4', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-62', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(61, 'FAM-2026-F219D122', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-63', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(62, 'FAM-2026-64670645', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower Uno', NULL, NULL, NULL, NULL, 1, 'ROW-64', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(63, 'FAM-2026-61952E24', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-65', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(64, 'FAM-2026-60352D33', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-66', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(65, 'FAM-2026-9F63F072', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-67', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(66, 'FAM-2026-78BD1330', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-68', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(67, 'FAM-2026-A1EAEA4A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-69', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(68, 'FAM-2026-F0073454', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-70', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(69, 'FAM-2026-9F1DA4DA', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-71', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(70, 'FAM-2026-8686D487', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-72', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(71, 'FAM-2026-EFC16C33', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-73', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(72, 'FAM-2026-39323C7B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-74', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(73, 'FAM-2026-A9186C27', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-75', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(74, 'FAM-2026-9D625D79', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-76', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(75, 'FAM-2026-BA77B3D5', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-77', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(76, 'FAM-2026-576401A6', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-78', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(77, 'FAM-2026-4BB0DBE5', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-79', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(78, 'FAM-2026-D938F5FC', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-80', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(79, 'FAM-2026-54781515', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-81', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(80, 'FAM-2026-C3390696', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-82', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(81, 'FAM-2026-E16A42B3', 4, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-83', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(82, 'FAM-2026-D5B4119F', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-84', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(83, 'FAM-2026-346DB628', 1, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-85', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(84, 'FAM-2026-AF51F1C1', 6, 'Yapayao', NULL, 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-86', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(85, 'FAM-2026-5884F270', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-87', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(86, 'FAM-2026-007B65EA', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-88', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(87, 'FAM-2026-EDB683FE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-89', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(88, 'FAM-2026-559BCD83', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-90', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(89, 'FAM-2026-3FF0738F', 3, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-91', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(90, 'FAM-2026-12E6EC83', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-92', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(91, 'FAM-2026-F80D36B2', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-93', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(92, 'FAM-2026-F8A28ACE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-94', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(93, 'FAM-2026-A6CC0D9F', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-95', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(94, 'FAM-2026-2186F8EC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-96', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(95, 'FAM-2026-373A05E6', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-97', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(96, 'FAM-2026-A19DBA43', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-98', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(97, 'FAM-2026-3C2F9A70', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-99', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(98, 'FAM-2026-36ED458E', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-100', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(99, 'FAM-2026-FBD6F112', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-101', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(100, 'FAM-2026-6EA03242', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-102', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(101, 'FAM-2026-1B7CD774', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-103', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(102, 'FAM-2026-2C4B413C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-104', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(103, 'FAM-2026-4AA1F4F9', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-105', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(104, 'FAM-2026-5C9D1BDA', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-106', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(105, 'FAM-2026-DD12CB2A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-107', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(106, 'FAM-2026-431CAD2A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-108', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(107, 'FAM-2026-72E39304', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-109', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(108, 'FAM-2026-1589DE39', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-110', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(109, 'FAM-2026-B7997237', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-111', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(110, 'FAM-2026-FEB277EE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-112', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(111, 'FAM-2026-62DD0049', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-113', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(112, 'FAM-2026-2E9BE6A2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-114', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(113, 'FAM-2026-6BE7B424', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-115', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(114, 'FAM-2026-8FFFD40B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-116', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(115, 'FAM-2026-023B145B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-117', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(116, 'FAM-2026-07A9AE28', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-118', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(117, 'FAM-2026-21FE6211', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-119', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(118, 'FAM-2026-9EEA9A20', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-120', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(119, 'FAM-2026-4E85CF23', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-121', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(120, 'FAM-2026-86AB10B7', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-122', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(121, 'FAM-2026-42E78E77', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-123', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(122, 'FAM-2026-279F8FC7', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-124', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(123, 'FAM-2026-CBEBE0DF', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-125', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(124, 'FAM-2026-4122E1E8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-126', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(125, 'FAM-2026-5860B3CE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-127', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(126, 'FAM-2026-864B62B2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-128', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(127, 'FAM-2026-5F9D65C7', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-129', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(128, 'FAM-2026-A4EC2481', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-130', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(129, 'FAM-2026-EF89E05F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-131', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(130, 'FAM-2026-06BFD7A6', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-132', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(131, 'FAM-2026-EBF6A273', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-133', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(132, 'FAM-2026-38736C3C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-134', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(133, 'FAM-2026-C93B25A2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-135', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(134, 'FAM-2026-8825577A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-136', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(135, 'FAM-2026-B30C23B6', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-137', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(136, 'FAM-2026-0D2D87EA', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-138', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(137, 'FAM-2026-9E44DCFE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-139', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(138, 'FAM-2026-19E91187', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-140', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(139, 'FAM-2026-D69BE899', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-141', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(140, 'FAM-2026-9600E8C3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-142', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(141, 'FAM-2026-C94FA8B6', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-143', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(142, 'FAM-2026-1EB56C15', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-144', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(143, 'FAM-2026-28C2A1F1', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-145', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(144, 'FAM-2026-132D7AB7', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-146', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(145, 'FAM-2026-464EA0C3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-147', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(146, 'FAM-2026-7EEE3311', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-148', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(147, 'FAM-2026-26962601', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-149', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(148, 'FAM-2026-81C57477', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-150', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(149, 'FAM-2026-20DC8E36', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-151', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(150, 'FAM-2026-23A03C24', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-152', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(151, 'FAM-2026-0D9C6839', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-153', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(152, 'FAM-2026-647E8CE2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-154', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(153, 'FAM-2026-D1F77CDD', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-155', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(154, 'FAM-2026-6C474BD0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-156', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(155, 'FAM-2026-F20EACFB', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-157', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(156, 'FAM-2026-374B9FD9', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-158', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(157, 'FAM-2026-D483ED1F', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-159', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(158, 'FAM-2026-3B7F52C0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-160', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(159, 'FAM-2026-6AC89072', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-161', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(160, 'FAM-2026-6CDB1B15', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-162', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(161, 'FAM-2026-F5AF9DFC', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-163', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(162, 'FAM-2026-F8405AF8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-164', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(163, 'FAM-2026-D506E911', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-165', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(164, 'FAM-2026-72BEA136', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-166', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(165, 'FAM-2026-9A090563', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-167', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(166, 'FAM-2026-A91D3E5F', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-168', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(167, 'FAM-2026-7A3A94E3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-169', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(168, 'FAM-2026-74141FCB', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-170', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(169, 'FAM-2026-BF749C6C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-171', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(170, 'FAM-2026-F4513980', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-172', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(171, 'FAM-2026-0CAB1A8F', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-173', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(172, 'FAM-2026-3BBB45D0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-174', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(173, 'FAM-2026-D21DB814', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-175', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(174, 'FAM-2026-4CAE5D77', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-176', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(175, 'FAM-2026-40A27DF5', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-177', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(176, 'FAM-2026-96C9093A', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-178', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(177, 'FAM-2026-2AA4A861', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-179', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(178, 'FAM-2026-CD393C36', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-180', '2026-08-22 20:38:46', 1, 1, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(179, 'FAM-2026-59051BD1', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-181', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(180, 'FAM-2026-8B84D67F', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-182', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(181, 'FAM-2026-4BE9E983', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-183', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(182, 'FAM-2026-E67E8462', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-184', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(183, 'FAM-2026-8A2439E2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-185', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(184, 'FAM-2026-17BD4732', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-186', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(185, 'FAM-2026-9C270ED0', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-187', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(186, 'FAM-2026-A6F21774', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-188', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(187, 'FAM-2026-1FB1C7F3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-189', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(188, 'FAM-2026-EB0E073E', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-190', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(189, 'FAM-2026-63F025B8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-191', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(190, 'FAM-2026-93DFAE36', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-192', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(191, 'FAM-2026-D4DA3198', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-193', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(192, 'FAM-2026-19804807', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-194', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(193, 'FAM-2026-2A5E7691', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-195', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(194, 'FAM-2026-491A525C', 6, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-196', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(195, 'FAM-2026-2DC327F9', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-197', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(196, 'FAM-2026-51222BA1', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-198', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(197, 'FAM-2026-9C7ADA18', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-199', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(198, 'FAM-2026-5003D688', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-200', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(199, 'FAM-2026-21093AA3', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-201', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(200, 'FAM-2026-AF35D8BD', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-202', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(201, 'FAM-2026-B46CEB1D', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-203', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(202, 'FAM-2026-363FAEA8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-204', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(203, 'FAM-2026-D6A3CE7D', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-205', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(204, 'FAM-2026-8F761717', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-206', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(205, 'FAM-2026-86C4C085', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-207', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(206, 'FAM-2026-8725CB0E', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-208', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(207, 'FAM-2026-C1C7AD5F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-209', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(208, 'FAM-2026-E1BF2679', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-210', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(209, 'FAM-2026-2BE3A197', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-211', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(210, 'FAM-2026-CA6EF85F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-212', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(211, 'FAM-2026-89FC2BD8', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-213', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(212, 'FAM-2026-59EFAE92', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-214', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(213, 'FAM-2026-5350BE51', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-215', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(214, 'FAM-2026-735EAC5B', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-216', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(215, 'FAM-2026-C8504E36', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-217', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(216, 'FAM-2026-1D89A9B9', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-218', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(217, 'FAM-2026-BA58079F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-219', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(218, 'FAM-2026-0638B2A8', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-220', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(219, 'FAM-2026-A8BB1551', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-221', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(220, 'FAM-2026-506C5722', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-222', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(221, 'FAM-2026-A9955E0F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-223', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(222, 'FAM-2026-BB9C0420', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-224', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(223, 'FAM-2026-89C91915', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-225', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(224, 'FAM-2026-785FCA78', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-226', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(225, 'FAM-2026-9D067993', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-227', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(226, 'FAM-2026-F61C2F22', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-228', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(227, 'FAM-2026-A47C3485', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-229', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(228, 'FAM-2026-E7941FEB', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-230', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(229, 'FAM-2026-3BB1FC32', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-231', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(230, 'FAM-2026-02AC337C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-232', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(231, 'FAM-2026-826A91B9', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-233', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(232, 'FAM-2026-0BBD9A39', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-234', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(233, 'FAM-2026-34F3DAC0', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-235', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(234, 'FAM-2026-28218284', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-236', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(235, 'FAM-2026-7B81C0FC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-237', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(236, 'FAM-2026-4297A7EC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-238', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(237, 'FAM-2026-AA81B314', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-239', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47');
INSERT INTO `ip_families` (`id`, `family_reference`, `affiliation_id`, `owning_tribe`, `region`, `province`, `municipality_city`, `barangay`, `house_number`, `sitio_street`, `contact_number`, `id_type`, `id_number`, `remarks`, `import_batch_id`, `source_reference`, `imported_at`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(238, 'FAM-2026-23C76189', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-240', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(239, 'FAM-2026-0129A908', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-241', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(240, 'FAM-2026-E08D841A', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-242', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(241, 'FAM-2026-21CF55EC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-243', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(242, 'FAM-2026-536C9AEC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-244', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(243, 'FAM-2026-8305504F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-245', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(244, 'FAM-2026-F0BE8DB7', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-246', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(245, 'FAM-2026-E1A41C6C', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-247', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(246, 'FAM-2026-EE9C963E', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-248', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(247, 'FAM-2026-9CEA6EA9', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-249', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(248, 'FAM-2026-F9CFAB53', 1, 'Yapayao', NULL, NULL, 'Adams', NULL, NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-250', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(249, 'FAM-2026-A3C1B44F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-251', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(250, 'FAM-2026-D5BB29DC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-252', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(251, 'FAM-2026-B72B3A54', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-253', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(252, 'FAM-2026-5CE92B81', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-254', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(253, 'FAM-2026-3F58F3BF', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-255', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(254, 'FAM-2026-BB53A894', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-256', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(255, 'FAM-2026-46CFA2FE', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-257', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(256, 'FAM-2026-AECE0DE5', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-258', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(257, 'FAM-2026-330CABD7', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-259', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(258, 'FAM-2026-0DD15A77', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-260', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(259, 'FAM-2026-67892C8F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-261', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(260, 'FAM-2026-16A33FE5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-262', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(261, 'FAM-2026-B35564F8', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-263', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(262, 'FAM-2026-5A48F381', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-264', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(263, 'FAM-2026-8C2B2E59', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-265', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(264, 'FAM-2026-EBDF8114', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-266', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(265, 'FAM-2026-EFFAAEBA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-267', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(266, 'FAM-2026-D2E3F884', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-268', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(267, 'FAM-2026-728B5E1E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-269', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(268, 'FAM-2026-5B808566', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-270', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(269, 'FAM-2026-E32604FC', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, 'PHIC', '052000160873', NULL, 1, 'ROW-271', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(270, 'FAM-2026-B75347D8', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-272', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(271, 'FAM-2026-DE13EE25', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-273', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(272, 'FAM-2026-18919641', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-274', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(273, 'FAM-2026-C0AFD49C', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-275', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(274, 'FAM-2026-88F9B2ED', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-276', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(275, 'FAM-2026-1A5F9451', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-277', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(276, 'FAM-2026-5B0150F8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-278', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(277, 'FAM-2026-5F002AED', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-279', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(278, 'FAM-2026-C63078EB', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-280', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(279, 'FAM-2026-1F3D1FEF', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-281', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(280, 'FAM-2026-91384682', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-282', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(281, 'FAM-2026-EF0B083A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-283', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(282, 'FAM-2026-664453C0', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-284', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(283, 'FAM-2026-6670C97A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-285', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(284, 'FAM-2026-A851C891', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-286', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(285, 'FAM-2026-EF3ED1AD', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-287', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(286, 'FAM-2026-134A4A01', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-288', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(287, 'FAM-2026-C32F51D5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-289', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(288, 'FAM-2026-82ECDB42', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-290', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(289, 'FAM-2026-34D55DCF', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-291', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(290, 'FAM-2026-D6026D7D', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Upper Uno', NULL, NULL, NULL, NULL, 1, 'ROW-292', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(291, 'FAM-2026-318926C8', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-293', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(292, 'FAM-2026-5075D4BB', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-294', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(293, 'FAM-2026-D9B3F4C2', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-295', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(294, 'FAM-2026-FBCA52D2', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-296', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(295, 'FAM-2026-6CF3DABA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-297', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(296, 'FAM-2026-068F95B2', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-298', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(297, 'FAM-2026-B0429698', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-299', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(298, 'FAM-2026-8D7F17B5', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-300', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(299, 'FAM-2026-EE4DA4A1', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-301', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(300, 'FAM-2026-C892A1FE', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-302', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(301, 'FAM-2026-4234ED6E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-303', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(302, 'FAM-2026-A4F43BA5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-304', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(303, 'FAM-2026-D421830A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-305', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(304, 'FAM-2026-1D44B80F', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Lower uno', NULL, NULL, NULL, NULL, 1, 'ROW-306', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(305, 'FAM-2026-DBF93784', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-307', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(306, 'FAM-2026-C813DEE9', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-308', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(307, 'FAM-2026-45C4AFA1', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-309', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(308, 'FAM-2026-CDEBC6E3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-310', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(309, 'FAM-2026-60EB5CFB', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-311', '2026-08-22 20:38:47', 1, 1, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(310, 'FAM-2026-A8BCDA63', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-312', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(311, 'FAM-2026-3492DD22', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-313', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(312, 'FAM-2026-D922FF5C', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-314', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(313, 'FAM-2026-27180BEA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-315', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(314, 'FAM-2026-86950B18', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-316', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(315, 'FAM-2026-9F75CEA7', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-317', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(316, 'FAM-2026-EDB5FCBA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-318', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(317, 'FAM-2026-D3E4C863', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-319', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(318, 'FAM-2026-93204D3B', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-320', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(319, 'FAM-2026-33D25208', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-321', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(320, 'FAM-2026-2C0C812E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Maligligay', NULL, NULL, NULL, NULL, 1, 'ROW-322', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(321, 'FAM-2026-7D84BE95', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-323', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(322, 'FAM-2026-3187372B', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-324', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(323, 'FAM-2026-24D45916', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-325', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(324, 'FAM-2026-D9942DE6', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-326', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(325, 'FAM-2026-08EAC038', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-327', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(326, 'FAM-2026-106EEBD3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-328', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(327, 'FAM-2026-DCD90118', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-329', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(328, 'FAM-2026-A4DC2090', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-330', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(329, 'FAM-2026-894CBFDE', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-331', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(330, 'FAM-2026-794F508D', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-332', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(331, 'FAM-2026-FD227762', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-333', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(332, 'FAM-2026-15DA16A6', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-334', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(333, 'FAM-2026-87036AB8', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-335', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(334, 'FAM-2026-A070E89E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-336', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(335, 'FAM-2026-468A1A65', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-337', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(336, 'FAM-2026-1B0D54E3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-338', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(337, 'FAM-2026-E79C65CA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-339', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(338, 'FAM-2026-2084B258', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-340', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(339, 'FAM-2026-225ECE45', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-341', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(340, 'FAM-2026-9939E343', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-342', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(341, 'FAM-2026-53FB9BAF', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-343', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(342, 'FAM-2026-F75B26BD', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-344', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(343, 'FAM-2026-010AB096', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-345', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(344, 'FAM-2026-FB8B84CD', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-346', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(345, 'FAM-2026-DD96D762', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-347', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(346, 'FAM-2026-CC92CE50', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-348', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(347, 'FAM-2026-31750A79', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-349', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(348, 'FAM-2026-40D57F03', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok II', NULL, NULL, NULL, NULL, 1, 'ROW-350', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(349, 'FAM-2026-6E2B6E76', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-351', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(350, 'FAM-2026-817E3940', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-352', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(351, 'FAM-2026-E4600BEE', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-353', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(352, 'FAM-2026-B7DA730C', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-354', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(353, 'FAM-2026-EE6C3085', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-355', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(354, 'FAM-2026-A2B7170B', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-356', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(355, 'FAM-2026-A0C4B0F2', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-357', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(356, 'FAM-2026-9D6FC688', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-358', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(357, 'FAM-2026-EF25619B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-359', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(358, 'FAM-2026-BE8B19D3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-360', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(359, 'FAM-2026-0337486A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-361', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(360, 'FAM-2026-AC710E62', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-362', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(361, 'FAM-2026-CC6CC0B3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-363', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(362, 'FAM-2026-CE8B04AE', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-364', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(363, 'FAM-2026-9AA5F78A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-365', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(364, 'FAM-2026-09809DCA', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-366', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(365, 'FAM-2026-DEA3C78F', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-367', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(366, 'FAM-2026-703DE321', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-368', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(367, 'FAM-2026-EB5B786A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-369', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(368, 'FAM-2026-6C1047ED', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-370', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(369, 'FAM-2026-4713A04A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-371', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(370, 'FAM-2026-D14DBF52', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-372', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(371, 'FAM-2026-1E55EC8E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-373', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(372, 'FAM-2026-FDCCBE35', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-374', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(373, 'FAM-2026-52422316', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-375', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(374, 'FAM-2026-FF09A69C', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-376', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(375, 'FAM-2026-1CC99442', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-377', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(376, 'FAM-2026-DF0DA2C8', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-378', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(377, 'FAM-2026-7F73D7EA', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-379', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(378, 'FAM-2026-3772A3D2', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-380', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(379, 'FAM-2026-98F88041', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-381', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(380, 'FAM-2026-4F75FB97', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-382', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(381, 'FAM-2026-60D18446', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-383', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(382, 'FAM-2026-671B7B3E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-384', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(383, 'FAM-2026-95B58845', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-385', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(384, 'FAM-2026-F649E26B', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-386', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(385, 'FAM-2026-D8E678C5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-387', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(386, 'FAM-2026-C4ACA676', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-388', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(387, 'FAM-2026-77FB09BD', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-389', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(388, 'FAM-2026-36575544', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-390', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(389, 'FAM-2026-619CE7D5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-391', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(390, 'FAM-2026-F977311F', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-392', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(391, 'FAM-2026-3EE4517B', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-393', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(392, 'FAM-2026-10CF1CD4', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-394', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(393, 'FAM-2026-6B6B6254', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-395', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(394, 'FAM-2026-55F3E383', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-396', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(395, 'FAM-2026-5B685A87', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-397', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(396, 'FAM-2026-0F146DF1', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-398', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(397, 'FAM-2026-7D410FA3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Purok III', NULL, NULL, NULL, NULL, 1, 'ROW-399', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(398, 'FAM-2026-327E2B26', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-400', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(399, 'FAM-2026-6110D637', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-401', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(400, 'FAM-2026-177CA32A', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-402', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(401, 'FAM-2026-D02E6AF5', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-403', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(402, 'FAM-2026-E1028603', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-404', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(403, 'FAM-2026-2B3A63DC', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-405', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(404, 'FAM-2026-C6951C12', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-406', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(405, 'FAM-2026-5FBA53E3', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-407', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(406, 'FAM-2026-A454AA1E', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-408', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(407, 'FAM-2026-A55F30C9', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-409', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(408, 'FAM-2026-F591ABB9', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-410', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(409, 'FAM-2026-D3649AA2', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Malagao', NULL, NULL, NULL, NULL, 1, 'ROW-411', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(410, 'FAM-2026-973F7CE4', 6, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-412', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(411, 'FAM-2026-AB99D930', 4, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-413', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(412, 'FAM-2026-999C71DC', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Sinidangan', NULL, NULL, NULL, NULL, 1, 'ROW-414', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(413, 'FAM-2026-0F262965', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-415', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(414, 'FAM-2026-13BFFD1F', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-416', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(415, 'FAM-2026-D3ECC203', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-417', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(416, 'FAM-2026-E4CED4A8', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-418', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(417, 'FAM-2026-F5680777', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-419', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(418, 'FAM-2026-272E3D16', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-420', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(419, 'FAM-2026-4057F764', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-421', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(420, 'FAM-2026-C7B1DA52', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Cadisan', NULL, NULL, NULL, NULL, 1, 'ROW-422', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(421, 'FAM-2026-95ABA017', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-423', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(422, 'FAM-2026-FF06C868', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-424', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(423, 'FAM-2026-45AA9CA0', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-425', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(424, 'FAM-2026-04408213', 1, 'Yapayao', '1', 'Ilocos Norte', 'Adams', 'Adams', NULL, 'Bucarot', NULL, NULL, NULL, NULL, 1, 'ROW-426', '2026-08-22 20:38:48', 1, 1, '2026-08-22 12:38:48', '2026-08-22 12:38:48');

-- --------------------------------------------------------

--
-- Table structure for table `ip_family_members`
--

CREATE TABLE `ip_family_members` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `family_id` bigint(20) UNSIGNED NOT NULL,
  `member_role` enum('head','spouse') NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `middle_name` varchar(100) DEFAULT NULL,
  `suffix` varchar(30) DEFAULT NULL,
  `sex` enum('Male','Female','Other') DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ip_family_members`
--

INSERT INTO `ip_family_members` (`id`, `family_id`, `member_role`, `last_name`, `first_name`, `middle_name`, `suffix`, `sex`, `birthdate`, `created_at`, `updated_at`) VALUES
(1, 1, 'head', 'Vidad', 'Mylene', 'Butac', NULL, 'Female', '1977-03-21', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(2, 1, 'spouse', 'Deodores', 'Dennis', NULL, NULL, 'Male', NULL, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(3, 2, 'head', 'Aguda', 'Lilia', 'Calingay', NULL, 'Female', '1973-09-28', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(4, 3, 'head', 'Alicay', 'Gloria', 'Bassingan', NULL, 'Female', '1960-08-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(5, 3, 'spouse', 'Alicay', 'Andres', 'Calugan', NULL, 'Male', '1959-09-08', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(6, 4, 'head', 'Alicay', 'Marilyn', 'Banglas', NULL, 'Female', '1984-01-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(7, 4, 'spouse', 'Alicay', 'Adrian', 'Bassingan', NULL, 'Male', NULL, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(8, 5, 'head', 'Alicay', 'Alex', 'Bassingan', NULL, 'Male', '1988-11-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(9, 5, 'spouse', 'Agron', 'Diana', 'Tomas', NULL, 'Female', '1990-03-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(10, 6, 'head', 'Aman', 'Rosemarie', 'Sugayen', NULL, 'Female', '1979-04-01', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(11, 6, 'spouse', 'Aman', 'Jay', 'Blanco', NULL, 'Male', '1977-09-23', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(12, 7, 'head', 'Angayen', 'Priscilla', 'Paredes', NULL, 'Female', '1948-05-15', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(13, 8, 'head', 'Angayen', 'Sheryll Princess', 'Paredes', NULL, 'Female', '1987-12-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(14, 8, 'spouse', 'Belisario', 'Abraham', NULL, NULL, 'Male', NULL, '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(15, 9, 'head', 'Ando', 'Richelle', 'Panabang', NULL, 'Female', '1988-03-27', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(16, 9, 'spouse', 'Ando', 'Richard', 'Rivera', 'Sr.', 'Male', '1978-11-07', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(17, 10, 'head', 'Baging', 'Jerry', 'Bassingan', NULL, 'Male', '1980-12-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(18, 10, 'spouse', 'Baging', 'Liberty', 'Ducala', NULL, 'Female', '1984-07-07', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(19, 11, 'head', 'Barriga', 'Wilberg Isiah', 'Tarnate', NULL, 'Male', '1993-10-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(20, 12, 'head', 'Barriga', 'Junio', 'Magdab', NULL, 'Male', '1925-01-01', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(21, 12, 'spouse', 'Barriga', 'Rufina', 'Manuel', NULL, 'Female', '1932-02-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(22, 13, 'head', 'Bayani', 'Marcos', NULL, NULL, 'Male', '1951-02-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(23, 14, 'head', 'Cabasoy', 'Matilde', 'Dupagen', NULL, 'Female', '1972-12-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(24, 14, 'spouse', 'Cabasoy', 'Mario', 'Dummao', NULL, 'Male', '1973-05-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(25, 15, 'head', 'Cabasoy', 'Marvin', 'Alicay', NULL, 'Male', '1979-11-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(26, 15, 'spouse', 'Cabasoy', 'Janice', 'Timpang', NULL, 'Female', '1984-07-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(27, 16, 'head', 'Caoile', 'Frecenta', 'Manuel', NULL, 'Female', '1966-12-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(28, 16, 'spouse', 'Caoile', 'Jose', 'Almonte', NULL, 'Male', '1958-11-18', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(29, 17, 'head', 'Acosta', 'Jocelyn', 'Caoile', NULL, 'Female', '1989-01-29', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(30, 17, 'spouse', 'Acosta', 'Rammy Emmanuel', 'Sayno', NULL, 'Male', '1988-12-28', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(31, 18, 'head', 'Domingo', 'Sanny Boy', 'Sappat', NULL, 'Male', '1981-12-08', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(32, 18, 'spouse', 'Domingo', 'Ligaya', 'Villanueva', NULL, 'Female', '1982-01-10', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(33, 19, 'head', 'Dupagen', 'Cadao', 'Burawi', NULL, 'Male', '1959-03-15', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(34, 19, 'spouse', 'Dupagen', 'Lydia', 'Bassingan', NULL, 'Female', '1964-10-09', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(35, 20, 'head', 'Dupagen', 'Armando', 'Belo', NULL, 'Male', '1973-02-18', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(36, 20, 'spouse', 'Dupagen', 'Analyn', 'Atabay', NULL, 'Female', '1975-12-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(37, 21, 'head', 'Dupagen', 'Eugenio', 'serred', NULL, 'Male', '1932-12-01', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(38, 21, 'spouse', 'Dupagen', 'Emilia', 'Burawi', NULL, 'Female', '1946-01-15', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(39, 22, 'head', 'Llama', 'Rodrigo', 'Uyaan', 'Jr.', 'Male', '1987-05-18', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(40, 22, 'spouse', 'Llama', 'Wilfremy', 'Barriga', NULL, 'Female', '1987-04-18', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(41, 23, 'head', 'Manuel', 'Alberto', 'Serred', NULL, 'Male', '1940-02-01', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(42, 24, 'head', 'Manuel', 'Joel', 'Patong', NULL, 'Male', '1975-07-12', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(43, 25, 'head', 'Manuel', 'Jeromin', 'Cabicungan', NULL, 'Male', '1995-05-19', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(44, 25, 'spouse', 'Dalog', 'Karen', 'Sabado', NULL, 'Female', '1995-08-02', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(45, 26, 'head', 'Meniano', 'Fernando', 'Tabugno', NULL, 'Male', '1969-02-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(46, 26, 'spouse', 'Meniano', 'Rosa', 'Tukiad', NULL, 'Female', '1980-01-27', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(47, 27, 'head', 'Naghab', 'Shandy', 'Napadawan', 'Sr.', 'Male', '1988-09-21', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(48, 27, 'spouse', 'Naghab', 'Ligaya', 'Sayya', NULL, 'Female', '1986-01-11', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(49, 28, 'head', 'Panabang', 'Armando', 'Dacuyan', 'Sr.', 'Male', '1965-09-10', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(50, 28, 'spouse', 'Panabang', 'Marites', 'Dummao', NULL, 'Female', '1972-12-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(51, 29, 'head', 'Ravelo', 'Eugene', 'Tubay', NULL, 'Male', '1977-06-19', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(52, 29, 'spouse', 'Ravelo', 'Cristina', 'Dummao', NULL, 'Female', '1979-12-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(53, 30, 'head', 'Tresreyes', 'Alna Danica Jane', 'Tubay', NULL, 'Female', '1992-10-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(54, 30, 'spouse', 'Tresreyes', 'Keith', 'Miguel', NULL, 'Male', '1993-02-18', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(55, 31, 'head', 'Sugayen', 'Rolly', 'Magdab', NULL, 'Male', '1976-10-16', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(56, 31, 'spouse', 'Sugayen', 'Marilou', 'Madriaga', NULL, 'Female', '1984-01-28', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(57, 32, 'head', 'Tangilen', 'Matda', 'Bassingan', NULL, 'Female', '1987-04-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(58, 33, 'head', 'Tangilen', 'Arnedo Sr.', 'Bassingan', NULL, 'Male', '1963-12-03', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(59, 33, 'spouse', 'Tangilen', 'Marivic', 'Dongaso', NULL, 'Female', '1964-07-04', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(60, 34, 'head', 'Tarnate', 'Caesar', 'Digaya', NULL, 'Male', '1982-03-31', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(61, 34, 'spouse', 'Tarnate', 'Edelyne', 'Purdos', NULL, 'Female', '1982-05-09', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(62, 35, 'head', 'Tarnate', 'Erwin', 'Digaya', NULL, 'Male', '1988-06-13', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(63, 35, 'spouse', 'Tarnate', 'Jovy', 'Ducala', NULL, 'Female', '1992-06-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(64, 36, 'head', 'Tarnate', 'Tenecia', 'Tobias', NULL, 'Female', '1958-11-07', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(65, 37, 'head', 'Tubay', 'Alberto 1', 'Manuel', NULL, 'Male', '1958-04-26', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(66, 37, 'spouse', 'Tubay', 'Annie', 'Vidad', NULL, 'Female', '1967-05-30', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(67, 38, 'head', 'Tubay', 'Imelda', 'Manuel', NULL, 'Female', '1967-02-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(68, 39, 'head', 'Vidad', 'Linda', 'Butac', NULL, 'Female', '1955-10-15', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(69, 40, 'head', 'Llanes', 'Silverio', 'Suniga', NULL, 'Male', '1978-04-02', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(70, 40, 'spouse', 'Llanes', 'Anita', 'Tukiad', NULL, 'Female', '1985-04-25', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(71, 41, 'head', 'Anibag', 'Rudy', 'Manuel', NULL, 'Male', '1962-02-19', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(72, 42, 'head', 'Espiritu', 'Coraning', 'Baging', NULL, 'Female', '1986-10-30', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(73, 42, 'spouse', 'Espiritu', 'Cristopher', 'Pascua', NULL, 'Male', '1988-12-24', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(74, 43, 'head', 'Bassingan', 'Reynante', 'Purdos', NULL, 'Male', '1975-12-09', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(75, 43, 'spouse', 'Bassingan', 'Geralyn', 'Casibang', NULL, 'Female', '1986-01-19', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(76, 44, 'head', 'Bassingan', 'Rowel', 'Tubay', NULL, 'Male', '1984-06-02', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(77, 44, 'spouse', 'Bassingan', 'Evangeline', 'Valdez', NULL, 'Female', '1995-03-28', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(78, 45, 'head', 'Dalluyon', 'Alexander', 'Bunay', NULL, 'Male', '1974-03-27', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(79, 46, 'head', 'Dongaso', 'Virginia', 'Tubay', NULL, 'Female', '1960-08-08', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(80, 46, 'spouse', 'Dongaso', 'Arsenio', 'Cutit', 'Jr.', 'Male', '1956-06-04', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(81, 47, 'head', 'Dongaso', 'Bryan', 'Tubay', NULL, 'Male', '1982-05-16', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(82, 47, 'spouse', 'Dongaso', 'Gladys', 'Camacam', NULL, 'Female', '1983-04-10', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(83, 48, 'head', 'Dongaso', 'Claver', 'Tubay', NULL, 'Male', '1984-12-22', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(84, 48, 'spouse', 'Dongaso', 'Elaine Joy', 'Ganitano', NULL, 'Female', '1990-02-14', '2026-08-22 12:38:45', '2026-08-22 12:38:45'),
(85, 49, 'head', 'Dongaso', 'Dexter', 'Tubay', NULL, 'Male', '1989-12-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(86, 49, 'spouse', 'Dancel', 'Jessica', NULL, NULL, 'Female', '1999-06-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(87, 50, 'head', 'Vinoya', 'Fevie Melody', 'Dupagen', NULL, 'Female', '1991-02-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(88, 50, 'spouse', 'Vinoya', 'John', 'Agbayani', NULL, 'Male', '1992-11-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(89, 51, 'head', 'Reyes', 'Leticia', 'Anibag', NULL, 'Female', '1964-10-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(90, 51, 'spouse', 'Reyes', 'Remigio', 'Tayag', NULL, 'Male', '1964-05-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(91, 52, 'head', 'Tawali', 'Fe', 'Catcatan', NULL, 'Female', '1964-11-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(92, 53, 'head', 'Tawali', 'Hermogenes', 'Pulit', 'Jr.', 'Male', '1982-04-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(93, 53, 'spouse', 'Aguinaldo', 'Vivian Fe', 'Manantan', NULL, 'Female', '1985-02-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(94, 54, 'head', 'Tawali', 'Cipriano', 'Pulit', NULL, 'Male', '1964-03-31', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(95, 55, 'head', 'Tawali', 'Reynaldo', 'Pulit', 'Sr.', 'Male', '1963-08-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(96, 55, 'spouse', 'Tawali', 'Imelda', 'Miniano', NULL, 'Female', '1966-07-26', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(97, 56, 'head', 'Tawali', 'Alberto', 'Pulit', NULL, 'Male', '1962-07-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(98, 56, 'spouse', 'Tawali', 'Gertrudis', 'Lazo', NULL, 'Female', '1969-09-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(99, 57, 'head', 'Tawali', 'Geraldine', 'Lazo', NULL, 'Female', '1995-08-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(100, 58, 'head', 'Tawali', 'Daniel', 'Paulino', NULL, 'Male', '1967-06-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(101, 58, 'spouse', 'Tawali', 'Leinnie', 'Agustin', NULL, 'Female', '1976-03-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(102, 59, 'head', 'Bassingan', 'Momoy', 'Paganao', NULL, 'Male', '1951-03-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(103, 59, 'spouse', 'Bassingan', 'Bella', 'Tubay', NULL, 'Female', '1953-08-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(104, 60, 'head', 'Baging', 'Nardy', 'coman', NULL, 'Male', '1964-06-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(105, 60, 'spouse', 'Baging', 'Felicidad', 'Aguda', NULL, 'Female', '1968-11-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(106, 61, 'head', 'Baging', 'Fernan', 'Aguda', NULL, 'Male', '1991-11-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(107, 61, 'spouse', 'Baging', 'Daisy', 'Mangoba', NULL, 'Female', '1994-12-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(108, 62, 'head', 'Baging', 'Elena', 'Coman', NULL, 'Female', '1942-08-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(109, 63, 'head', 'Bassingan', 'Rommel', 'Tubay', NULL, 'Male', '1978-09-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(110, 63, 'spouse', 'Bassingan', 'Ruth', 'Tugade', NULL, 'Female', '1986-06-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(111, 64, 'head', 'Budao', 'Annie', 'Bassingan', NULL, 'Female', '1969-09-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(112, 64, 'spouse', 'Budao', 'Nolly', 'Baltazar', NULL, 'Male', '1968-03-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(113, 65, 'head', 'Burawi', 'Loreto', 'Casacayan', NULL, 'Male', '1989-01-24', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(114, 65, 'spouse', 'De Guzman', 'Berbadette', NULL, NULL, 'Female', '1990-01-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(115, 66, 'head', 'Calventas', 'Julian', 'Galleng', 'Jr.', 'Male', '1974-04-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(116, 66, 'spouse', 'Calventas', 'Elma', 'Autriz', NULL, 'Female', '1979-11-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(117, 67, 'head', 'Cascayan', 'Margie', 'Macario', NULL, 'Female', '1985-01-31', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(118, 67, 'spouse', 'Cascayan', 'Joel', 'Abadilla', NULL, 'Male', '1976-12-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(119, 68, 'head', 'Cascayan', 'Wilmer', 'Bassingan', NULL, 'Male', '1972-05-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(120, 68, 'spouse', 'Cascayan', 'Reynalyn', 'Baguinat', NULL, 'Female', '1975-07-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(121, 69, 'head', 'Cascayan', 'Tecla', 'Bassingan', NULL, 'Female', '1953-03-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(122, 70, 'head', 'Cascayan', 'Crisanto', 'Bassingan', NULL, 'Male', '1983-02-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(123, 70, 'spouse', 'Cascayan', 'Claribel', 'Aguda', NULL, 'Female', '1993-10-30', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(124, 71, 'head', 'Casicdao', 'Shayer', 'Purdos', NULL, 'Male', '1964-09-09', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(125, 71, 'spouse', 'Casicdao', 'Catherine', 'Calventas', NULL, 'Female', '1978-04-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(126, 72, 'head', 'Dalluyon', 'Castor', 'Bunay', NULL, 'Male', '1983-07-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(127, 72, 'spouse', 'Dalluyon', 'Analyn', 'Natividad', NULL, 'Female', '1981-04-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(128, 73, 'head', 'Dalluyon', 'Jessie', 'Bunay', NULL, 'Male', '1972-12-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(129, 73, 'spouse', 'Dalluyon', 'Madelyn', 'Aguda', NULL, 'Female', '1972-12-26', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(130, 74, 'head', 'Dato', 'Michael', 'Tawali', NULL, 'Male', '1999-11-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(131, 74, 'spouse', 'Tawali', 'Mitchell', 'Poking', NULL, 'Female', '1991-11-17', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(132, 75, 'head', 'Digaya', 'Maria', 'Lorenzo', NULL, 'Female', '1942-05-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(133, 76, 'head', 'Rapanot', 'Mae', 'Domingo', NULL, 'Female', '1999-01-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(134, 77, 'head', 'Dupagen', 'Randy', 'Burawi', NULL, 'Male', '1978-05-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(135, 77, 'spouse', 'Dupagen', 'Miriam', 'Tugade', NULL, 'Female', '1981-08-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(136, 78, 'head', 'Dupagen', 'Rema Grace', 'Magdab', NULL, 'Female', '1963-03-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(137, 79, 'head', 'Labasan', 'Jenalyn', 'Manggay', NULL, 'Female', '1980-07-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(138, 79, 'spouse', 'Labasan', 'Marvin', 'Tukiad', NULL, 'Male', '1983-07-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(139, 80, 'head', 'Labasan', 'Edelyn', 'Abugan', NULL, 'Female', '1982-06-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(140, 80, 'spouse', 'Labasan', 'Rex', 'Tukiad', 'Sr.', 'Male', '1980-07-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(141, 81, 'head', 'Labasan', 'Raymund', 'Tukiad', NULL, 'Male', '1987-09-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(142, 81, 'spouse', 'Labasan', 'Jonalyn', 'Vicente', NULL, 'Female', '1994-07-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(143, 82, 'head', 'Magdab', 'Patro', 'Dalluyon', NULL, 'Male', '1959-03-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(144, 83, 'head', 'Nieto', 'Maribel', 'Pulsic', NULL, 'Female', '1990-02-11', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(145, 83, 'spouse', 'Nieto', 'Nemecio', 'Aguda', NULL, 'Male', '1989-12-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(146, 84, 'head', 'Abugan', 'Irene', 'Tapia', NULL, 'Female', '1999-05-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(147, 84, 'spouse', 'Nieto', 'Orlando', 'Aguda', NULL, 'Male', '1994-12-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(148, 85, 'head', 'Patong', 'Pascual', 'Dauran', NULL, 'Male', '1945-10-14', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(149, 86, 'head', 'Sapngad', 'Marissa', 'Dalluyon', NULL, 'Female', '1980-04-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(150, 86, 'spouse', 'Sangad', 'Johnny', 'Ibalio', NULL, 'Male', '1979-01-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(151, 87, 'head', 'Sugayen', 'Norma', 'Magdab', NULL, 'Female', '1955-12-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(152, 88, 'head', 'Sugayen', 'Zaldy', 'Magdab', NULL, 'Male', '1982-02-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(153, 88, 'spouse', 'Sugayen', 'Mylene', 'Racsa', NULL, 'Female', '1991-10-09', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(154, 89, 'head', 'Tukiad', 'Rosa', 'Iwagen', NULL, 'Female', '1969-01-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(155, 89, 'spouse', 'Tukiad', 'Ramon', 'Busagna', 'Sr.', 'Male', '1966-07-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(156, 90, 'head', 'Tukiad', 'Paulina', 'Patong', NULL, 'Female', '1982-11-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(157, 90, 'spouse', 'Tukiad', 'Leo', 'Busagna', NULL, 'Male', '1982-08-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(158, 91, 'head', 'Abian', 'Joel', 'Domingo', NULL, 'Male', '1975-05-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(159, 91, 'spouse', 'Abian', 'Leonida', 'Pedronan', NULL, 'Female', '1986-11-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(160, 92, 'head', 'Bautista', 'Jenevic', 'Abian', NULL, 'Female', '1991-12-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(161, 92, 'spouse', 'Bautista', 'Lordhund', 'Lacar', NULL, 'Male', '1987-09-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(162, 93, 'head', 'Aguda', 'Edwin', 'Espirutu', NULL, 'Male', '1974-08-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(163, 93, 'spouse', 'Aguda', 'Daisy', 'Cabasoy', NULL, 'Female', '1979-12-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(164, 94, 'head', 'Dalog', 'Romero', 'Alayao', NULL, 'Male', '1984-12-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(165, 94, 'spouse', 'Dalog', 'Maryjane', 'Cadang', NULL, 'Female', '1988-10-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(166, 95, 'head', 'Darisan', 'Manuel', 'Limbawan', 'Sr.', 'Male', '1965-06-06', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(167, 95, 'spouse', 'Darisan', 'Betty', 'Oron', NULL, 'Female', '1972-07-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(168, 96, 'head', 'Domingo', 'Mario', 'Sappat', NULL, 'Male', '1979-12-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(169, 96, 'spouse', 'Domingo', 'Lagrina', 'Aguda', NULL, 'Female', '1982-05-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(170, 97, 'head', 'Espiritu', 'Beatricia', 'Manuel', NULL, 'Female', '1956-08-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(171, 98, 'head', 'Lorenzo', 'Shirley', 'Aguda', NULL, 'Female', '1972-08-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(172, 98, 'spouse', 'Aguda', 'Noli', 'Tabbilas', 'Sr.', 'Male', '1963-04-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(173, 99, 'head', 'Luban', 'Paulito', 'Polinia', NULL, 'Male', '1955-09-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(174, 99, 'spouse', 'Luban', 'Zenaida', 'Suniga', NULL, 'Female', '1973-12-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(175, 100, 'head', 'Manggay', 'Claro', NULL, NULL, 'Male', '1925-07-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(176, 100, 'spouse', 'Manggay', 'Naty', 'Aguda', NULL, 'Female', '1942-03-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(177, 101, 'head', 'Maruquin', 'Gumelyn', 'Baging', NULL, 'Male', '1942-08-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(178, 102, 'head', 'Maruquin', 'Romnick', 'Alayao', NULL, 'Female', '1989-11-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(179, 102, 'spouse', 'Maruquin', 'Janice', 'Paytocan', NULL, 'Female', '1995-08-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(180, 103, 'head', 'Suniga', 'Melecia', 'Espiritu', NULL, 'Male', '1954-08-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(181, 103, 'spouse', 'Maruquin', NULL, NULL, NULL, NULL, NULL, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(182, 104, 'head', 'Suniga', 'Alfredo', 'Espiritu', NULL, 'Female', '1977-10-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(183, 104, 'spouse', 'Suniga', 'Lorna', 'Pascual', NULL, 'Female', '1980-06-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(184, 105, 'head', 'Tubay', 'Walter', 'Calventas', NULL, 'Male', '1977-05-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(185, 105, 'spouse', 'Tubay', 'Lorna', 'Paytocan', NULL, 'Female', '1986-11-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(186, 106, 'head', 'Tubay', 'Waya', 'Manuel', NULL, 'Male', '1956-07-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(187, 106, 'spouse', 'Tubay', 'Relinda', 'Calventas', NULL, 'Female', '1958-11-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(188, 107, 'head', 'Tubay', 'Wilmer', 'Calventas', NULL, 'Male', '1989-07-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(189, 107, 'spouse', 'Tubay', 'Jaycel', 'Aguda', NULL, 'Female', '1995-10-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(190, 108, 'head', 'Tubay', 'Johny', 'Calventas', NULL, 'Male', '1983-07-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(191, 108, 'spouse', 'Tubay', 'Nerisa', 'Salvador', NULL, 'Female', '1989-12-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(192, 109, 'head', 'Abugan', 'Betty', 'Tapia', NULL, 'Female', '1967-04-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(193, 110, 'head', 'Abugan', 'Jhone', 'Anggob', NULL, 'Male', '1984-10-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(194, 110, 'spouse', 'Abugan', 'Florida', 'Bahelo', NULL, 'Female', '1988-03-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(195, 111, 'head', 'Abugan', 'Myrna', 'Dumalan', NULL, 'Female', '1964-10-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(196, 112, 'head', 'Acebedo', 'Edward', 'Manuel', NULL, 'Male', '1983-07-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(197, 112, 'spouse', 'Acebedo', 'Janice', 'Abugan', NULL, 'Female', '1983-07-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(198, 113, 'head', 'Acebedo', 'Nora', 'Manuel', NULL, 'Female', '1957-05-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(199, 113, 'spouse', 'Acebedo', 'Franklin', NULL, NULL, 'Male', NULL, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(200, 114, 'head', 'Agandao', 'Efren', 'Andres', NULL, 'Male', '1973-03-14', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(201, 115, 'head', 'Agandao', 'Gina', 'Andres', NULL, 'Female', '1972-05-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(202, 116, 'head', 'Agoo', 'Alfredo', 'Batawag', NULL, 'Male', '1964-02-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(203, 117, 'head', 'Aguda', 'Sadiri', 'Espiritu', 'Sr.', 'Male', '1966-02-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(204, 117, 'spouse', 'Aguda', 'Hermilita', 'Vicente', NULL, 'Female', '1970-06-02', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(205, 118, 'head', 'Aguda', 'Shiela', 'Vicente', NULL, 'Female', '1987-04-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(206, 118, 'spouse', 'Aquino', 'Mery Mark', 'Balanay', NULL, 'Male', '1985-08-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(207, 119, 'head', 'Balbin', 'Shiela Mae', 'Aguda', NULL, 'Female', '1991-03-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(208, 119, 'spouse', 'Balbin', 'Reynante', 'Quintero', NULL, 'Male', '1989-05-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(209, 120, 'head', 'Bahelo', 'Pio', 'Domingo', NULL, 'Male', '1956-06-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(210, 120, 'spouse', 'Bahelo', 'Florentina', 'Tarnate', NULL, 'Female', '1956-04-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(211, 121, 'head', 'Barriga', 'Arnel', 'Banat', NULL, 'Male', '1967-01-06', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(212, 121, 'spouse', 'Barriga', 'Beatriz', 'Cadiogan', NULL, 'Female', '1972-10-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(213, 122, 'head', 'Barriga', 'Quirino', 'Tawali', 'Sr.', 'Male', '1952-11-23', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(214, 123, 'head', 'Barriga', 'Rodel', 'Banat', NULL, 'Male', '1967-04-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(215, 124, 'head', 'Barriga', 'Annie', 'Banat', NULL, 'Female', '1972-10-24', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(216, 125, 'head', 'Barriga', 'Jomar', 'Nardo', NULL, 'Male', '1981-08-11', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(217, 125, 'spouse', 'Barriga', 'Alda', 'Batoon', NULL, 'Female', '1992-11-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(218, 126, 'head', 'Butac', 'Tagnawa', 'Dumalan', NULL, 'Male', '1935-03-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(219, 127, 'head', 'Cabasoy', 'Editha', 'Domingo', NULL, 'Female', '1969-03-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(220, 127, 'spouse', 'Cabasoy', 'Orlando', 'Dummao', NULL, 'Male', '1967-09-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(221, 128, 'head', 'Calixto', 'Joey', 'Butac', NULL, 'Male', '1987-05-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(222, 128, 'spouse', 'Calixto', 'Laila', 'Bahelo', NULL, 'Female', '1986-04-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(223, 129, 'head', 'Calumpit', 'Jessie', 'Batra', NULL, 'Male', '1985-08-09', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(224, 129, 'spouse', 'Paytocan', 'Juvielyn', 'Cabasoy', NULL, 'Female', '1995-09-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(225, 130, 'head', 'Casicdao', 'Dolores', 'Tawali', NULL, 'Female', '1949-01-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(226, 131, 'head', 'Casicdao', 'Sherwin', 'Purdos', NULL, 'Male', '1975-04-06', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(227, 132, 'head', 'Dalluyon', 'Adriano', 'Bunay', NULL, 'Male', '1977-10-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(228, 132, 'spouse', 'Valencia', 'Norma', 'Barriga', NULL, 'Female', '1978-07-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(229, 133, 'head', 'De Jesus', 'Leona', 'Barriga', NULL, 'Female', '1976-01-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(230, 134, 'head', 'Domingo', 'Edmond', 'Ancheta', NULL, 'Male', '1981-12-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(231, 134, 'spouse', 'Batoon', 'Aiza', 'Domingo', NULL, 'Female', '1995-03-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(232, 135, 'head', 'Domingo', 'Jeffrey', 'Casicdao', NULL, 'Male', '1996-10-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(233, 135, 'spouse', 'Domingo', 'Jocielyn', 'Vidad', NULL, 'Female', '1998-04-19', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(234, 136, 'head', 'Domingo', 'Joseph', 'Suniga', NULL, 'Male', '1977-07-24', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(235, 136, 'spouse', 'Domingo', 'Bernisia', 'Casicdao', NULL, 'Female', '1978-05-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(236, 137, 'head', 'Domingo', 'Juanito', 'Pascua', NULL, 'Male', '1957-06-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(237, 137, 'spouse', 'Domingo', 'Vicky', 'Agandao', NULL, 'Female', '1960-10-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(238, 138, 'head', 'Domingo', 'Marites', 'Agandao', NULL, 'Female', '1984-12-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(239, 138, 'spouse', 'Esteban', 'Dionante', 'Balnaja', NULL, 'Female', '1975-12-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(240, 139, 'head', 'Domingo', 'Rosa', 'Dupagen', NULL, 'Female', '1943-03-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(241, 140, 'head', 'Endeken', 'Janice', 'Bahelo', NULL, 'Female', '1981-09-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(242, 140, 'spouse', 'Endeken', 'Jonathan', 'Baltazar', NULL, 'Male', '1978-05-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(243, 141, 'head', 'Garvida', 'Joey', NULL, NULL, 'Male', '1979-12-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(244, 141, 'spouse', 'Vidad', 'Genybib', 'Casicdao', NULL, 'Female', '1982-06-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(245, 142, 'head', 'Ligaoen', 'Saranay', 'Mamolin', NULL, 'Female', '1986-10-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(246, 142, 'spouse', 'Ligaoen', 'Rogelio', 'Quezon', NULL, 'Male', '1978-10-24', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(247, 143, 'head', 'Magdab', 'Joseph', 'Barriga', NULL, 'Male', '1973-01-11', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(248, 143, 'spouse', 'Magdab', 'Darna', 'Barang', NULL, 'Female', '1972-07-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(249, 144, 'head', 'Magdab', 'Leonida', 'Barriga', NULL, 'Female', '1942-05-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(250, 145, 'head', 'Mamolin', 'Bernardo', 'Casicdao', NULL, 'Male', '1955-05-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(251, 146, 'head', 'Mamolin', 'Jerry', 'Impiel', NULL, 'Male', '1990-08-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(252, 146, 'spouse', 'Mamolin', 'Rowena', 'Vicente', NULL, 'Female', '1994-06-13', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(253, 147, 'head', 'Mamolin', 'Jhon', 'Casicdao', NULL, 'Male', '1966-06-14', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(254, 147, 'spouse', 'Mamolin', 'Imelda', 'Ventura', NULL, 'Female', '1979-12-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(255, 148, 'head', 'Monsalve', 'Resting', 'Abugan', NULL, 'Male', '1984-01-21', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(256, 148, 'spouse', 'Monsalve', 'Vinajane', 'Aguda', NULL, 'Female', '1984-12-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(257, 149, 'head', 'Monsalve', 'Paula', 'Abugan', NULL, 'Female', '1955-06-22', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(258, 149, 'spouse', 'Monsalve', 'Abundio', 'Berlon', NULL, 'Male', '1940-12-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(259, 150, 'head', 'Monsalve', 'Freddie', 'Abugan', NULL, 'Male', '1975-09-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(260, 150, 'spouse', 'Monsalve', 'Mayrose', 'Ramos', NULL, 'Female', '1985-05-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(261, 151, 'head', 'Aguinaldo', 'Jerwin', NULL, NULL, 'Male', '1987-01-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(262, 151, 'spouse', 'Paytocan', 'Jenelyn', 'Cabasoy', NULL, 'Female', '1993-07-24', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(263, 152, 'head', 'Rapanot', 'Francis', 'Magdab', NULL, 'Male', '1981-07-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(264, 152, 'spouse', 'Rapanot', 'Julie', 'Domingo', NULL, 'Female', '1983-12-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(265, 153, 'head', 'Rapanot', 'Francisco', 'Lorenzo', NULL, 'Male', '1959-01-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(266, 153, 'spouse', 'Rapanot', 'Nancy', 'Magdab', NULL, 'Female', '1965-10-31', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(267, 154, 'head', 'Rapanot', 'Ronald', 'Magdab', NULL, 'Male', '1984-09-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(268, 154, 'spouse', 'Rapanot', 'Clynadette', 'Ramos', NULL, 'Female', '1990-05-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(269, 155, 'head', 'Taggaoa', 'Elord', 'Domingo', NULL, 'Male', '1988-11-17', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(270, 155, 'spouse', 'Canedo', 'Marychelle', 'Plaza', NULL, 'Female', '1988-07-28', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(271, 156, 'head', 'Taggaoa', 'Elmo', 'Domingo', 'Jr.', 'Male', '1991-03-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(272, 157, 'head', 'Valencia', 'Memalyn', 'Vidad', NULL, 'Female', '1982-11-02', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(273, 158, 'head', 'Valencia', 'Marcial', 'Barriga', NULL, 'Male', '1973-02-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(274, 158, 'spouse', 'Valencia', 'Lorna', 'Bumanglag', NULL, 'Female', '1966-08-02', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(275, 159, 'head', 'Valencia', 'Jaquelyn', 'Domingo', NULL, 'Female', '1970-01-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(276, 159, 'spouse', 'Valencia', 'Roger', 'Maruquin', NULL, 'Male', '1968-01-12', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(277, 160, 'head', 'Valencia', 'Romeo', 'Barriga', NULL, 'Male', '1965-03-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(278, 160, 'spouse', 'Valencia', 'Maryflor', 'Segundo', NULL, 'Female', '1969-01-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(279, 161, 'head', 'Valencia', 'Rufina', 'Barriga', NULL, 'Female', NULL, '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(280, 162, 'head', 'Vicente', 'Bonifacio', 'Domingo', NULL, 'Male', '1972-07-04', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(281, 162, 'spouse', 'Barriga', 'Fredaline', 'Nardo', NULL, 'Female', '1983-06-10', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(282, 163, 'head', 'Vicente', 'Herminio', 'De Guzman', NULL, 'Male', '1933-08-03', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(283, 164, 'head', 'Vidad', 'Carmelita', 'Casicdao', NULL, 'Male', '1960-12-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(284, 164, 'spouse', 'Vidad', 'Joel', 'Casicdao', NULL, 'Male', '1977-02-20', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(285, 165, 'head', 'Vidad', 'Jenny Ann', 'Abugan', NULL, 'Female', '1989-09-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(286, 165, 'spouse', 'Vidad', 'Edison', 'Domingo', 'Jr.', 'Male', '1991-02-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(287, 166, 'head', 'Vidad', 'Linda', 'Domingo', NULL, 'Female', '1963-01-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(288, 166, 'spouse', 'Vidad', 'Edison', 'Acebedo', 'Sr.', 'Male', '1962-09-17', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(289, 167, 'head', 'Vidad', 'Ednalyn', 'Abugan', NULL, 'Female', '1981-12-16', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(290, 167, 'spouse', 'Vidad', 'Jennifer', 'Duldulao', NULL, 'Female', '1975-01-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(291, 168, 'head', 'Vidad', 'Analyn', 'Suniga', NULL, 'Female', '1991-01-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(292, 168, 'spouse', 'Vidad', 'Jonathan', 'Clemente', NULL, 'Female', '1992-09-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(293, 169, 'head', 'Vidad', 'April Ann', 'Abugan', NULL, 'Female', '1988-05-26', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(294, 169, 'spouse', 'Vidad', 'Judy Mark', 'Clemente', NULL, 'Male', '1987-02-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(295, 170, 'head', 'Mabini', 'Charice', NULL, NULL, 'Female', '1996-08-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(296, 170, 'spouse', 'Vidad', 'Junjie', 'Clemente', NULL, 'Male', '1995-06-27', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(297, 171, 'head', 'Vidad', 'Jowana Rose', 'Abugan', NULL, 'Female', '1977-01-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(298, 171, 'spouse', 'Vidad', 'Larry', 'Duldulao', NULL, 'Male', '1972-07-01', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(299, 172, 'head', 'Vidad', 'Anabelle', 'Abugan', NULL, 'Female', '1986-06-15', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(300, 172, 'spouse', 'Vidad', 'James', 'Domingo', NULL, 'Male', '1989-12-29', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(301, 173, 'head', 'Abugan', 'Waya', 'Dumalan', NULL, 'Male', '1950-03-11', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(302, 173, 'spouse', 'Abugan', 'Singising', 'Anggob', NULL, 'Female', '1962-05-05', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(303, 174, 'head', 'Anggob', 'Marcelino', 'Tumbed', NULL, 'Male', '1932-05-06', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(304, 175, 'head', 'Anggob', 'Joel', 'Tangilen', NULL, 'Male', '1978-05-08', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(305, 176, 'head', 'Alos', 'Saturnino', 'Tangilen', 'Sr.', 'Male', '1954-08-07', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(306, 177, 'head', 'Alos', 'Saturnino', 'Lorenzo', 'Jr.', 'Male', '1990-07-25', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(307, 177, 'spouse', 'Cestona', 'Jolina May', NULL, NULL, 'Female', '1997-05-18', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(308, 178, 'head', 'Alos', 'Willy', 'Tangilen', NULL, 'Male', '1969-08-06', '2026-08-22 12:38:46', '2026-08-22 12:38:46'),
(309, 179, 'head', 'Alos', 'Cathy', 'Tangilen', NULL, 'Female', '1960-11-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(310, 179, 'spouse', 'Alos', 'Gavina', 'Anggob', NULL, 'Female', '1991-07-30', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(311, 180, 'head', 'Alos', 'Madelio', 'Anggob', NULL, 'Male', '1991-07-30', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(312, 180, 'spouse', 'Alos', 'Rachelle Shane', 'Ramos', NULL, 'Female', '1999-04-07', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(313, 181, 'head', 'Alvarez', 'Michelle', 'Razo', NULL, 'Female', '1977-11-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(314, 181, 'spouse', 'Alvarez', 'Perfecto', 'Cutabos', NULL, 'Male', '1967-03-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(315, 182, 'head', 'Balbag', 'Rodel', 'Magdab', NULL, 'Male', '1980-06-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(316, 182, 'spouse', 'Balbag', 'Mary ann', 'Alos', NULL, 'Female', '1982-03-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(317, 183, 'head', 'Baging', 'Renier', 'Bassingan', NULL, 'Male', '1975-03-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(318, 184, 'head', 'Baging', 'Jun', 'Tumbed', NULL, 'Male', '1956-08-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(319, 184, 'spouse', 'Baging', 'Dominga', 'Bassingan', NULL, 'Female', '1953-07-21', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(320, 185, 'head', 'Baging', 'Maria', 'Tumbed', NULL, 'Female', '1935-10-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(321, 186, 'head', 'Barriga', 'Carmen', 'Aggob', NULL, 'Female', '1978-08-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(322, 187, 'head', 'Dorotan', 'May ann', 'Oron', NULL, 'Female', '1983-05-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(323, 187, 'spouse', 'Dorotan', 'Ryan', NULL, NULL, 'Male', '1984-06-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(324, 188, 'head', 'Dorotan', 'Leticia', 'Oron', NULL, 'Female', '1972-10-28', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(325, 188, 'spouse', 'Dorotan', 'Rodel', NULL, NULL, 'Male', '1972-08-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(326, 189, 'head', 'Illustrado', 'Roselyn', 'Vidad', NULL, 'Female', '1995-06-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(327, 189, 'spouse', 'Illustrado', 'Jefferson', 'Tangonan', NULL, 'Male', '1994-08-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(328, 190, 'head', 'Javier', 'Vangie', 'Ramos', NULL, 'Female', '1975-04-07', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(329, 190, 'spouse', 'Javier', 'Jolivert', 'Caraang', NULL, 'Male', '1976-10-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(330, 191, 'head', 'Macario', 'Jimmy', 'Razo', NULL, 'Male', '1981-09-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(331, 192, 'head', 'Magdab', 'Freddie', 'Tangilen', 'Sr.', 'Male', '1982-12-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(332, 192, 'spouse', 'Magdab', 'Anabelle', 'Oron', NULL, 'Female', '1987-12-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(333, 193, 'head', 'Magdab', 'Mario', NULL, NULL, 'Male', '1942-10-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(334, 194, 'head', 'Monsalve', 'Randy', 'Abugan', NULL, 'Male', '1973-06-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(335, 195, 'head', 'Oron', 'Carmen', 'Tumbed', NULL, 'Female', '1952-09-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(336, 196, 'head', 'Oron', 'Edwin', 'Tumbed', NULL, 'Male', '1980-07-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(337, 196, 'spouse', 'Oron', 'Mylene', 'Cariaga', NULL, 'Female', '1996-02-22', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(338, 197, 'head', 'Purdos', 'Lito', NULL, NULL, 'Male', '1945-09-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(339, 198, 'head', 'Ramos', 'Kingsly', 'Abugan', NULL, 'Male', '1984-10-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(340, 198, 'spouse', 'Ramos', 'Catherine', 'Alos', NULL, 'Female', '1988-03-13', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(341, 199, 'head', 'Ramos', 'Roger', 'Anggob', 'Sr.', 'Male', '1987-09-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(342, 199, 'spouse', 'Ramos', 'Evelyn', 'Manayan', NULL, 'Female', '1979-09-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(343, 200, 'head', 'Ramos', 'Romeo', 'Anggob', NULL, 'Male', '1968-05-19', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(344, 200, 'spouse', 'Ramos', 'Janna', 'Domingo', NULL, 'Female', '1972-05-30', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(345, 201, 'head', 'Razo', 'Gregorio', NULL, NULL, 'Male', '1950-04-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(346, 201, 'spouse', 'Razo', 'Josefina', NULL, NULL, 'Female', '1953-03-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(347, 202, 'head', 'Salvador', 'Ronalyn', 'Vidad', NULL, 'Female', '1990-01-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(348, 203, 'head', 'Tangilen', 'Gonzalo', 'Sengat', NULL, 'Male', '1945-06-13', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(349, 203, 'spouse', 'Tangilen', 'Carmelita', 'Anggob', NULL, 'Female', '1952-06-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(350, 204, 'head', 'Vidad', 'Jaworsky', 'Abugan', NULL, 'Male', '1994-04-22', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(351, 204, 'spouse', 'Vidad', 'Rona Jen', 'Ramos', NULL, 'Female', '1997-01-01', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(352, 205, 'head', 'Vidad', 'Elena', 'Anggob', NULL, 'Female', '1979-04-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(353, 205, 'spouse', 'Vidad', 'Rommel', 'Duldulao', 'Sr.', 'Male', '1968-02-28', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(354, 206, 'head', 'Aguda', 'Samuel', 'Dalog', NULL, 'Male', '1973-08-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(355, 206, 'spouse', 'Aguda', 'Marites', 'Maruquin', NULL, 'Female', '1976-09-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(356, 207, 'head', 'Aguda', 'Sanches', 'Dalog', NULL, 'Male', '1975-10-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(357, 207, 'spouse', 'Aguda', 'Belen', 'Manuel', NULL, 'Female', '1981-02-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(358, 208, 'head', 'Autriz', 'Anabella', 'Dalog', NULL, 'Female', '1958-09-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(359, 208, 'spouse', 'Autriz', 'Ely', 'Nieto', NULL, 'Male', '1958-09-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(360, 209, 'head', 'Autriz', 'Elizar', 'Dalog', NULL, 'Male', '1991-02-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(361, 209, 'spouse', 'Autriz', 'Ma. Cristella', 'Darizan', NULL, 'Female', '1995-12-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(362, 210, 'head', 'Autriz', 'Jimmy', NULL, NULL, 'Male', '1983-11-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(363, 211, 'head', 'Autriz', 'Alwin', 'Dalog', NULL, 'Male', '1995-04-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(364, 211, 'spouse', 'Autriz', 'Jaevemae', 'Padilla', NULL, 'Female', '1994-10-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(365, 212, 'head', 'Autriz', 'Edmon', 'Dalog', NULL, 'Male', '1993-05-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(366, 212, 'spouse', 'Autriz', 'Mercy', 'Baging', NULL, 'Female', '1995-03-07', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(367, 213, 'head', 'Banaba', 'Galano', 'Libnao', NULL, 'Male', '1957-07-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(368, 213, 'spouse', 'Banaba', 'Tarcila', 'Aguda', NULL, 'Female', '1962-03-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(369, 214, 'head', 'Banaba', 'Queros', 'Aguda', NULL, 'Male', '1981-08-31', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(370, 214, 'spouse', 'Banaba', 'Riza', 'Bao-an', NULL, 'Female', '1984-10-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(371, 215, 'head', 'Banaba', 'Rufina', 'Manuel', NULL, 'Female', '1953-11-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(372, 216, 'head', 'Bataan', 'Pilando', 'Dunog', NULL, 'Male', '1964-11-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(373, 216, 'spouse', 'Bataan', 'Marieta', 'Gullayan', NULL, 'Female', '1972-11-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(374, 217, 'head', 'Dalog', 'Nario', 'Alayao', NULL, 'Male', '1964-04-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(375, 217, 'spouse', 'Dalog', 'Janet', 'Sabado', NULL, 'Female', '1971-12-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(376, 218, 'head', 'Dalog', 'Jemar', 'Sabado', NULL, 'Male', '1991-02-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(377, 218, 'spouse', 'Dalog', 'Odessa Marie', 'Suniga', NULL, 'Female', '1998-12-19', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(378, 219, 'head', 'Dalog', 'Pidoracion', 'Alayao', NULL, 'Male', '1973-06-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(379, 219, 'spouse', 'Dalog', 'Jernalen', 'Abian', NULL, 'Female', '1984-10-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(380, 220, 'head', 'Dalog', 'Beltran', 'Alayao', NULL, 'Male', '1978-11-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(381, 221, 'head', 'Darisan', 'Michael', 'Oron', NULL, 'Male', '1991-05-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(382, 221, 'spouse', 'Maruquin', 'Jessa', 'Sina', NULL, 'Female', '1995-04-01', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(383, 222, 'head', 'Domingo', 'Jomar', 'Alos', NULL, 'Male', '1991-10-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(384, 223, 'head', 'Domingo', 'Julie', 'Gullayan', NULL, 'Female', '1979-04-21', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(385, 224, 'head', 'Dunog', 'Maxima', 'Gatab', NULL, 'Female', '1954-12-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(386, 225, 'head', 'Dumalan', 'Irineo', 'Dalog', NULL, 'Male', '1966-04-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(387, 225, 'spouse', 'Dumalan', 'Grace', 'Tul-o', NULL, 'Female', '1970-08-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(388, 226, 'head', 'Gullayan', 'Corazon', 'Banaba', NULL, 'Female', '1945-05-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(389, 227, 'head', 'Gullayan', 'Ronalyn', 'Banaba', NULL, 'Female', '1977-10-12', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(390, 228, 'head', 'Maruquin', 'Balasio', 'Baging', NULL, 'Male', '1962-10-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(391, 228, 'spouse', 'Maruquin', 'Precy', 'Sina', NULL, 'Female', '1969-12-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(392, 229, 'head', 'Maruquin', 'Braulo', 'Baging', NULL, 'Male', '1968-02-20', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(393, 229, 'spouse', 'Maruquin', 'Loreta', 'Alayao', NULL, 'Female', '1973-09-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(394, 230, 'head', 'Tomas', 'Reynald', 'Dacoycoy', NULL, 'Male', '1987-05-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(395, 230, 'spouse', 'Aguda', 'Sheryll', 'Maruquin', NULL, 'Female', '1995-12-12', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(396, 231, 'head', 'Aguda', 'Julie', 'Purdos', NULL, 'Female', '1964-10-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(397, 231, 'spouse', 'Aguda', 'Joefrey', 'Sayya', NULL, 'Male', '1988-07-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(398, 232, 'head', 'Abian', 'Arnel', 'Banglas', NULL, 'Male', '1976-11-07', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(399, 232, 'spouse', 'Abian', 'Laurena', 'Aguda', NULL, 'Female', '1977-11-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(400, 233, 'head', 'Abian', 'Arjay', 'Aguda', NULL, 'Male', '1995-01-13', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(401, 233, 'spouse', 'Abian', 'Marierose', 'Panabang', NULL, 'Female', '1999-10-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47');
INSERT INTO `ip_family_members` (`id`, `family_id`, `member_role`, `last_name`, `first_name`, `middle_name`, `suffix`, `sex`, `birthdate`, `created_at`, `updated_at`) VALUES
(402, 234, 'head', 'Abian', 'Ariel', 'Banglas', NULL, 'Male', '1979-11-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(403, 234, 'spouse', 'Abian', 'Maribel', 'Maltizo', NULL, 'Female', '1992-05-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(404, 235, 'head', 'Abian', 'Arcel', 'Banglas', NULL, 'Male', '1981-11-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(405, 235, 'spouse', 'Abian', 'Rosalina', 'Bayubay', NULL, 'Female', '1984-03-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(406, 236, 'head', 'Abian', 'Alejandro', 'Subac', NULL, 'Male', '1954-11-03', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(407, 236, 'spouse', 'Abian', 'Rosa', 'Banglas', NULL, 'Female', '1957-08-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(408, 237, 'head', 'Abian', 'Arnold', 'Banglas', NULL, 'Male', '1983-09-12', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(409, 237, 'spouse', 'Abian', 'Maricon', 'Camilit', NULL, 'Female', '1997-01-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(410, 238, 'head', 'Aguinaldo', 'Ernesto', 'Catubloy', NULL, 'Male', '1957-10-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(411, 238, 'spouse', 'Aguinaldo', 'Erinia', 'Aglamma', NULL, 'Female', '1962-10-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(412, 239, 'head', 'Aguinaldo', 'Roel', 'Aglamma', NULL, 'Male', '1982-03-19', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(413, 239, 'spouse', 'Aguinaldo', 'Grace', 'Sawadan', NULL, 'Female', '1987-02-02', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(414, 240, 'head', 'Aglamma', 'Delia', 'Sappat', NULL, 'Female', '1959-09-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(415, 241, 'head', 'Banaba', 'Freda', 'Alayao', NULL, 'Female', '1994-04-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(416, 242, 'head', 'Banaba', 'Analyn', 'Alayao', NULL, 'Female', '1996-06-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(417, 243, 'head', 'Banglas', 'Victor', 'Banaba', NULL, 'Male', '1987-10-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(418, 244, 'head', 'Bayubay', 'Jimmy', 'Sappat', NULL, 'Male', '1979-09-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(419, 244, 'spouse', 'Bayubay', 'Marla', 'Banglas', NULL, 'Female', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(420, 245, 'head', 'Bayubay', 'Jermin', 'Sappat', NULL, 'Male', '1990-12-01', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(421, 245, 'spouse', 'Bayubay', 'Rosemarie', 'Tid-ong', NULL, 'Female', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(422, 246, 'head', 'Butad', 'Joffrey', 'Bayubay', NULL, 'Male', '1985-02-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(423, 247, 'head', 'James', 'Teddy', 'Balicao', NULL, 'Male', '1976-11-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(424, 247, 'spouse', 'Castillo', 'Mary ann', 'Aglamma', NULL, 'Female', '1980-05-20', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(425, 248, 'head', 'Dumalan', 'Jenelyn', 'Manggay', NULL, 'Female', '1998-09-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(426, 249, 'head', 'Maltezo', 'Michelle', 'Sappat', NULL, 'Female', '1984-02-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(427, 249, 'spouse', 'Maltezo', 'Ruth', 'Cascayan', NULL, 'Female', '1992-04-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(428, 250, 'head', 'Manggay', 'Jay Paul', 'Simmawa', NULL, 'Male', '1976-05-02', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(429, 250, 'spouse', 'Manggay', 'Helen', 'Banaba', NULL, 'Female', '1978-02-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(430, 251, 'head', 'Simmawa', 'June', 'Manuel', NULL, 'Male', '1976-10-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(431, 251, 'spouse', 'Simmawa', 'Lucia', 'Domingo', NULL, 'Female', '1957-01-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(432, 252, 'head', 'Purdos', 'Rodolfo', 'Bales', NULL, 'Male', '1958-05-01', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(433, 252, 'spouse', 'Purdos', 'Editha', 'Simon', NULL, 'Female', '1962-09-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(434, 253, 'head', 'Simon', 'Maribel', 'Sabado', NULL, 'Female', '1970-02-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(435, 254, 'head', 'Simon', 'Tessie', 'Maruquin', NULL, 'Male', '1972-04-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(436, 255, 'head', 'Simon', 'Rowel', 'Bayubay', NULL, 'Male', '1985-02-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(437, 255, 'spouse', 'Simon', 'Ilyn', 'Aguinaldo', NULL, 'Female', '1986-12-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(438, 256, 'head', 'Sina', 'Magdalena', 'Aglamma', NULL, 'Female', '1957-10-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(439, 257, 'head', 'Sina', 'Marlon', 'Aglamma', NULL, 'Male', '1979-04-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(440, 258, 'head', 'Sina', 'Resly', 'Aglamma', NULL, 'Male', '1975-05-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(441, 258, 'spouse', 'Sina', 'Mariejoy', 'Abian', NULL, 'Female', '1980-05-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(442, 259, 'head', 'Tacderan', 'Joana', 'Abian', NULL, 'Female', '1988-04-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(443, 259, 'spouse', 'Tacderan', 'Redentor', 'Nagtalon', NULL, 'Male', '1988-09-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(444, 260, 'head', 'Vidad', 'Imelda', 'Catcatan', NULL, 'Female', '1966-05-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(445, 260, 'spouse', 'Vidad', 'Argel', 'Malbartino', NULL, 'Male', '1966-11-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(446, 261, 'head', 'Catcatan', 'Rufino', 'Bunoy', NULL, 'Male', '1939-04-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(447, 261, 'spouse', 'Catcatan', 'Rosita', 'Bayeng', NULL, 'Female', '1940-01-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(448, 262, 'head', 'Catcatan', 'Dimas', 'Bassingan', NULL, 'Male', '1996-09-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(449, 263, 'head', 'Acosta', 'Marie', 'Sayno', NULL, 'Female', '1963-03-03', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(450, 264, 'head', 'Aguinsod', 'Dick', 'Martes', NULL, 'Male', '1967-11-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(451, 265, 'head', 'Camacam', 'Feliza', 'Magno', NULL, 'Female', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(452, 266, 'head', 'Cascayan', 'Nestor', 'Aguinsod', NULL, 'Male', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(453, 267, 'head', 'Catalan', 'Vincent', 'Dummao', NULL, 'Male', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(454, 268, 'head', 'Diza', 'Ofelia', 'Padsing', NULL, 'Female', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(455, 269, 'head', 'WALLENG', 'BENITO', 'BALLAD', NULL, NULL, '1935-06-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(456, 269, 'spouse', 'WALLENG', 'Mercedes', 'Sungot', NULL, NULL, '1935-11-29', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(457, 270, 'head', 'Soriano', 'Harold Roy', NULL, NULL, 'Male', '1985-09-30', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(458, 270, 'spouse', 'Calimlim', 'Belinda', NULL, NULL, NULL, NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(459, 271, 'head', 'WALLENG', 'Virgie', 'Sungot', NULL, 'Female', '1969-01-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(460, 272, 'head', 'SAYYA,', 'Emilia', 'Atin-ew', NULL, 'Female', '1951-12-02', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(461, 273, 'head', 'BUDAO', 'Luisito', 'Bagala', NULL, 'Male', '1940-03-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(462, 273, 'spouse', 'BUDAO', 'Prudencia', 'Baltazar', NULL, NULL, '1941-11-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(463, 274, 'head', 'TAWALI', 'Melinda', 'Sacsac', NULL, 'Female', '1979-07-09', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(464, 275, 'head', 'LAKLAKI', 'John', 'Bodekan', NULL, 'Male', '1956-12-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(465, 276, 'head', 'QUIMOYOG', 'Catalina', 'Manuel', NULL, 'Female', '1960-11-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(466, 276, 'spouse', 'QUIMOYOG', 'Dulfo', 'Rubiu', NULL, NULL, '1960-10-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(467, 277, 'head', 'PADILLA', 'Jefter', 'Padsing', NULL, 'Male', '1998-02-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(468, 277, 'spouse', 'PADILLA', 'Janet', 'Valdez', NULL, NULL, '1995-10-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(469, 278, 'head', 'MAGARRO', 'Jennifer', 'Padilla', NULL, 'Female', '1989-11-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(470, 278, 'spouse', 'MAGARRO', 'Jett', 'Ganno', NULL, NULL, '1990-01-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(471, 279, 'head', 'PADILLA', 'Jefferson', 'Padsing', NULL, 'Male', '1991-11-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(472, 279, 'spouse', 'PADILLA', 'Cristina', 'Pay-ong', NULL, NULL, '1992-07-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(473, 280, 'head', 'PADILLA', 'Gerald', 'Padsing', NULL, 'Male', '1987-11-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(474, 280, 'spouse', 'PADILLA', 'Maricris', 'Casay', NULL, NULL, '1990-03-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(475, 281, 'head', 'Figueroa', 'James', 'Dongaso', NULL, 'Male', '1995-04-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(476, 281, 'spouse', 'Ola', 'Roselyn', 'Ortega', NULL, NULL, '1998-04-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(477, 282, 'head', 'Cabradilla', 'Jimmy', 'Doliken', NULL, 'Male', '1976-05-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(478, 282, 'spouse', 'Mosende', 'Aubrey', NULL, NULL, NULL, '1987-04-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(479, 283, 'head', 'Ducala', 'Monica', 'Dongaso', NULL, 'Female', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(480, 284, 'head', 'Ligaoen', 'Eduardo', 'Tukiad', NULL, 'Male', '1955-05-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(481, 285, 'head', 'Macamus', 'Samson', 'Tangonan', NULL, 'Male', '1986-10-29', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(482, 285, 'spouse', 'Macamus', 'Raquel', 'Ligaoen', NULL, NULL, '1983-07-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(483, 286, 'head', 'Meniano', 'Fernando', 'Tabugno', NULL, 'Male', '1969-02-13', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(484, 286, 'spouse', 'Meniano', 'Rosa', 'Tukiad', NULL, NULL, '1980-01-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(485, 287, 'head', 'Nahgab', 'Shandy Sr.', 'Napadawan', NULL, 'Male', '1988-09-21', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(486, 287, 'spouse', 'Sayya', 'Ligaya', 'Atin-ew', NULL, NULL, '1986-01-11', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(487, 288, 'head', 'Tubay', 'Imelda', 'Manuel', NULL, 'Female', '1967-02-14', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(488, 289, 'head', 'Tukiad', 'Juan', 'Aypewan', NULL, 'Male', '1943-06-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(489, 290, 'head', 'Tukiad', 'Jose', 'Padsing', NULL, 'Male', '1981-03-18', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(490, 291, 'head', 'Bassingan', 'Reynald', 'Balanay', NULL, 'Male', '1997-10-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(491, 292, 'head', 'Dongaso', 'Alice', 'Tubay', NULL, 'Female', '1986-08-30', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(492, 293, 'head', 'Diza', 'Joffrey', 'Flores', NULL, 'Male', '1976-11-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(493, 294, 'head', 'Baging', 'Regie', 'Bassingan', NULL, 'Male', NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(494, 295, 'head', 'Laklaki', 'Eulesis', 'Quitoyan', NULL, 'Male', '1982-03-22', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(495, 295, 'spouse', 'Accatan', 'Arlene', 'Calpasi', NULL, NULL, '1990-06-27', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(496, 296, 'head', 'Paytocan', 'Darwin', 'Tapia', NULL, 'Male', '1982-09-15', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(497, 296, 'spouse', 'Paytocan', 'Marilyn', 'Clemente', NULL, NULL, '1990-04-04', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(498, 297, 'head', 'Tabangin', 'Marilou', 'Poking', NULL, 'Female', '1979-10-29', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(499, 297, 'spouse', 'Tabangin', 'Freddie', 'Ravelo', NULL, NULL, '1979-01-31', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(500, 298, 'head', 'Tawali', 'Geraldine', 'Lazo', NULL, 'Female', '1995-08-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(501, 299, 'head', 'Tangliben', 'Decker', 'Gaspar', NULL, 'Male', '1987-11-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(502, 299, 'spouse', 'Tangliben', 'Glaire', 'Poking', NULL, NULL, '1982-04-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(503, 300, 'head', 'Ubongen', 'Mary-Ann', 'Poking', NULL, 'Female', '1977-06-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(504, 301, 'head', 'Ubongen', 'Russell Matt', 'Poking', NULL, 'Male', '1999-05-08', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(505, 301, 'spouse', 'Manuel', 'Jeikimdaishi', 'Cabicungan', NULL, NULL, '2001-03-10', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(506, 302, 'head', 'Uyaan', 'Eduardo', 'Lacbao', NULL, 'Male', '1961-09-23', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(507, 302, 'spouse', 'Uyaan', 'Gloria', 'Tukiad', NULL, NULL, NULL, '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(508, 303, 'head', 'Uyaan', 'Rey', 'Tukiad', NULL, 'Male', '1999-08-20', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(509, 303, 'spouse', 'Ortega', 'Lea', 'Abugan', NULL, NULL, '1999-04-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(510, 304, 'head', 'Uyaan', 'Edgar', 'Tukiad', NULL, 'Male', '1986-05-07', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(511, 304, 'spouse', 'Uyaan', 'Melanie', 'Umalla', NULL, NULL, '1986-04-25', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(512, 305, 'head', 'Banggao', 'Emilio', 'Galungayan', NULL, 'Male', '1968-07-26', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(513, 305, 'spouse', 'Ortega', 'Precy', 'Buccat', NULL, NULL, '1979-09-17', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(514, 306, 'head', 'Banggao', 'Esteban', 'Legos', NULL, 'Male', '1948-07-06', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(515, 306, 'spouse', 'Banggao', 'Lourdes', 'Galungayan', NULL, NULL, '1949-09-16', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(516, 307, 'head', 'Banggao', 'Jon', 'Galungayan', NULL, 'Male', '1982-12-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(517, 307, 'spouse', 'Banggao', 'Jennifer', 'Ubonan', NULL, NULL, '1994-09-22', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(518, 308, 'head', 'Benito', 'Bonifacio Jr.', 'Mag-ili', NULL, 'Male', '1989-02-05', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(519, 308, 'spouse', 'Benito', 'Cherry May', 'Soriano', NULL, NULL, '1995-03-24', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(520, 309, 'head', 'Culidso', 'Ansong', 'Sekado', NULL, 'Male', '1943-10-31', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(521, 309, 'spouse', 'Culidso', 'Lydia', 'Quezon', NULL, NULL, '1952-10-03', '2026-08-22 12:38:47', '2026-08-22 12:38:47'),
(522, 310, 'head', 'Doliken', 'Amor', 'Bolka', NULL, 'Male', '1978-10-03', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(523, 310, 'spouse', 'Suniga', 'Jessa', 'Tukiad', NULL, NULL, NULL, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(524, 311, 'head', 'Florentino', 'Patricia', 'Padsing', NULL, 'Female', '1965-04-06', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(525, 311, 'spouse', 'Florentino', 'Serafin', 'Cadiz', NULL, NULL, '1959-08-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(526, 312, 'head', 'Flores', 'Sylvia', 'Sayya', NULL, 'Female', '1976-11-03', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(527, 312, 'spouse', 'Flores', 'Prexie', 'Sayya', NULL, NULL, '2000-11-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(528, 313, 'head', 'Galletes', 'Sandy', 'Cayat', NULL, 'Male', '1974-01-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(529, 313, 'spouse', 'Galletes', 'Monaliza', 'Pucate', NULL, NULL, '1985-08-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(530, 314, 'head', 'Liccud', 'Clemente Jr', 'Tada', NULL, 'Male', '1984-06-05', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(531, 315, 'head', 'Liccud', 'Hernando', 'Tada', NULL, 'Male', '1972-07-31', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(532, 316, 'head', 'Liccud', 'Egbert', 'Tada', NULL, 'Male', '1979-11-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(533, 316, 'spouse', 'Liccud', 'Imelda', 'Ligo', NULL, NULL, '1976-01-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(534, 317, 'head', 'Obaldo', 'Edgar', 'Bao-an', NULL, 'Male', '1987-09-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(535, 317, 'spouse', 'Medrano', 'Angel', 'Castillanes', NULL, NULL, '2012-06-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(536, 318, 'head', 'Sayya', 'Diego', 'Atin-ew', NULL, 'Male', '1990-02-13', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(537, 318, 'spouse', 'Sayya', 'Sonia', 'Guron', NULL, NULL, '1996-10-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(538, 319, 'head', 'Toquero', 'Irish', 'Tukiad', NULL, 'Male', '1987-12-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(539, 319, 'spouse', 'Tungpalan', 'Norbie', 'Combes', NULL, NULL, '1987-10-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(540, 320, 'head', 'Tukiad', 'Nimrod', 'Iwagen', NULL, 'Male', '1990-08-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(541, 320, 'spouse', 'Tukiad', 'Dina', 'Tusnoy', NULL, NULL, '1990-12-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(542, 321, 'head', 'Aguda', 'Esther', 'Tumayoc', NULL, 'Female', '1970-02-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(543, 321, 'spouse', 'Aguda', 'Faustino', 'Maltizo', NULL, NULL, '1958-12-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(544, 322, 'head', 'Aguda', 'Rhengie', 'Tumayoc', NULL, 'Male', '1986-01-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(545, 322, 'spouse', 'Aguda', 'Evangeline', 'Tabangin', NULL, NULL, '1986-11-04', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(546, 323, 'head', 'Aguda', 'Rhaelyn Jane', 'Tumayoc', NULL, 'Female', '1999-08-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(547, 324, 'head', 'Cascayan', 'Bena', 'Comiles', NULL, 'Female', '1965-09-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(548, 324, 'spouse', 'Cascayan', 'Dominador', 'Viernes', NULL, NULL, '1955-07-25', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(549, 325, 'head', 'Cascayan', 'Jema', 'Tukiad', NULL, 'Female', '1973-08-03', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(550, 325, 'spouse', 'Cascayan', 'Joseph', 'Abadilla', NULL, NULL, '1971-12-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(551, 326, 'head', 'Cascayan', 'Wilmer', 'Bassingan', NULL, 'Male', '1972-05-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(552, 327, 'head', 'Cascayan', 'Crisanto', 'Bassingan', NULL, 'Female', '1983-02-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(553, 327, 'spouse', 'Cascayan', 'Claribel', 'Aguda', NULL, NULL, '1993-10-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(554, 328, 'head', 'Darisan', 'Raymond', 'Ladia', NULL, 'Male', '1989-10-09', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(555, 328, 'spouse', 'Bueno', 'Rosie', 'Cascayan', NULL, NULL, '1989-09-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(556, 329, 'head', 'Dumaguing', 'Magdalena', 'Culidso', NULL, 'Female', '1985-04-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(557, 329, 'spouse', 'Dumaguing', 'Mike', 'Segundo', NULL, NULL, '1989-10-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(558, 330, 'head', 'Dupagen', 'Adela', 'Magdab', NULL, 'Female', '1963-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(559, 331, 'head', 'Dupagen', 'Ruby Ann', 'Magdab', NULL, 'Female', '1996-03-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(560, 331, 'spouse', 'Pagala', 'Jaymark', 'Caban', NULL, NULL, '1991-04-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(561, 332, 'head', 'Fernando', 'Narcisa', 'Dummao', NULL, 'Female', '1964-07-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(562, 332, 'spouse', 'Fernando', 'Saulo', 'Pangyarihan', NULL, NULL, '1961-10-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(563, 333, 'head', 'Labasan', 'Erlinda', 'Tukiad', NULL, 'Female', '1956-06-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(564, 333, 'spouse', 'Labasan', 'Irinio', 'Ariola', NULL, NULL, '1954-04-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(565, 334, 'head', 'Labasan', 'Marvin', 'Tukiad', NULL, 'Male', '1983-07-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(566, 334, 'spouse', 'Labasan', 'Jenalyn', 'Manggay', NULL, NULL, '1980-07-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(567, 335, 'head', 'Labasan', 'Raymund', 'Tukiad', NULL, 'Male', '1987-09-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(568, 335, 'spouse', 'Labasan', 'Jonalyn', 'Vicente', NULL, NULL, '1994-07-03', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(569, 336, 'head', 'Gamong-e', 'Francisca', 'Galleto', NULL, 'Female', '1995-03-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(570, 336, 'spouse', 'Laklaki', 'Dennis Jr.', 'Cabradilla', NULL, NULL, '1994-01-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(571, 337, 'head', 'Ligaoen', 'Danilo', 'Quezon', NULL, 'Male', '1976-06-09', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(572, 337, 'spouse', 'Ligaoen', 'Mayline', 'Luis', NULL, NULL, '1976-02-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(573, 338, 'head', 'Madrid', 'Tessie', 'Dongaso', NULL, 'Female', '1965-06-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(574, 339, 'head', 'Andres', 'April', 'Madrid', NULL, 'Female', '1995-09-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(575, 339, 'spouse', 'Andres', 'Reymond', 'Sabiano', NULL, NULL, '1988-02-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(576, 340, 'head', 'Mangagey', 'Eden', 'Tugade', NULL, 'Female', '1985-07-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(577, 340, 'spouse', 'Mangagey', 'Robert', NULL, NULL, NULL, '1977-04-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(578, 341, 'head', 'Mondiguing', 'Benita', 'Pag-a', NULL, 'Female', '1958-11-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(579, 342, 'head', 'Ortega', 'Jose', 'Buccat', NULL, 'Male', '1980-07-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(580, 342, 'spouse', 'Ortega', 'Juliet', 'Patong', NULL, NULL, '1980-07-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(581, 343, 'head', 'Sacpa', 'Romeo', 'Tugade', NULL, 'Male', '1958-06-19', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(582, 343, 'spouse', 'Sacpa', 'Gina', 'Pulic-ew', NULL, NULL, '1962-03-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(583, 344, 'head', 'Ramiro', 'Milagros', 'Patong', NULL, 'Male', '1976-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(584, 344, 'spouse', 'Ramiro', 'Lorenzo', 'Aleta', NULL, NULL, '1969-08-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(585, 345, 'head', 'Suniga', 'Corazon', 'Tukiad', NULL, 'Female', '1969-04-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(586, 345, 'spouse', 'Suniga', 'Benjamin', 'Aguda', NULL, NULL, '1962-12-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(587, 346, 'head', 'Suniga', 'Joshua', 'Tukiad', NULL, 'Male', '1994-12-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(588, 346, 'spouse', 'Layugan', 'Grace', 'Abara', NULL, NULL, '1996-05-04', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(589, 347, 'head', 'Toquero', 'Shiela', 'Tukiad', NULL, 'Female', '1959-11-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(590, 347, 'spouse', 'Toquero', 'Jerney', 'Tukiad', NULL, NULL, '1987-01-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(591, 348, 'head', 'Tugade', 'Lea', 'Martes', NULL, 'Female', '1983-06-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(592, 348, 'spouse', 'Tugade', 'Jimmy', 'Dominguez', NULL, NULL, '1977-09-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(593, 349, 'head', 'Acupan', 'Pio', 'Benito', NULL, 'Male', '1935-05-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(594, 349, 'spouse', 'Acupan', 'Dorotea', 'Baldazan', NULL, NULL, '1947-10-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(595, 350, 'head', 'Paytocan', 'Lino Jr.', 'Pedronan', NULL, 'Male', '1993-03-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(596, 350, 'spouse', 'Tajodloy', 'Jennifer', 'Balalio', NULL, NULL, '1985-08-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(597, 351, 'head', 'Aguda', 'Daisy', 'Cabasoy', NULL, 'Female', '1979-12-07', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(598, 351, 'spouse', 'Aguda', 'Edwin', 'Espiritu', NULL, NULL, '1974-08-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(599, 352, 'head', 'Antonio', 'Jessabel', 'Aguda', NULL, 'Female', '1998-02-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(600, 352, 'spouse', 'Antonio', 'Monchito', 'Datul', NULL, NULL, '1995-07-31', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(601, 353, 'head', 'Pancho', 'Joselito', 'Agoo', NULL, 'Male', '1998-05-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(602, 353, 'spouse', 'Aguda', 'Leny', 'Calingay', NULL, NULL, '1998-12-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(603, 354, 'head', 'Alicoy', 'George', 'Siano', NULL, 'Male', '1965-06-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(604, 354, 'spouse', 'Briñas', 'Corazon', 'Bismonte', NULL, NULL, '1963-09-13', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(605, 355, 'head', 'Valentin', 'Dianne Kate', 'Alicoy', NULL, 'Female', '1996-06-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(606, 355, 'spouse', 'Valentin', 'Edmar', NULL, NULL, NULL, '1996-02-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(607, 356, 'head', 'Bang-ot', 'Benedict', 'Dugas', NULL, 'Male', '1980-04-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(608, 356, 'spouse', 'Doliken', 'Marissa', 'Bolka', NULL, NULL, '1975-03-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(609, 357, 'head', 'Bautista', 'Jenevic', 'Abian', NULL, 'Female', '1991-01-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(610, 357, 'spouse', 'Bautista', 'Lordhund', 'Lacar', NULL, NULL, '1987-09-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(611, 358, 'head', 'Bawingan', 'Rosa', 'Tangliben', NULL, 'Female', '1943-08-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(612, 359, 'head', 'Bangsoy', 'Joyce', 'Bawingan', NULL, 'Female', '1967-06-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(613, 360, 'head', 'Cabasoy', 'Alfonso', 'Paguli', NULL, 'Male', '1949-12-13', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(614, 360, 'spouse', 'Cabasoy', 'Maria', 'Alicay', NULL, NULL, '1952-04-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(615, 361, 'head', 'Cabasoy', 'Emerson', 'Alicoy', NULL, 'Male', '1982-09-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(616, 361, 'spouse', 'Cabasoy', 'Carmelita', 'Telado', NULL, NULL, '1987-11-25', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(617, 362, 'head', 'Aguda', 'Lilia', 'Calingay', NULL, 'Female', '1973-09-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(618, 362, 'spouse', 'Cadang', 'Johanes', 'Bareng', NULL, NULL, '1983-06-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(619, 363, 'head', 'Castillo', 'Monalisa', 'Galletes', NULL, 'Female', '1987-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(620, 363, 'spouse', 'Castillo', 'Christopher', NULL, NULL, NULL, '1982-09-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(621, 364, 'head', 'Dakiling', 'Norberto', 'Dangowan', NULL, 'Male', '1950-05-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(622, 365, 'head', 'Dakiling', 'James', 'Aypawen', NULL, 'Male', '1998-03-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(623, 365, 'spouse', 'Cayaas', 'Gebee', NULL, NULL, NULL, '1991-03-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(624, 366, 'head', 'Dalog', 'Demy Rose', 'Guingania', NULL, 'Female', '1998-10-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(625, 367, 'head', 'Ferrer', 'Jacqueline', 'Silverio', NULL, 'Female', '1987-12-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(626, 368, 'head', 'Fernandez', 'Violeta', 'Cabasoy', NULL, 'Female', NULL, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(627, 368, 'spouse', 'Fernandez', 'Zaldy', NULL, NULL, NULL, '1978-05-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(628, 369, 'head', 'Galletes', 'Cecilio', 'Tusnoy', NULL, 'Male', '1949-06-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(629, 369, 'spouse', 'Galletes', 'Juanita', 'Cayat', NULL, NULL, '1949-01-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(630, 370, 'head', 'Llama', 'Lewey', 'Uyaan', NULL, 'Male', '1983-08-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(631, 370, 'spouse', 'Llama', 'Agnes', 'Sinco', NULL, NULL, '1994-02-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(632, 371, 'head', 'Llama', 'Rodrigo Sr.', 'Budao', NULL, 'Male', '1951-08-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(633, 371, 'spouse', 'Llama', 'Leticia', 'Uyaan', NULL, NULL, '1959-11-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(634, 372, 'head', 'Benedicto', 'Marites', 'Llama', NULL, 'Female', '1989-03-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(635, 372, 'spouse', 'Benedicto', 'Romel', NULL, NULL, NULL, '1985-12-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(636, 373, 'head', 'Madalipay', 'Eden', 'Cabasoy', NULL, 'Female', '1984-03-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(637, 373, 'spouse', 'Madalipay', 'Rogie', 'Palafox', NULL, NULL, '1980-10-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(638, 374, 'head', 'Manggay', 'Lilyrose', 'Tusnoy', NULL, 'Female', '1988-08-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(639, 375, 'head', 'Martes', 'Emilio', 'Olat', NULL, 'Male', '1948-06-07', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(640, 375, 'spouse', 'Martes', 'Pacita', 'Comay-ao', NULL, NULL, '1955-11-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(641, 376, 'head', 'Tangco', 'Apple', 'Martes', NULL, 'Female', '1994-12-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(642, 376, 'spouse', 'Tangco', 'Christian', 'Ruga', NULL, NULL, '1983-11-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(643, 377, 'head', 'Maruquin', 'Romnick', 'Alayao', NULL, 'Male', '1989-10-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(644, 377, 'spouse', 'Maruquin', 'Janice', 'Paytocan', NULL, NULL, '1995-08-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(645, 378, 'head', 'Miñano', 'Cristina', 'Tabugno', NULL, 'Female', '1982-09-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(646, 379, 'head', 'Miniano', 'Artemio', 'Talliad', NULL, 'Male', '1941-06-07', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(647, 379, 'spouse', 'Requipo', 'Marilou', 'Gaoiran', NULL, NULL, '1958-10-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(648, 380, 'head', 'Miniano', 'Loreto', 'Tabugno', NULL, 'Male', NULL, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(649, 381, 'head', 'Patil-ao', 'Elmo', 'Cayandang', NULL, 'Male', '1968-12-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(650, 381, 'spouse', 'Patil-ao', 'Virginia', 'Silverio', NULL, NULL, '1975-12-04', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(651, 382, 'head', 'Paytocan', 'Lino Jr.', 'Pedronan', NULL, 'Male', NULL, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(652, 382, 'spouse', 'Tajodloy', 'Jennifer', 'Balalio', NULL, NULL, '1985-10-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(653, 383, 'head', 'Paytocan', 'Diokno', 'Pedronan', NULL, 'Male', '1990-02-25', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(654, 383, 'spouse', 'Paytocan', 'Prinalyn', 'Dadiz', NULL, NULL, '1989-04-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(655, 384, 'head', 'Pedronan', 'Lesita', 'Balangen', NULL, 'Female', '1977-09-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(656, 384, 'spouse', 'Pedronan', 'Rico', 'Aguda', NULL, NULL, '1973-04-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(657, 385, 'head', 'Podes', 'Dominga', 'Galletes', NULL, 'Female', '1982-11-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(658, 385, 'spouse', 'Podes', 'Jennifer', 'Galletes', NULL, NULL, '2003-08-19', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(659, 386, 'head', 'Recile', 'Benjamin', 'Laklaki', NULL, 'Male', '1974-10-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(660, 386, 'spouse', 'Recile', 'Celeste', 'Codamos', NULL, NULL, '1982-02-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(661, 387, 'head', 'Requipo', 'Felicidad', 'Galletes', NULL, 'Female', '1980-12-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(662, 387, 'spouse', 'Requipo', 'Arsenio', 'Gaoiran', NULL, NULL, '1975-06-06', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(663, 388, 'head', 'Secwaten', 'Junie', 'Alicoy', NULL, 'Male', '1976-05-05', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(664, 388, 'spouse', 'Secwaten', 'Emily', 'Casem', NULL, NULL, '1975-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(665, 389, 'head', 'Sucapen', 'Fidel', 'Ballasiw', NULL, 'Male', '1958-05-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(666, 389, 'spouse', 'Sucapen', 'Julia', 'Laklaki', NULL, NULL, '1953-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(667, 390, 'head', 'Tangliben', 'Moore', 'Gaspar', NULL, 'Male', '1990-09-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(668, 390, 'spouse', 'Tangliben', 'Arvy Jay', 'Panabang', NULL, NULL, '1990-03-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(669, 391, 'head', 'Tablang', 'Jessa Mae', 'Tubay', NULL, 'Female', '1994-05-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(670, 391, 'spouse', 'Tablang', 'Reynaldo', 'Degracia', NULL, NULL, '1987-11-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(671, 392, 'head', 'Tubay', 'Wibert', 'Calventas', NULL, 'Male', '1987-03-21', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(672, 393, 'head', 'Tusnoy', 'Conrado', 'Lagto', NULL, 'Male', '1958-07-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(673, 393, 'spouse', 'Tusnoy', 'Lydia', 'Cabasoy', NULL, NULL, '1964-10-26', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(674, 394, 'head', 'Tusnoy', 'Felimon', 'Lagto', NULL, 'Male', '1962-01-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(675, 394, 'spouse', 'Tusnoy', 'Belen', 'Dalagan', NULL, NULL, '1966-12-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(676, 395, 'head', 'Tusnoy', 'Franklin', 'Dalagan', NULL, 'Male', '1990-08-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(677, 396, 'head', 'Tusnoy', 'Glenn', 'Dallagan', NULL, 'Male', '1993-09-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(678, 396, 'spouse', 'Martes', 'Pamela', 'Comay-ao', NULL, NULL, '1985-01-18', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(679, 397, 'head', 'Tusnoy', 'Melecio', 'Bas-ilan', NULL, 'Male', '1935-12-13', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(680, 398, 'head', 'Autriz', 'Erlyne', 'Dalog', NULL, 'Female', '1980-04-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(681, 398, 'spouse', 'Villanueva', 'Jaspher', 'Aguda', NULL, NULL, '1989-08-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(682, 399, 'head', 'Cabasoy', 'Amante', 'Dummao', NULL, 'Male', '1978-03-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(683, 400, 'head', 'Cabasoy', 'Juanito', 'Waklin', NULL, 'Male', '1941-03-02', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(684, 400, 'spouse', 'Cabasoy', 'Dorotea', 'Bassio', NULL, NULL, '1054-08-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(685, 401, 'head', 'Cabasoy', 'Orlando', 'Dummao', NULL, 'Male', '1967-09-19', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(686, 401, 'spouse', 'Cabasoy', 'Editha', 'Domingo', NULL, NULL, '1969-08-03', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(687, 402, 'head', 'Cabasoy', 'Jhune', 'Dummao', NULL, 'Male', '1976-06-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(688, 403, 'head', 'Paytocan', 'Juvielyn', 'Cabasoy', NULL, 'Female', '1995-09-29', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(689, 403, 'spouse', 'Calumpit', 'Jessie', 'Batara', NULL, NULL, '1985-09-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(690, 404, 'head', 'Paytocan', 'Lilialinolyn', 'Tapia', NULL, 'Female', '1988-04-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(691, 404, 'spouse', 'Gutierrez', 'Juancho', 'Dalit', NULL, NULL, '1984-09-09', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(692, 405, 'head', 'Ligaoen', 'Rogelio', 'Quezon', NULL, 'Male', '1978-10-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(693, 405, 'spouse', 'Ligaoen', 'Saranay', 'Mamolin', NULL, NULL, '1986-10-27', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(694, 406, 'head', 'Paytocan', 'Jaime', 'Lupadit', NULL, 'Male', '1973-09-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(695, 406, 'spouse', 'Paytocan', 'Rosalia', 'Ligaoen', NULL, NULL, '1973-01-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(696, 407, 'head', 'Paytocan', 'Loreto', 'Bucaus', NULL, 'Male', '1967-10-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(697, 407, 'spouse', 'Paytocan', 'Virgie', 'Cabasoy', NULL, NULL, '1973-10-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(698, 408, 'head', 'Sacpa', 'Danny', 'Tugade', NULL, 'Male', '1951-11-25', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(699, 408, 'spouse', 'Sacpa', 'Linda', 'Juan', NULL, NULL, '1964-02-28', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(700, 409, 'head', 'Vicente', 'Ciony', 'Cabasoy', NULL, 'Female', '1974-11-04', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(701, 410, 'head', 'Alos', 'Madelio', 'Anggob', NULL, 'Male', '1991-07-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(702, 410, 'spouse', 'Alos', 'Rachelle Shane', 'Ramos', NULL, NULL, '1999-04-07', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(703, 411, 'head', 'Reyes', 'Marlon', 'Padua', NULL, 'Male', '1980-02-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(704, 411, 'spouse', 'Purdos', 'Thelma', 'Tumbed', NULL, NULL, '1976-01-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(705, 412, 'head', 'Aguda', 'Norvie', 'Maruquin', NULL, 'Female', '1997-11-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(706, 412, 'spouse', 'Sabadao', 'Babelyn', 'Agtang', NULL, NULL, '1998-09-20', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(707, 413, 'head', 'Autriz', 'Anabella', 'Dalog', NULL, 'Female', '1958-06-09', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(708, 413, 'spouse', 'Autriz', 'Ely', 'Nieto', NULL, NULL, '1958-09-05', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(709, 414, 'head', 'Autriz', 'Alwin', 'Dalog', NULL, 'Male', '1995-04-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(710, 414, 'spouse', 'Autriz', 'Jaevemae', 'Padilla', NULL, NULL, '1994-10-24', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(711, 415, 'head', 'Autriz', 'Edmon', 'Dalog', NULL, 'Male', '1993-05-15', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(712, 415, 'spouse', 'Autriz', 'Mercy', 'Baging', NULL, NULL, '1995-03-07', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(713, 416, 'head', 'Bataan', 'May-ann', 'Gullayan', NULL, 'Female', '1998-05-14', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(714, 417, 'head', 'Dalog', 'Rizza May', 'Sabado', NULL, 'Female', '1993-05-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(715, 417, 'spouse', 'Agtang', 'Joffrey', NULL, NULL, NULL, '1997-04-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(716, 418, 'head', 'Domingo', 'Joseph', 'Alos', NULL, 'Male', '1994-01-23', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(717, 418, 'spouse', 'Domingo', 'Jessamine', 'Manggay', NULL, NULL, '1992-01-30', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(718, 419, 'head', 'Dudoc', 'Richmon', 'Tomas', NULL, 'Male', '1997-03-10', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(719, 419, 'spouse', 'Agcaoili', 'Gemma', 'Domingo', NULL, NULL, '1996-08-06', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(720, 420, 'head', 'Gullayan', 'Ronalyn', 'Banaba', NULL, 'Male', '1977-10-12', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(721, 421, 'head', 'Abian', 'Argay', 'Aguda', NULL, 'Male', '1995-01-13', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(722, 421, 'spouse', 'Abian', 'Marie Rose', 'Panabang', NULL, NULL, '1999-10-17', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(723, 422, 'head', 'Banaba', 'John Paul', 'Aguda', NULL, 'Male', '1998-01-01', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(724, 422, 'spouse', 'Bayubay', 'Myra', 'Banglas', NULL, NULL, '2002-01-08', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(725, 423, 'head', 'Dumalan', 'Gerald', 'Manggay', NULL, 'Male', NULL, '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(726, 424, 'head', 'Banaba', 'Romel', 'Alayao', NULL, 'Male', '1991-07-16', '2026-08-22 12:38:48', '2026-08-22 12:38:48'),
(727, 424, 'spouse', 'Madrid', 'Rosanna', 'Estal', NULL, NULL, '1989-01-11', '2026-08-22 12:38:48', '2026-08-22 12:38:48');

-- --------------------------------------------------------

--
-- Table structure for table `ip_land_parcels`
--

CREATE TABLE `ip_land_parcels` (
  `id` int(11) NOT NULL,
  `land_name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `barangay` varchar(100) DEFAULT NULL,
  `municipality` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `boundary_geojson` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`boundary_geojson`)),
  `owner_name` varchar(255) DEFAULT NULL,
  `owner_type` enum('ip_individual','ip_family','non_ip','community','government') DEFAULT 'ip_individual',
  `ownership_status` enum('claimed','verified','disputed','government_owned') DEFAULT 'claimed',
  `ownership_document` varchar(255) DEFAULT NULL,
  `status` enum('active','inactive','verified') DEFAULT 'active',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ip_records`
--

CREATE TABLE `ip_records` (
  `id` int(11) NOT NULL,
  `reference_code` varchar(50) DEFAULT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `sitio` varchar(150) DEFAULT NULL,
  `barangay` varchar(150) DEFAULT NULL,
  `municipality` varchar(150) DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `tribe` varchar(100) DEFAULT NULL,
  `affiliation_id` int(10) UNSIGNED DEFAULT NULL,
  `family_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `status` enum('draft','for_assessment','for_approval','approved','rejected') DEFAULT 'draft',
  `remarks` text DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `attempt_key` char(64) NOT NULL,
  `attempt_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `window_started_at` datetime NOT NULL,
  `last_attempt_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property_types`
--

CREATE TABLE `property_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property_types`
--

INSERT INTO `property_types` (`id`, `code`, `name`, `status`) VALUES
(1, 'land', 'Land', 'active'),
(2, 'building', 'Building', 'active'),
(3, 'machinery', 'Machinery', 'active'),
(4, 'other', 'Others', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `system_settings`
--

INSERT INTO `system_settings` (`setting_key`, `setting_value`, `updated_by`, `updated_at`) VALUES
('logo_path', 'assets/images/logo.png', 1, '2026-08-27 13:24:23'),
('theme_accent', '#198754', 1, '2026-08-27 13:23:37'),
('theme_primary', '#177135', 1, '2026-08-27 13:23:37'),
('theme_sidebar', '#163820', 1, '2026-08-27 13:23:37');

-- --------------------------------------------------------

--
-- Table structure for table `tax_declarations`
--

CREATE TABLE `tax_declarations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `td_number` varchar(100) NOT NULL,
  `pin` varchar(100) DEFAULT NULL,
  `owning_tribe` varchar(150) NOT NULL COMMENT 'Operational authorization scope; not owner identity',
  `owner_name` varchar(255) NOT NULL,
  `owner_tin` varchar(50) DEFAULT NULL,
  `owner_address` text DEFAULT NULL,
  `owner_phone` varchar(30) DEFAULT NULL,
  `administrator_name` varchar(255) DEFAULT NULL,
  `administrator_tin` varchar(50) DEFAULT NULL,
  `administrator_address` text DEFAULT NULL,
  `administrator_phone` varchar(30) DEFAULT NULL,
  `location_street` varchar(200) DEFAULT NULL,
  `location_barangay` varchar(150) DEFAULT NULL,
  `location_municipality_province_city` varchar(255) DEFAULT NULL,
  `title_number` varchar(150) DEFAULT NULL,
  `cct` varchar(100) DEFAULT NULL,
  `title_date` date DEFAULT NULL,
  `survey_number` varchar(100) DEFAULT NULL,
  `lot_number` varchar(100) DEFAULT NULL,
  `block_number` varchar(100) DEFAULT NULL,
  `boundary_north` text DEFAULT NULL,
  `boundary_south` text DEFAULT NULL,
  `boundary_east` text DEFAULT NULL,
  `boundary_west` text DEFAULT NULL,
  `property_type_id` int(10) UNSIGNED DEFAULT NULL,
  `number_of_storeys` smallint(5) UNSIGNED DEFAULT NULL,
  `brief_description` text DEFAULT NULL,
  `other_property_specify` varchar(255) DEFAULT NULL,
  `total_area_sqm` decimal(18,4) DEFAULT NULL,
  `total_market_value` decimal(18,2) DEFAULT NULL,
  `total_assessed_value` decimal(18,2) DEFAULT NULL,
  `total_assessed_value_words` text DEFAULT NULL,
  `tax_status` enum('taxable','exempt') DEFAULT NULL,
  `effectivity_quarter` tinyint(3) UNSIGNED DEFAULT NULL,
  `effectivity_year` smallint(5) UNSIGNED DEFAULT NULL,
  `approved_by` varchar(255) DEFAULT NULL,
  `approver_position` varchar(150) DEFAULT NULL,
  `approval_date` date DEFAULT NULL,
  `previous_td_arp_number` varchar(100) DEFAULT NULL,
  `previous_owner` varchar(255) DEFAULT NULL,
  `previous_assessed_value` decimal(18,2) DEFAULT NULL,
  `previous_tax_declaration_id` bigint(20) UNSIGNED DEFAULT NULL,
  `memoranda` text DEFAULT NULL,
  `parcel_id` int(11) DEFAULT NULL,
  `owner_ip_record_id` int(11) DEFAULT NULL,
  `owner_family_member_id` bigint(20) UNSIGNED DEFAULT NULL,
  `owner_family_id` bigint(20) UNSIGNED DEFAULT NULL,
  `declaration_status` enum('current','historical','cancelled') NOT NULL DEFAULT 'current',
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_declaration_assessments`
--

CREATE TABLE `tax_declaration_assessments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tax_declaration_id` bigint(20) UNSIGNED NOT NULL,
  `classification` varchar(150) DEFAULT NULL,
  `area_sqm` decimal(18,4) DEFAULT NULL,
  `market_value` decimal(18,2) DEFAULT NULL,
  `actual_use` varchar(150) DEFAULT NULL,
  `assessment_level_percent` decimal(5,2) DEFAULT NULL,
  `assessed_value` decimal(18,2) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ;

-- --------------------------------------------------------

--
-- Table structure for table `tax_declaration_attachments`
--

CREATE TABLE `tax_declaration_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tax_declaration_id` bigint(20) UNSIGNED NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `uploaded_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','tribe_leader','assessor','staff','tribe_rep') NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `contact_number` varchar(30) DEFAULT NULL,
  `status` enum('active','inactive','suspended') DEFAULT 'active',
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `full_name`, `contact_number`, `status`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'harvzrpv@gmail.com', '$2y$10$SYKe3pBwX8AI3lPi738yxO/hwa6awb.FkCPYtCl7dlju5hrKs0kJq', 'admin', 'Harvy Raphael Virocel', '09946443017', 'active', '2026-08-27 20:50:43', '2026-06-07 08:52:26', '2026-08-27 13:29:04'),
(9, 'juan.dc', 'juandelacruz@example.com', '$2y$10$iSfl0YiIDptrEUvI4R3UZ.lxONxLXbfGtN8irA4W/DoTS9nsJdfA6', 'tribe_leader', 'Juan Dela Cruz', '09000000010', 'active', NULL, '2026-08-22 12:34:40', '2026-08-27 13:20:58'),
(10, 'gabriel.inayat', 'gabriel@example.com', '$2y$10$rPEj9kyomwqvkY6pLcgB8OjlKi25ra3gJ1U3IIKDvtRwuS4e9bpCK', 'tribe_rep', 'Gabriel Joseph D. Inayat', '09000000011', 'active', NULL, '2026-08-22 12:36:01', '2026-08-22 12:36:01'),
(11, 'hero.mapispisi', 'hero@example.com', '$2y$10$j/i1qvweL7HgZo/SkKtSOOMDRA2YBl663PrpXktCrBVz7kWJQZf8S', 'assessor', 'Hero R. Mapispisi', '09000000012', 'active', NULL, '2026-08-22 12:37:58', '2026-08-27 13:20:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_tribes`
--

CREATE TABLE `user_tribes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tribe` varchar(150) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_tribes`
--

INSERT INTO `user_tribes` (`id`, `user_id`, `tribe`, `created_at`) VALUES
(1, 9, 'Yapayao', '2026-08-22 12:34:40'),
(2, 10, 'Yapayao', '2026-08-22 12:36:01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_audit_created` (`created_at`),
  ADD KEY `idx_audit_action_created` (`action`,`created_at`),
  ADD KEY `fk_audit_user` (`user_id`);

--
-- Indexes for table `case_applications`
--
ALTER TABLE `case_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_cases_group_assignment_created` (`applicant_ip_group`,`assigned_to`,`created_at`),
  ADD KEY `idx_cases_status_created` (`status`,`created_at`),
  ADD KEY `idx_cases_created_by` (`created_by`),
  ADD KEY `idx_cases_applicant_affiliation` (`applicant_affiliation_id`),
  ADD KEY `idx_cases_case_type_id` (`case_type_id`);

--
-- Indexes for table `case_attachments`
--
ALTER TABLE `case_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_case_attachments_case` (`case_id`),
  ADD KEY `idx_attachments_uploaded_by` (`uploaded_by`);

--
-- Indexes for table `case_persons_involved`
--
ALTER TABLE `case_persons_involved`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_case_persons_case` (`case_id`),
  ADD KEY `idx_case_persons_family_member` (`family_member_id`),
  ADD KEY `idx_case_persons_affiliation` (`affiliation_id`),
  ADD KEY `idx_case_persons_ip_record` (`ip_record_id`);

--
-- Indexes for table `case_tax_declarations`
--
ALTER TABLE `case_tax_declarations`
  ADD PRIMARY KEY (`case_id`,`tax_declaration_id`),
  ADD KEY `fk_case_tax_td` (`tax_declaration_id`),
  ADD KEY `fk_case_tax_creator` (`created_by`);

--
-- Indexes for table `case_types`
--
ALTER TABLE `case_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_case_types_code` (`code`);

--
-- Indexes for table `import_batches`
--
ALTER TABLE `import_batches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_import_batches_source_hash` (`source_hash`),
  ADD KEY `idx_import_batches_status_created` (`status`,`created_at`),
  ADD KEY `idx_import_batches_created_by` (`created_by`);

--
-- Indexes for table `ip_affiliations`
--
ALTER TABLE `ip_affiliations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ip_affiliations_code` (`code`),
  ADD UNIQUE KEY `uq_ip_affiliations_name` (`name`);

--
-- Indexes for table `ip_families`
--
ALTER TABLE `ip_families`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ip_families_family_reference` (`family_reference`),
  ADD UNIQUE KEY `uq_ip_families_batch_source` (`import_batch_id`,`source_reference`),
  ADD KEY `idx_ip_families_affiliation` (`affiliation_id`),
  ADD KEY `idx_ip_families_owning_tribe` (`owning_tribe`),
  ADD KEY `idx_ip_families_location` (`municipality_city`,`barangay`),
  ADD KEY `idx_ip_families_created_by` (`created_by`),
  ADD KEY `idx_ip_families_updated_by` (`updated_by`);

--
-- Indexes for table `ip_family_members`
--
ALTER TABLE `ip_family_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_ip_family_members_family_role` (`family_id`,`member_role`),
  ADD KEY `idx_ip_family_members_name` (`last_name`,`first_name`);

--
-- Indexes for table `ip_land_parcels`
--
ALTER TABLE `ip_land_parcels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `barangay` (`barangay`),
  ADD KEY `municipality` (`municipality`),
  ADD KEY `status` (`status`),
  ADD KEY `owner_type` (`owner_type`),
  ADD KEY `ownership_status` (`ownership_status`),
  ADD KEY `fk_parcels_created_by` (`created_by`),
  ADD KEY `fk_parcels_updated_by` (`updated_by`);

--
-- Indexes for table `ip_records`
--
ALTER TABLE `ip_records`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference_code` (`reference_code`),
  ADD UNIQUE KEY `uq_ip_records_family_member` (`family_member_id`),
  ADD KEY `idx_records_tribe_status_created` (`tribe`,`status`,`created_at`),
  ADD KEY `idx_records_created_by` (`created_by`),
  ADD KEY `fk_records_approved_by` (`approved_by`),
  ADD KEY `idx_ip_records_affiliation` (`affiliation_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`attempt_key`),
  ADD KEY `idx_login_attempts_last` (`last_attempt_at`);

--
-- Indexes for table `property_types`
--
ALTER TABLE `property_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_property_types_code` (`code`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_key`),
  ADD KEY `idx_settings_updated_by` (`updated_by`);

--
-- Indexes for table `tax_declarations`
--
ALTER TABLE `tax_declarations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_tax_declarations_td_number` (`td_number`),
  ADD KEY `idx_tax_owner` (`owner_name`),
  ADD KEY `idx_tax_location` (`location_barangay`),
  ADD KEY `idx_tax_scope` (`owning_tribe`),
  ADD KEY `idx_tax_parcel` (`parcel_id`),
  ADD KEY `fk_tax_property_type` (`property_type_id`),
  ADD KEY `fk_tax_previous` (`previous_tax_declaration_id`),
  ADD KEY `fk_tax_owner_ip` (`owner_ip_record_id`),
  ADD KEY `fk_tax_owner_member` (`owner_family_member_id`),
  ADD KEY `fk_tax_owner_family` (`owner_family_id`),
  ADD KEY `fk_tax_created_by` (`created_by`),
  ADD KEY `fk_tax_updated_by` (`updated_by`);

--
-- Indexes for table `tax_declaration_assessments`
--
ALTER TABLE `tax_declaration_assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tax_assessment_parent` (`tax_declaration_id`);

--
-- Indexes for table `tax_declaration_attachments`
--
ALTER TABLE `tax_declaration_attachments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_tax_attachment_parent` (`tax_declaration_id`),
  ADD KEY `fk_tax_attachment_user` (`uploaded_by`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `user_tribes`
--
ALTER TABLE `user_tribes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_user_tribes_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `case_applications`
--
ALTER TABLE `case_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `case_attachments`
--
ALTER TABLE `case_attachments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `case_persons_involved`
--
ALTER TABLE `case_persons_involved`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `case_types`
--
ALTER TABLE `case_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `import_batches`
--
ALTER TABLE `import_batches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `ip_affiliations`
--
ALTER TABLE `ip_affiliations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ip_families`
--
ALTER TABLE `ip_families`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=425;

--
-- AUTO_INCREMENT for table `ip_family_members`
--
ALTER TABLE `ip_family_members`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=728;

--
-- AUTO_INCREMENT for table `ip_land_parcels`
--
ALTER TABLE `ip_land_parcels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ip_records`
--
ALTER TABLE `ip_records`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property_types`
--
ALTER TABLE `property_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tax_declarations`
--
ALTER TABLE `tax_declarations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_declaration_assessments`
--
ALTER TABLE `tax_declaration_assessments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_declaration_attachments`
--
ALTER TABLE `tax_declaration_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `user_tribes`
--
ALTER TABLE `user_tribes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD CONSTRAINT `fk_audit_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_applications`
--
ALTER TABLE `case_applications`
  ADD CONSTRAINT `fk_cases_applicant_affiliation` FOREIGN KEY (`applicant_affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cases_case_type` FOREIGN KEY (`case_type_id`) REFERENCES `case_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_cases_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_attachments`
--
ALTER TABLE `case_attachments`
  ADD CONSTRAINT `fk_attachments_uploaded_by` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_case_attachments_case` FOREIGN KEY (`case_id`) REFERENCES `case_applications` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `case_persons_involved`
--
ALTER TABLE `case_persons_involved`
  ADD CONSTRAINT `fk_case_persons_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_case_persons_case` FOREIGN KEY (`case_id`) REFERENCES `case_applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_case_persons_family_member` FOREIGN KEY (`family_member_id`) REFERENCES `ip_family_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_case_persons_ip_record` FOREIGN KEY (`ip_record_id`) REFERENCES `ip_records` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `case_tax_declarations`
--
ALTER TABLE `case_tax_declarations`
  ADD CONSTRAINT `fk_case_tax_case` FOREIGN KEY (`case_id`) REFERENCES `case_applications` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_case_tax_creator` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_case_tax_td` FOREIGN KEY (`tax_declaration_id`) REFERENCES `tax_declarations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `import_batches`
--
ALTER TABLE `import_batches`
  ADD CONSTRAINT `fk_import_batches_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ip_families`
--
ALTER TABLE `ip_families`
  ADD CONSTRAINT `fk_ip_families_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ip_families_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ip_families_import_batch` FOREIGN KEY (`import_batch_id`) REFERENCES `import_batches` (`id`),
  ADD CONSTRAINT `fk_ip_families_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ip_family_members`
--
ALTER TABLE `ip_family_members`
  ADD CONSTRAINT `fk_ip_family_members_family` FOREIGN KEY (`family_id`) REFERENCES `ip_families` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ip_land_parcels`
--
ALTER TABLE `ip_land_parcels`
  ADD CONSTRAINT `fk_parcels_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_parcels_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `ip_records`
--
ALTER TABLE `ip_records`
  ADD CONSTRAINT `fk_ip_records_affiliation` FOREIGN KEY (`affiliation_id`) REFERENCES `ip_affiliations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_ip_records_family_member` FOREIGN KEY (`family_member_id`) REFERENCES `ip_family_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_records_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_records_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD CONSTRAINT `fk_settings_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `tax_declarations`
--
ALTER TABLE `tax_declarations`
  ADD CONSTRAINT `fk_tax_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_owner_family` FOREIGN KEY (`owner_family_id`) REFERENCES `ip_families` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_owner_ip` FOREIGN KEY (`owner_ip_record_id`) REFERENCES `ip_records` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_owner_member` FOREIGN KEY (`owner_family_member_id`) REFERENCES `ip_family_members` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_parcel` FOREIGN KEY (`parcel_id`) REFERENCES `ip_land_parcels` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_previous` FOREIGN KEY (`previous_tax_declaration_id`) REFERENCES `tax_declarations` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_property_type` FOREIGN KEY (`property_type_id`) REFERENCES `property_types` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_tax_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `tax_declaration_assessments`
--
ALTER TABLE `tax_declaration_assessments`
  ADD CONSTRAINT `fk_tax_assessment_parent` FOREIGN KEY (`tax_declaration_id`) REFERENCES `tax_declarations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tax_declaration_attachments`
--
ALTER TABLE `tax_declaration_attachments`
  ADD CONSTRAINT `fk_tax_attachment_parent` FOREIGN KEY (`tax_declaration_id`) REFERENCES `tax_declarations` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tax_attachment_user` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `user_tribes`
--
ALTER TABLE `user_tribes`
  ADD CONSTRAINT `user_tribes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
