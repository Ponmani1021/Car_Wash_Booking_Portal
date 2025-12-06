-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 04, 2025 at 08:43 AM
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
-- Database: `carwashportal_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add announcement', 7, 'add_announcement'),
(26, 'Can change announcement', 7, 'change_announcement'),
(27, 'Can delete announcement', 7, 'delete_announcement'),
(28, 'Can view announcement', 7, 'view_announcement'),
(29, 'Can add booking', 8, 'add_booking'),
(30, 'Can change booking', 8, 'change_booking'),
(31, 'Can delete booking', 8, 'delete_booking'),
(32, 'Can view booking', 8, 'view_booking'),
(33, 'Can add customer profile', 9, 'add_customerprofile'),
(34, 'Can change customer profile', 9, 'change_customerprofile'),
(35, 'Can delete customer profile', 9, 'delete_customerprofile'),
(36, 'Can view customer profile', 9, 'view_customerprofile'),
(37, 'Can add vehicle type', 10, 'add_vehicletype'),
(38, 'Can change vehicle type', 10, 'change_vehicletype'),
(39, 'Can delete vehicle type', 10, 'delete_vehicletype'),
(40, 'Can view vehicle type', 10, 'view_vehicletype'),
(41, 'Can add washer profile', 11, 'add_washerprofile'),
(42, 'Can change washer profile', 11, 'change_washerprofile'),
(43, 'Can delete washer profile', 11, 'delete_washerprofile'),
(44, 'Can view washer profile', 11, 'view_washerprofile'),
(45, 'Can add washer company', 12, 'add_washercompany'),
(46, 'Can change washer company', 12, 'change_washercompany'),
(47, 'Can delete washer company', 12, 'delete_washercompany'),
(48, 'Can view washer company', 12, 'view_washercompany'),
(49, 'Can add vehicle sub type', 13, 'add_vehiclesubtype'),
(50, 'Can change vehicle sub type', 13, 'change_vehiclesubtype'),
(51, 'Can delete vehicle sub type', 13, 'delete_vehiclesubtype'),
(52, 'Can view vehicle sub type', 13, 'view_vehiclesubtype'),
(53, 'Can add profile', 14, 'add_profile'),
(54, 'Can change profile', 14, 'change_profile'),
(55, 'Can delete profile', 14, 'delete_profile'),
(56, 'Can view profile', 14, 'view_profile'),
(57, 'Can add feedback', 15, 'add_feedback'),
(58, 'Can change feedback', 15, 'change_feedback'),
(59, 'Can delete feedback', 15, 'delete_feedback'),
(60, 'Can view feedback', 15, 'view_feedback'),
(61, 'Can add booking cost details', 16, 'add_bookingcostdetails'),
(62, 'Can change booking cost details', 16, 'change_bookingcostdetails'),
(63, 'Can delete booking cost details', 16, 'delete_bookingcostdetails'),
(64, 'Can view booking cost details', 16, 'view_bookingcostdetails');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$d59KRpC2o39Fi6IfRRfqNP$zt662POzovzfIbWILEQqby6giD4C5l0PDLSlSz3TjIc=', '2025-12-04 07:30:05.378045', 0, 'admin', '', '', '', 0, 1, '2025-12-04 07:06:17.653960'),
(2, 'pbkdf2_sha256$600000$DQpfsQnuW4GGJZWmPUW3dd$uKoToiNfgShrvEm6pu8bqrqfoDBb175gWhHqJ7V4Yfw=', '2025-12-04 07:27:11.519006', 0, 'MITHRA', 'Mithra', '', 'mithra123@gmail.com', 0, 1, '2025-12-04 07:07:11.230786'),
(3, 'pbkdf2_sha256$600000$pfetiQsh0JkqOE7oVgMiQo$+7DAwngjKnVJCp5HLOObg7XyWwx92pj7skP+lQADrvY=', '2025-12-04 07:29:10.470413', 0, 'VARSHINI', 'varshini', '', 'varshini123@gmail.com', 0, 1, '2025-12-04 07:13:00.681680'),
(4, 'pbkdf2_sha256$600000$ods7biUEk8tH2sxeSUYvLa$h2zHrjwAi2jzw5G3JSsnjXLB4GyxOkcY32IORpPyoJo=', '2025-12-04 07:23:46.131367', 0, 'KAVI', 'kavi', '', 'kavi123@gmail.com', 0, 1, '2025-12-04 07:17:23.331880'),
(5, 'pbkdf2_sha256$600000$phdtp3RRMtWnjKZ53731qy$3e9MQsXEAY+XL1JOoT9sxsxLp9EJTsqY5rKtF/lHkIM=', '2025-12-04 07:28:37.323130', 0, 'SUBI', 'subi', '', 'subideepam@gmail.com', 0, 1, '2025-12-04 07:20:31.868740');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_announcement`
--

