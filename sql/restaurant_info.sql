-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 27, 2015 at 07:52 AM
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
('4 fingers plaza singapura', 'Kallang'),
('Burger King Burlington Square', 'Kallang'),
('KFC Singapore - Parklane', 'Kallang'),
('Mos Burger - HarbourFront Centre', 'Kallang'),
('Popeyes Louisiana Kitchen (The Cathay)', 'Kallang'),
('Sakae Sushi (Harbourfront Centre)', 'Kallang'),
('Subway Suntec City Mall', 'Kallang'),
('Wendy''s@Raffles Quay', 'Kallang'),
('McDonald''s Suntec City', 'Novena'),
('PastaMania (United Square)', 'Novena'),
('Subway Suntec City Mall', 'Novena'),
('4 fingers plaza singapura', 'Rochor'),
('Burger King Burlington Square', 'Rochor'),
('KFC Singapore - Parklane', 'Rochor'),
('McDonald''s Suntec City', 'Rochor'),
('Mos Burger - HarbourFront Centre', 'Rochor'),
('PizzaHut@PlazaSingapura', 'Rochor'),
('Popeyes Louisiana Kitchen (The Cathay)', 'Rochor'),
('Subway Suntec City Mall', 'Rochor'),
('Wendy''s@Raffles Quay', 'Rochor');

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
('4 pcs Chicken Buddy Meal', 13, 'KFC Singapore - Parklane', '4 pcs Chicken\r\n2 med Whipped potato\r\n2 can Pepsi'),
('Bandito Pockett Hearty Variety Box', 23, 'KFC Singapore - Parklane', '1 Bandito Pockett\r\n4 pcs Chicken\r\n6 pcs Nuggets\r\n1 Popcorn Chicken\r\n1 med Whipped Potato'),
('Cheesy BBQ Meltz Hearty Variety Box', 23, 'KFC Singapore - Parklane', '1 Cheesy BBQ Meltz\r\n4 pcs Chicken\r\n6 pcs Nuggets\r\n1 Popcorn Chicken\r\n1 med Whipped Potato'),
('Classic Combo Platter (Non Pork)', 56, 'Subway Suntec City Mall', '15 pieces of 4” sandwiches\r\nCold Cut Trio, Roast Beef, Veggie Delite™ , Tuna, Turkey.'),
('combo(for 2 pax)', 35, '4 fingers plaza singapura', 'Seafood Rice Box -1\r\n4Fingers Crispy Chicken Special (24pcs) -1\r\n'),
('Combo(for 3 pax)', 42, '4 fingers plaza singapura', '4Fingers Crispy Chicken (12pcs) -1\r\nChicken Katsu Sandwich -1\r\nChicken Chop -1\r\nChicken Burger -1\r\n'),
('Combo(for 4-6 pax)', 80, '4 fingers plaza singapura', '4Fingers Crispy Chicken Special (50pcs) -1\r\nTofu (2pcs) Rice Box -1\r\nChicken Wrap -1\r\nSeaweed Red Pepper Skinny Fries (S) -4'),
('Family Bundle A', 25, 'McDonald''s Suntec City', '1 Filet-O-Fish, 1 McSpicy, 1 Big Mac, 1 Chicken McNuggets 9pc, 2 Apple Pies, 1 McWings 4pc, 3 French Fries (M) and 3 Coca-Cola (S)'),
('Family Bundle B', 25, 'McDonald''s Suntec City', ' Filet-O-Fish, 1 Chicken McNuggets 9pc, 1 McSpicy, 2 Apple Pies, 2 French Fries (M) and 2 Coca-Cola(S).'),
('Flavor Craver Platter (Non Beef)', 56, 'Subway Suntec City Mall', '15 pieces of 4” sandwiches\r\nCold Cut Trio, Italian B.M.T™, Turkey & Ham, Ham, Turkey'),
('Mos Burger -delivery ComboA', 200, 'Mos Burger - HarbourFront Centre', 'MOS Burger -10 MOS Cheeseburger Spicy -10 MOS Burger Spicy -10  MOS Cheeseburger -10'),
('Mos Burger -delivery ComboB', 200, 'Mos Burger - HarbourFront Centre', 'Hokkaido Croquette Burger -10\r\n Teriyaki Chicken Burger -10\r\nEbi Rice Burger-10  Kakiage Rice Burger-10'),
('Mushroom Swiss King Chicken Meal (Value)', 9.15, 'Burger King Burlington Square', '1 Mushroom Swiss King Chicken Burger, 1 Medium Onion Rings, 1 Small Soft Drink'),
('Mushroom Swiss King Combo for 4', 41.5, 'Burger King Burlington Square', '2 Mushroom Swiss Mix Burger (Each burger contains both Beef and Chicken), 1 Mushroom Swiss King Chicken, 1 BK FISH’N CRISP™, 3 Large Onion Rings, 1 9P BK Nuggets, 2 Taro Turnover, 2 Mini Sundaes, 4 Small Soft Drinks'),
('Party Bundle for 4', 37, 'Burger King Burlington Square', '1 Tendergrill Chicken, 1 BK Long Chicken, 1 BK Doubles Mushroom Swiss, 1 BK FISH’N CRISP™, 1 BK Cheesy Fries, 2 Medium Onion Rings, 4PC Mexican Drumlets, 3 Taro Turnover, 1 Hershey''s Sundae Pie, 4 Small Coke'),
('Party Savers', 58, 'Popeyes Louisiana Kitchen (The Cathay)', '15pcs Mixed Chicken, 5pcs Chicken Tenders, 6pcs Cajun Pepper Nuggets, 2 Signature Sides (Large), 5 Biscuits'),
('Subway Fresh Fit Platter', 56, 'Subway Suntec City Mall', '15 pieces of 4” sandwiches\r\nRoast Beef, Ham, Subway Club™, Turkey & Ham, Turkey'),
('Superb Savers A', 21, 'Popeyes Louisiana Kitchen (The Cathay)', '5pcs Mixed Chicken, 3pcs Chicken Tenders, 2 Signature Sides (Regular), 2 Biscuits.'),
('Superb Savers B', 21, 'Popeyes Louisiana Kitchen (The Cathay)', '3pcs Mixed Chicken, 1 Creole or Cajun Chicken Sandwich, 2 Signature Sides (Regular), 2 Biscuits.'),
('Tender Chicken Bundle for 2', 20.5, 'Burger King Burlington Square', '1 BK Long Chicken, 1 Tendergrill Chicken, 2 Medium Onion Rings, 3PC Mexican Drumlets, 2 Taro Turnover, 2 Small Coke'),
('Wendy''s Party Solution', 150, 'Wendy''s@Raffles Quay', 'Hot and Juicy Cheese Burger x3\r\nChicken Sensation x3\r\nBaked potatoes x10\r\nchicken nuggets x 48pcs\r\ncut fries  x 5\r\ncan drinks x 20');





