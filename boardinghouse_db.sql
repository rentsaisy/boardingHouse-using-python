-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 05, 2026 at 05:43 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `boardinghouse_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `m_facility`
--

CREATE TABLE `m_facility` (
  `facility_id` int NOT NULL,
  `room_id` int DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `condition` varchar(50) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `m_room`
--

CREATE TABLE `m_room` (
  `room_id` int NOT NULL,
  `room_number` varchar(10) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `m_room`
--

INSERT INTO `m_room` (`room_id`, `room_number`, `type`, `price`, `status`) VALUES
(1, 'B13', 'Single', 750000.00, 'Occupied');

-- --------------------------------------------------------

--
-- Table structure for table `m_tenant`
--

CREATE TABLE `m_tenant` (
  `tenant_id` int NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `emergency_contact` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `m_tenant`
--

INSERT INTO `m_tenant` (`tenant_id`, `name`, `phone`, `address`, `emergency_contact`) VALUES
(1, 'Aisyah', '08968035666', 'Trenggalek', '08111111111');

-- --------------------------------------------------------

--
-- Table structure for table `r_history`
--

CREATE TABLE `r_history` (
  `report_id` int NOT NULL,
  `tenant_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `payment_id` int DEFAULT NULL,
  `report_date` date DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `t_payment`
--

CREATE TABLE `t_payment` (
  `payment_id` int NOT NULL,
  `tenant_id` int DEFAULT NULL,
  `room_id` int DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `payment_date` date DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `t_payment`
--

INSERT INTO `t_payment` (`payment_id`, `tenant_id`, `room_id`, `amount`, `payment_date`, `status`) VALUES
(1, 1, 1, 750000.00, '2026-06-01', 'Paid');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `m_facility`
--
ALTER TABLE `m_facility`
  ADD PRIMARY KEY (`facility_id`),
  ADD KEY `room_id` (`room_id`);

--
-- Indexes for table `m_room`
--
ALTER TABLE `m_room`
  ADD PRIMARY KEY (`room_id`);

--
-- Indexes for table `m_tenant`
--
ALTER TABLE `m_tenant`
  ADD PRIMARY KEY (`tenant_id`);

--
-- Indexes for table `r_history`
--
ALTER TABLE `r_history`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `room_id` (`room_id`),
  ADD KEY `payment_id` (`payment_id`);

--
-- Indexes for table `t_payment`
--
ALTER TABLE `t_payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `tenant_id` (`tenant_id`),
  ADD KEY `room_id` (`room_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `m_facility`
--
ALTER TABLE `m_facility`
  MODIFY `facility_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `m_room`
--
ALTER TABLE `m_room`
  MODIFY `room_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `m_tenant`
--
ALTER TABLE `m_tenant`
  MODIFY `tenant_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `r_history`
--
ALTER TABLE `r_history`
  MODIFY `report_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `t_payment`
--
ALTER TABLE `t_payment`
  MODIFY `payment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `m_facility`
--
ALTER TABLE `m_facility`
  ADD CONSTRAINT `m_facility_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `m_room` (`room_id`);

--
-- Constraints for table `r_history`
--
ALTER TABLE `r_history`
  ADD CONSTRAINT `r_history_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `m_tenant` (`tenant_id`),
  ADD CONSTRAINT `r_history_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `m_room` (`room_id`),
  ADD CONSTRAINT `r_history_ibfk_3` FOREIGN KEY (`payment_id`) REFERENCES `t_payment` (`payment_id`);

--
-- Constraints for table `t_payment`
--
ALTER TABLE `t_payment`
  ADD CONSTRAINT `t_payment_ibfk_1` FOREIGN KEY (`tenant_id`) REFERENCES `m_tenant` (`tenant_id`),
  ADD CONSTRAINT `t_payment_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `m_room` (`room_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