CREATE TABLE `carwashbooking_announcement` (
  `id` bigint(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_booking`
--

CREATE TABLE `carwashbooking_booking` (
  `id` bigint(20) NOT NULL,
  `vehicle_type` varchar(100) NOT NULL,
  `subtype` varchar(100) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `pickup_drop` tinyint(1) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time(6) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `total_cost` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `washer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_booking`
--

INSERT INTO `carwashbooking_booking` (`id`, `vehicle_type`, `subtype`, `cost`, `pickup_drop`, `date`, `time`, `address`, `total_cost`, `status`, `created_at`, `customer_id`, `washer_id`) VALUES
(1, 'two_wheeler', 'Sports Bike', 200.00, 1, '2025-12-05', '16:00:00.000000', '4/620, vengamedu bus stop, Tiruppur', 300.00, 'cancelled', '2025-12-04 07:18:36.674450', 4, 3),
(2, 'two_wheeler', 'Scooter', 100.00, 1, '2025-12-06', '17:00:00.000000', 'Vengamedu bus stop, Tirupur', 200.00, 'accepted', '2025-12-04 07:19:52.811004', 4, 3),
(3, 'bus', 'School/College Bus', 1800.00, 1, '2025-12-14', '16:00:00.000000', 'KHV School , Tiruppu', 1900.00, 'rejected', '2025-12-04 07:25:57.623601', 2, 5),
(4, 'bus', 'School/College Bus', 1800.00, 1, '2025-12-15', '17:00:00.000000', 'KVH School, poondi, Tiruppur', 1900.00, 'completed', '2025-12-04 07:28:14.984928', 2, 5);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_bookingcostdetails`
--

CREATE TABLE `carwashbooking_bookingcostdetails` (
  `id` bigint(20) NOT NULL,
  `vehicle_type` varchar(30) NOT NULL,
  `subtype` varchar(120) DEFAULT NULL,
  `cost` decimal(8,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `washer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_bookingcostdetails`
--

INSERT INTO `carwashbooking_bookingcostdetails` (`id`, `vehicle_type`, `subtype`, `cost`, `created_at`, `washer_id`) VALUES
(1, 'two_wheeler', 'Scooter', 100.00, '2025-12-04 07:14:20.133269', 3),
(2, 'two_wheeler', 'Sports Bike', 200.00, '2025-12-04 07:14:29.005372', 3),
(3, 'two_wheeler', 'Commuter', 300.00, '2025-12-04 07:14:37.265096', 3),
(4, 'four_wheeler', 'Hatchback', 500.00, '2025-12-04 07:14:44.385574', 3),
(5, 'four_wheeler', 'Sedan', 600.00, '2025-12-04 07:14:52.473622', 3),
(7, 'four_wheeler', 'SUV', 700.00, '2025-12-04 07:15:36.064440', 3),
(8, 'bus', 'Travel Bus', 1000.00, '2025-12-04 07:15:46.698154', 3),
(9, 'bus', 'School/College Bus', 1300.00, '2025-12-04 07:15:56.237279', 3),
(10, 'bus', 'Van', 1800.00, '2025-12-04 07:16:06.990968', 3),
(11, 'heavy_vehicle', 'Truck', 2300.00, '2025-12-04 07:16:21.739270', 3),
(12, 'heavy_vehicle', 'Lorry', 2800.00, '2025-12-04 07:16:32.199924', 3),
(13, 'heavy_vehicle', 'Container', 3700.00, '2025-12-04 07:16:44.854839', 3),
(14, 'bus', 'Travel Bus', 1500.00, '2025-12-04 07:21:43.724805', 5),
(15, 'bus', 'School/College Bus', 1800.00, '2025-12-04 07:21:57.899484', 5),
(16, 'bus', 'Van', 2000.00, '2025-12-04 07:22:08.169698', 5);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_customerprofile`
--

CREATE TABLE `carwashbooking_customerprofile` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(150) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `contact_number` varchar(20) DEFAULT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_customerprofile`
--

INSERT INTO `carwashbooking_customerprofile` (`id`, `full_name`, `email`, `contact_number`, `profile_image`, `user_id`) VALUES
(1, 'Mithra', 'mithra123@gmail.com', '7893214560', 'customer_profiles/doll.jpg', 2),
(2, 'kavi', 'kavi123@gmail.com', '1593571230', 'customer_profiles/girl2.jpg', 4);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_feedback`
--

CREATE TABLE `carwashbooking_feedback` (
  `id` bigint(20) NOT NULL,
  `description` longtext NOT NULL,
  `stars` int(11) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `booking_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `washer_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_feedback`
--

INSERT INTO `carwashbooking_feedback` (`id`, `description`, `stars`, `created_at`, `booking_id`, `customer_id`, `washer_id`) VALUES
(1, 'Accepted very quick And my vehicle has been picked up safely', 4, '2025-12-04 07:24:35.500577', NULL, 2, 1),
(2, 'My booking is got rejected', 1, '2025-12-04 07:27:35.920620', NULL, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_profile`
--

CREATE TABLE `carwashbooking_profile` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(254) NOT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `role` varchar(20) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_profile`
--

INSERT INTO `carwashbooking_profile` (`id`, `full_name`, `email`, `contact_number`, `role`, `user_id`) VALUES
(1, 'Admin', '', '', 'admin', 1),
(2, 'Mithra', 'mithra123@gmail.com', '7893214560', 'customer', 2),
(3, 'varshini', 'varshini123@gmail.com', '99448444444', 'washer', 3),
(4, 'kavi', 'kavi123@gmail.com', '1593571230', 'customer', 4),
(5, 'subi', 'subideepam@gmail.com', '1234567890', 'washer', 5);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_vehiclesubtype`
--

CREATE TABLE `carwashbooking_vehiclesubtype` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `cost` decimal(10,2) NOT NULL,
  `vehicle_type_id` bigint(20) NOT NULL,
  `washer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_vehicletype`
--

CREATE TABLE `carwashbooking_vehicletype` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_washercompany`
--

CREATE TABLE `carwashbooking_washercompany` (
  `id` bigint(20) NOT NULL,
  `company_name` varchar(200) NOT NULL,
  `company_address` varchar(300) DEFAULT NULL,
  `company_timings` varchar(120) DEFAULT NULL,
  `company_image` varchar(100) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `washer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_washercompany`
--

INSERT INTO `carwashbooking_washercompany` (`id`, `company_name`, `company_address`, `company_timings`, `company_image`, `description`, `washer_id`) VALUES
(1, 'varshini car wash company', 'chettipalayam, Tiruppur', '10.00 am - 09.00 pm', 'company_images/mush.jpg', 'Very good if you pick us', 3),
(2, 'subi Car wash ', 'Pudur, Tirupur', '12.00 pm to 12.00am', 'company_images/goa.avif', 'Premium Quality', 5);

-- --------------------------------------------------------

--
-- Table structure for table `carwashbooking_washerprofile`
--

CREATE TABLE `carwashbooking_washerprofile` (
  `id` bigint(20) NOT NULL,
  `full_name` varchar(120) DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `profile_image` varchar(100) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carwashbooking_washerprofile`
--

INSERT INTO `carwashbooking_washerprofile` (`id`, `full_name`, `contact_number`, `profile_image`, `user_id`) VALUES
(1, 'varshini', '99448444444', '', 3),
(2, 'subi', '1234567890', '', 5);

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(7, 'CarwashBooking', 'announcement'),
(8, 'CarwashBooking', 'booking'),
(16, 'CarwashBooking', 'bookingcostdetails'),
(9, 'CarwashBooking', 'customerprofile'),
(15, 'CarwashBooking', 'feedback'),
(14, 'CarwashBooking', 'profile'),
(13, 'CarwashBooking', 'vehiclesubtype'),
(10, 'CarwashBooking', 'vehicletype'),
(12, 'CarwashBooking', 'washercompany'),
(11, 'CarwashBooking', 'washerprofile'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-12-04 07:05:56.900232'),
(2, 'auth', '0001_initial', '2025-12-04 07:05:57.068821'),
(3, 'CarwashBooking', '0001_initial', '2025-12-04 07:05:57.304017'),
(4, 'CarwashBooking', '0002_alter_bookingcostdetails_washer', '2025-12-04 07:05:57.310467'),
(5, 'admin', '0001_initial', '2025-12-04 07:05:57.365394'),
(6, 'admin', '0002_logentry_remove_auto_add', '2025-12-04 07:05:57.375890'),
(7, 'admin', '0003_logentry_add_action_flag_choices', '2025-12-04 07:05:57.386236'),
(8, 'contenttypes', '0002_remove_content_type_name', '2025-12-04 07:05:57.418859'),
(9, 'auth', '0002_alter_permission_name_max_length', '2025-12-04 07:05:57.448692'),
(10, 'auth', '0003_alter_user_email_max_length', '2025-12-04 07:05:57.462639'),
(11, 'auth', '0004_alter_user_username_opts', '2025-12-04 07:05:57.474108'),
(12, 'auth', '0005_alter_user_last_login_null', '2025-12-04 07:05:57.505332'),
(13, 'auth', '0006_require_contenttypes_0002', '2025-12-04 07:05:57.511310'),
(14, 'auth', '0007_alter_validators_add_error_messages', '2025-12-04 07:05:57.519268'),
(15, 'auth', '0008_alter_user_username_max_length', '2025-12-04 07:05:57.532344'),
(16, 'auth', '0009_alter_user_last_name_max_length', '2025-12-04 07:05:57.544344'),
(17, 'auth', '0010_alter_group_name_max_length', '2025-12-04 07:05:57.567764'),
(18, 'auth', '0011_update_proxy_permissions', '2025-12-04 07:05:57.580532'),
(19, 'auth', '0012_alter_user_first_name_max_length', '2025-12-04 07:05:57.595968'),
(20, 'sessions', '0001_initial', '2025-12-04 07:05:57.610553');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('r68k5d3apmgsucjc7gmr3htu7guzm4go', '.eJxVjMsOwiAQRf-FtSHDU3Dp3m8gAwxSNZCUdmX8d9ukC92ec-59s4DrUsM6aA5TZhcm2OmXRUxParvID2z3zlNvyzxFvif8sIPfeqbX9Wj_DiqOuq0hOSARQUulwZFB7zUabQAjmLOXJBMYU0QshBksOuUsFuWkULgxyz5fxDE3iA:1vR3mv:HwQoWZ7Vv_FjUp5sxDfcbZE8sSjGt5icQMWj2TOpB2A', '2025-12-18 07:30:05.382219');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `carwashbooking_announcement`
--
ALTER TABLE `carwashbooking_announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carwashbooking_booking`
--
ALTER TABLE `carwashbooking_booking`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CarwashBooking_booking_customer_id_81b75cfb_fk_auth_user_id` (`customer_id`),
  ADD KEY `CarwashBooking_booking_washer_id_aba8eded_fk_auth_user_id` (`washer_id`);

--
-- Indexes for table `carwashbooking_bookingcostdetails`
--
ALTER TABLE `carwashbooking_bookingcostdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CarwashBooking_booki_washer_id_5e6db52f_fk_auth_user` (`washer_id`);

--
-- Indexes for table `carwashbooking_customerprofile`
--
ALTER TABLE `carwashbooking_customerprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `carwashbooking_feedback`
--
ALTER TABLE `carwashbooking_feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CarwashBooking_feedb_booking_id_c1e72d05_fk_CarwashBo` (`booking_id`),
  ADD KEY `CarwashBooking_feedb_customer_id_f17a4901_fk_CarwashBo` (`customer_id`),
  ADD KEY `CarwashBooking_feedb_washer_id_4ce06ced_fk_CarwashBo` (`washer_id`);

--
-- Indexes for table `carwashbooking_profile`
--
ALTER TABLE `carwashbooking_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `carwashbooking_vehiclesubtype`
--
ALTER TABLE `carwashbooking_vehiclesubtype`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CarwashBooking_vehic_vehicle_type_id_0eb95411_fk_CarwashBo` (`vehicle_type_id`),
  ADD KEY `CarwashBooking_vehiclesubtype_washer_id_df4896d9_fk_auth_user_id` (`washer_id`);

--
-- Indexes for table `carwashbooking_vehicletype`
--
ALTER TABLE `carwashbooking_vehicletype`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carwashbooking_washercompany`
--
ALTER TABLE `carwashbooking_washercompany`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `washer_id` (`washer_id`);

--
-- Indexes for table `carwashbooking_washerprofile`
--
ALTER TABLE `carwashbooking_washerprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carwashbooking_announcement`
--
ALTER TABLE `carwashbooking_announcement`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carwashbooking_booking`
--
ALTER TABLE `carwashbooking_booking`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `carwashbooking_bookingcostdetails`
--
ALTER TABLE `carwashbooking_bookingcostdetails`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `carwashbooking_customerprofile`
--
ALTER TABLE `carwashbooking_customerprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `carwashbooking_feedback`
--
ALTER TABLE `carwashbooking_feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `carwashbooking_profile`
--
ALTER TABLE `carwashbooking_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `carwashbooking_vehiclesubtype`
--
ALTER TABLE `carwashbooking_vehiclesubtype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carwashbooking_vehicletype`
--
ALTER TABLE `carwashbooking_vehicletype`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carwashbooking_washercompany`
--
ALTER TABLE `carwashbooking_washercompany`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `carwashbooking_washerprofile`
--
ALTER TABLE `carwashbooking_washerprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_booking`
--
ALTER TABLE `carwashbooking_booking`
  ADD CONSTRAINT `CarwashBooking_booking_customer_id_81b75cfb_fk_auth_user_id` FOREIGN KEY (`customer_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `CarwashBooking_booking_washer_id_aba8eded_fk_auth_user_id` FOREIGN KEY (`washer_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_bookingcostdetails`
--
ALTER TABLE `carwashbooking_bookingcostdetails`
  ADD CONSTRAINT `CarwashBooking_booki_washer_id_5e6db52f_fk_auth_user` FOREIGN KEY (`washer_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_customerprofile`
--
ALTER TABLE `carwashbooking_customerprofile`
  ADD CONSTRAINT `CarwashBooking_customerprofile_user_id_4a3f7521_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_feedback`
--
ALTER TABLE `carwashbooking_feedback`
  ADD CONSTRAINT `CarwashBooking_feedb_booking_id_c1e72d05_fk_CarwashBo` FOREIGN KEY (`booking_id`) REFERENCES `carwashbooking_booking` (`id`),
  ADD CONSTRAINT `CarwashBooking_feedb_customer_id_f17a4901_fk_CarwashBo` FOREIGN KEY (`customer_id`) REFERENCES `carwashbooking_customerprofile` (`id`),
  ADD CONSTRAINT `CarwashBooking_feedb_washer_id_4ce06ced_fk_CarwashBo` FOREIGN KEY (`washer_id`) REFERENCES `carwashbooking_washerprofile` (`id`);

--
-- Constraints for table `carwashbooking_profile`
--
ALTER TABLE `carwashbooking_profile`
  ADD CONSTRAINT `CarwashBooking_profile_user_id_2d0c8336_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_vehiclesubtype`
--
ALTER TABLE `carwashbooking_vehiclesubtype`
  ADD CONSTRAINT `CarwashBooking_vehic_vehicle_type_id_0eb95411_fk_CarwashBo` FOREIGN KEY (`vehicle_type_id`) REFERENCES `carwashbooking_vehicletype` (`id`),
  ADD CONSTRAINT `CarwashBooking_vehiclesubtype_washer_id_df4896d9_fk_auth_user_id` FOREIGN KEY (`washer_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_washercompany`
--
ALTER TABLE `carwashbooking_washercompany`
  ADD CONSTRAINT `CarwashBooking_washercompany_washer_id_c2a8ff34_fk_auth_user_id` FOREIGN KEY (`washer_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `carwashbooking_washerprofile`
--
ALTER TABLE `carwashbooking_washerprofile`
  ADD CONSTRAINT `CarwashBooking_washerprofile_user_id_de3f6c24_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