-- --------------------------------------------------------

--
-- Table structure for table `deliveryscope`
--

CREATE TABLE IF NOT EXISTS `urlMapping` (
  `restaurantName` varchar(40) NOT NULL,
  `region` varchar(40) NOT NULL,
  PRIMARY KEY (`restaurantName`,`url`),
  KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `deliveryscope`
--

INSERT INTO `urlMapping` (`restaurantName`, `url`) VALUES
('KFC Upper Thomson', 'url1'),
('4 fingers plaza singapura', 'url2'),
('Burger King Burlington Square', 'url3'),
('KFC Singapore - Parklane', 'url4'),
('Mos Burger - HarbourFront Centre', 'url5'),
('Popeyes Louisiana Kitchen (The Cathay)', 'url6'),
('Sakae Sushi (Harbourfront Centre)', 'url7'),
('Subway Suntec City Mall', 'url8'),
('Wendy''s@Raffles Quay', 'url9'),
('McDonald''s Suntec City', 'url10'),
('PastaMania (United Square)', 'url11'),
('Subway Suntec City Mall', 'url12'),
('4 fingers plaza singapura', 'url13'),
('Burger King Burlington Square', 'url14'),
('KFC Singapore - Parklane', 'url15'),
('McDonald''s Suntec City', 'url16'),
('Mos Burger - HarbourFront Centre', 'url17'),
('PizzaHut@PlazaSingapura', 'url18'),
('Popeyes Louisiana Kitchen (The Cathay)', 'url19'),
('Subway Suntec City Mall', 'url20'),
('Wendy''s@Raffles Quay', 'url21');




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
('4 fingers plaza singapura', '08:00:00', '22:00:00', 'fast food'),
('Burger King Burlington Square', '08:00:00', '23:59:59', 'fast food'),
('KFC Singapore - Parklane', '00:00:00', '23:59:59', 'fastfood'),
('KFC Upper Thomson', '00:00:00', '23:59:59', 'fast food'),
('McDonald''s Suntec City', '07:00:00', '22:30:00', 'fast food'),
('Mos Burger - HarbourFront Centre', '11:00:00', '22:00:00', 'fast food'),
('PastaMania (United Square)', '09:00:00', '22:00:00', 'pizza'),
('PizzaHut@PlazaSingapura', '11:00:00', '22:00:00', 'pizza'),
('Popeyes Louisiana Kitchen (The Cathay)', '11:00:00', '22:00:00', 'fast food'),
('Sakae Sushi (Harbourfront Centre)', '11:30:00', '22:00:00', 'Janpanese'),
('Subway Suntec City Mall', '00:00:00', '23:59:59', 'fast food'),
('Wendy''s@Raffles Quay', '08:00:00', '23:59:59', 'fast food');

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
