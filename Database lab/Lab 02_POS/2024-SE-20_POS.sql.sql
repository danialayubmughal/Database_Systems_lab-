-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2026 at 05:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pos database`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `CategoryID` varchar(10) NOT NULL,
  `CategoryName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`CategoryID`, `CategoryName`) VALUES
('C05', 'Frozen'),
('CO1', 'Beverages'),
('CO10', 'Personal-care'),
('CO2', 'Snacks'),
('CO3', 'Dairy'),
('CO4', 'Bakery'),
('CO6', 'Fruits'),
('CO7', 'Vegetables'),
('CO8', 'Meat'),
('CO9', 'Grocery');

-- --------------------------------------------------------

--
-- Table structure for table `discount`
--

CREATE TABLE `discount` (
  `DiscountID` varchar(10) NOT NULL,
  `ProductID` varchar(10) NOT NULL,
  `DiscountPersent` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discount`
--

INSERT INTO `discount` (`DiscountID`, `ProductID`, `DiscountPersent`) VALUES
('D01', 'PO1', '10%'),
('D010', 'PO10', '80%'),
('D02', 'PO2', '50%'),
('D03', 'PO3', '30%'),
('D04', 'PO4', '20%'),
('D05', 'PO5', '6%'),
('D06', 'PO6', '15%'),
('D07', 'PO7', '12%'),
('D08', 'PO8', '60%'),
('D09', 'PO9', '50%');

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE `orderitem` (
  `OrderItemId` varchar(10) NOT NULL,
  `OrderID` varchar(10) NOT NULL,
  `ProductID` varchar(10) NOT NULL,
  `Quantity` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderitem`
--

INSERT INTO `orderitem` (`OrderItemId`, `OrderID`, `ProductID`, `Quantity`) VALUES
('OI01', '001', 'PO1', 2),
('OI010', '010', 'PO10', 8),
('OI02', '002', 'PO2', 1),
('OI03', '003', 'PO3', 3),
('OI04', '004', 'PO4', 4),
('OI05', '005', 'PO5', 3),
('OI06', '006', 'PO6', 1),
('OI07', '007', 'PO7', 7),
('OI08', '008', 'PO8', 5),
('OI09', '009', 'PO9', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` varchar(10) NOT NULL,
  `OrderDate` date NOT NULL,
  `CostumerName` varchar(50) NOT NULL,
  `Salesman` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `OrderDate`, `CostumerName`, `Salesman`) VALUES
('001', '2026-04-01', 'Ali', 'Ahmed'),
('002', '2026-04-02', 'Sara', 'Bilal'),
('003', '2026-04-03', 'Usman', 'Ahmed'),
('004', '2026-04-04', 'Imran', 'Bilal'),
('005', '2026-04-05', 'Hamza', 'Ahmed'),
('006', '2026-04-06', 'Ayesha', 'Bilal'),
('007', '2026-04-07', 'Hina', 'Ahmed'),
('008', '2026-04-08', 'Saeed', 'Ahmed'),
('009', '2026-04-09', 'Saad', 'Bilal'),
('010', '2026-04-10', 'Fahad', 'Ahmed');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductID` varchar(10) NOT NULL,
  `ProductName` varchar(50) NOT NULL,
  `CategoryID` varchar(10) NOT NULL,
  `Price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`ProductID`, `ProductName`, `CategoryID`, `Price`) VALUES
('PO1', 'Pepsi', 'Co1', 120),
('PO10', 'Shampoo', 'CO10', 400),
('PO2', 'Chips', 'CO2', 80),
('PO3', 'Milk', 'CO3', 150),
('PO4', 'Bread', 'CO4', 100),
('PO5', 'Ice Cream', 'C05', 200),
('PO6', 'Apple', 'CO6', 180),
('PO7', 'Carrot', 'CO7', 90),
('PO8', 'Chicken', 'CO8', 500),
('PO9', 'Rice', 'CO9', 250);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Indexes for table `discount`
--
ALTER TABLE `discount`
  ADD PRIMARY KEY (`DiscountID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD PRIMARY KEY (`OrderItemId`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `discount`
--
ALTER TABLE `discount`
  ADD CONSTRAINT `discount_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `orderitem_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderitem_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `categories` (`CategoryID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
