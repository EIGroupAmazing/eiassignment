-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 30, 2015 at 02:47 PM
-- Server version: 5.6.12-log
-- PHP Version: 5.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `customer_info`
--
CREATE DATABASE IF NOT EXISTS `customer_info` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `customer_info`;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_ID` varchar(40) NOT NULL,
  `phoneNumber` int(8) NOT NULL,
  `email` varchar(40) NOT NULL,
  PRIMARY KEY (`customer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_ID`, `phoneNumber`, `email`) VALUES
('czyang', 83124760, 'czyang.2013@sis.smu.edu.sg'),
('jj', 91168952, 'minjeon.je.2013@sis.smu.edu.sg'),
('luning', 83572238, 'ninglu.2013@sis.smu.edu.sg'),
('yuxuan', 85225105, 'yx.yuan.2013@sis.smu.edu.sg');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE IF NOT EXISTS `order` (
  `Customer_id` varchar(40) NOT NULL,
  `Time_generated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `restaurant_name` varchar(40) NOT NULL,
  PRIMARY KEY (`Customer_id`,`Time_generated`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`Customer_id`, `Time_generated`, `restaurant_name`) VALUES
('jj', '2015-03-30 11:26:13', 'KFC@Dhoby Ghaut'),
('luning', '2015-03-27 07:50:55', 'Popeyes Louisiana Kitchen (The Cathay)'),
('luning', '2015-03-30 11:24:44', '4fingers@plaza singapura'),
('luning', '2015-03-30 11:24:53', '4fingers@plaza singapura'),
('luning', '2015-03-30 11:25:02', '4fingers@plaza singapura'),
('luning', '2015-03-30 11:26:18', 'KFC@Dhoby Ghaut'),
('luning', '2015-03-30 14:11:41', 'Subway@Suntec City'),
('luning', '2015-03-30 14:11:44', 'Subway@Suntec City'),
('yuxuan', '2015-03-09 19:00:00', 'McDonald''s Suntec City'),
('yuxuan', '2015-03-30 11:23:53', 'Subway@Suntec City ');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`customer_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
