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
-- Database: `restaurant_info`
--
CREATE DATABASE IF NOT EXISTS `restaurant_info` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `restaurant_info`;

-- --------------------------------------------------------

--
-- Table structure for table `deliveryscope`
--

CREATE TABLE IF NOT EXISTS `deliveryscope` (
  `restaurantName` varchar(40) NOT NULL,
  `region` varchar(40) NOT NULL,
  PRIMARY KEY (`restaurantName`,`region`),
  KEY `region` (`region`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deliveryscope`
--

INSERT INTO `deliveryscope` (`restaurantName`, `region`) VALUES
('KFC Upper Thomson', 'Bishan'),
('4fingers@plaza singapura', 'Kallang'),
('Burger King Burlington Square', 'Kallang'),
('KFC@Dhoby Ghaut', 'Kallang'),
('Mos Burger - HarbourFront Centre', 'Kallang'),
('Popeyes Louisiana Kitchen (The Cathay)', 'Kallang'),
('Sakae Sushi (Harbourfront Centre)', 'Kallang'),
('Subway@Suntec City', 'Kallang'),
('McDonald''s Suntec City', 'Novena'),
('PastaMania (United Square)', 'Novena'),
('Subway@Suntec City', 'Novena'),
('4fingers@plaza singapura', 'Rochor'),
('Burger King Burlington Square', 'Rochor'),
('KFC@Dhoby Ghaut', 'Rochor'),
('McDonald''s Suntec City', 'Rochor'),
('Mos Burger - HarbourFront Centre', 'Rochor'),
('PizzaHut@PlazaSingapura', 'Rochor'),
('Popeyes Louisiana Kitchen (The Cathay)', 'Rochor'),
('Subway@Suntec City', 'Rochor');

-- --------------------------------------------------------

--
-- Table structure for table `package`
--

CREATE TABLE IF NOT EXISTS `package` (
  `packageName` varchar(40) NOT NULL,
  `Price` double NOT NULL,
  `RestaurantName` varchar(40) NOT NULL,
  `Description` varchar(256) NOT NULL,
  PRIMARY KEY (`packageName`,`RestaurantName`),
  KEY `RestaurantName` (`RestaurantName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `package`
--

INSERT INTO `package` (`packageName`, `Price`, `RestaurantName`, `Description`) VALUES
('4 pcs Chicken Buddy Meal', 13, 'KFC@Dhoby Ghaut', '4 pcs Chicken 2 med Whipped potato 2 can Pepsi'),
('Bandito Pockett Hearty Variety Box', 23, 'KFC@Dhoby Ghaut', '1 Bandito Pockett 4 pcs Chicken 6 pcs Nuggets 1 Popcorn Chicken 1 med Whipped Potato'),
('Cheesy BBQ Meltz Hearty Variety Box', 23, 'KFC@Dhoby Ghaut', '1 Cheesy BBQ Meltz 4 pcs Chicken 6 pcs Nuggets 1 Popcorn Chicken 1 med Whipped Potato'),
('Classic Combo Platter (Non Pork)', 56, 'Subway@Suntec City', '15 pieces of 4 sandwiches,Cold Cut Trio, Roast Beef, Veggie Delite , Tuna, Turkey.'),
('combo(for 2 pax)', 35, '4fingers@plaza singapura', 'Seafood Rice Box -1 4Fingers Crispy Chicken Special (24pcs) -1\r\n'),
('Combo(for 3 pax)', 42, '4fingers@plaza singapura', '4Fingers Crispy Chicken (12pcs) -1 Chicken Katsu Sandwich -1 Chicken Chop -1Chicken Burger -1\r\n'),
('Combo(for 4-6 pax)', 80, '4fingers@plaza singapura', '4Fingers Crispy Chicken Special (50pcs) -1Tofu (2pcs) Rice Box -1Chicken Wrap -1Seaweed Red Pepper Skinny Fries (S) -4'),
('Family Bundle A', 25, 'McDonald''s Suntec City', '1 Filet-O-Fish, 1 McSpicy, 1 Big Mac, 1 Chicken McNuggets 9pc, 2 Apple Pies, 1 McWings 4pc, 3 French Fries (M) and 3 Coca-Cola (S)'),
('Family Bundle B', 25, 'McDonald''s Suntec City', ' Filet-O-Fish, 1 Chicken McNuggets 9pc, 1 McSpicy, 2 Apple Pies, 2 French Fries (M) and 2 Coca-Cola(S).'),
('Flavor Craver Platter (Non Beef)', 56, 'Subway@Suntec City', '15 pieces of 4 sandwiches,Cold Cut Trio, Italian, TurkeynHam, Ham, Turkey'),
('Mos Burger -delivery ComboA', 200, 'Mos Burger - HarbourFront Centre', 'MOS Burger -10 MOS Cheeseburger Spicy -10 MOS Burger Spicy -10  MOS Cheeseburger -10'),
('Mos Burger -delivery ComboB', 200, 'Mos Burger - HarbourFront Centre', 'Hokkaido Croquette Burger -10 Teriyaki Chicken Burger -10 Ebi Rice Burger-10  Kakiage Rice Burger-10'),
('Mushroom Swiss King Chicken Meal (Value)', 9.15, 'Burger King Burlington Square', '1 Mushroom Swiss King Chicken Burger, 1 Medium Onion Rings, 1 Small Soft Drink'),
('Mushroom Swiss King Combo for 4', 41.5, 'Burger King Burlington Square', '2 Mushroom Swiss Mix Burger (Each burger contains both Beef and Chicken), 1 Mushroom Swiss King Chicken, , 3 Large Onion  4 Small Soft Drinks'),
('Party Bundle for 4', 37, 'Burger King Burlington Square', '1 Tendergrill Chicken, 1 BK Long Chicken, 1 BK Doubles Mushroom Swiss, 1 BK Cheesy Fries, 2 Medium Onion Rings, 4PC Mexican Drumlets, 3 Taro Turnover, 1 Hershey''s Sundae Pie, 4 Small Coke'),
('Party Savers', 58, 'Popeyes Louisiana Kitchen (The Cathay)', '15pcs Mixed Chicken, 5pcs Chicken Tenders, 6pcs Cajun Pepper Nuggets, 2 Signature Sides (Large), 5 Biscuits'),
('Subway Fresh Fit Platter', 56, 'Subway@Suntec City', '15 pieces of 4 sandwiches,Roast Beef, Ham, Subway Club, Turkey Ham, Turkey'),
('Superb Savers A', 21, 'Popeyes Louisiana Kitchen (The Cathay)', '5pcs Mixed Chicken, 3pcs Chicken Tenders, 2 Signature Sides (Regular), 2 Biscuits.'),
('Superb Savers B', 21, 'Popeyes Louisiana Kitchen (The Cathay)', '3pcs Mixed Chicken, 1 Creole or Cajun Chicken Sandwich, 2 Signature Sides (Regular), 2 Biscuits.'),
('Tender Chicken Bundle for 2', 20.5, 'Burger King Burlington Square', '1 BK Long Chicken, 1 Tendergrill Chicken, 2 Medium Onion Rings, 3PC Mexican Drumlets, 2 Taro Turnover, 2 Small Coke');

-- --------------------------------------------------------

--
-- Table structure for table `restaurant`
--

CREATE TABLE IF NOT EXISTS `restaurant` (
  `RestaurantName` varchar(40) NOT NULL,
  `OpenTime` time NOT NULL,
  `CloseTime` time NOT NULL,
  `Type` varchar(40) NOT NULL,
  PRIMARY KEY (`RestaurantName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `restaurant`
--

INSERT INTO `restaurant` (`RestaurantName`, `OpenTime`, `CloseTime`, `Type`) VALUES
('4fingers@plaza singapura', '08:00:00', '22:00:00', 'fast food'),
('Burger King Burlington Square', '08:00:00', '23:59:59', 'fast food'),
('KFC Upper Thomson', '00:00:00', '23:59:59', 'fast food'),
('KFC@Dhoby Ghaut', '00:00:00', '23:59:59', 'fastfood'),
('McDonald''s Suntec City', '07:00:00', '22:30:00', 'fast food'),
('Mos Burger - HarbourFront Centre', '11:00:00', '22:00:00', 'fast food'),
('PastaMania (United Square)', '09:00:00', '22:00:00', 'pizza'),
('PizzaHut@PlazaSingapura', '11:00:00', '22:00:00', 'pizza'),
('Popeyes Louisiana Kitchen (The Cathay)', '11:00:00', '22:00:00', 'fast food'),
('Sakae Sushi (Harbourfront Centre)', '11:30:00', '22:00:00', 'Janpanese'),
('Subway@Suntec City', '00:00:00', '23:59:59', 'fast food');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deliveryscope`
--
ALTER TABLE `deliveryscope`
  ADD CONSTRAINT `deliveryscope_ibfk_1` FOREIGN KEY (`restaurantName`) REFERENCES `restaurant` (`RestaurantName`);

--
-- Constraints for table `package`
--
ALTER TABLE `package`
  ADD CONSTRAINT `package_ibfk_1` FOREIGN KEY (`RestaurantName`) REFERENCES `restaurant` (`RestaurantName`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
