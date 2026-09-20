--
--=====================================================
-- 2024-SE-20 Scalar_lab

--====================================================
--
-- Database: `scalar_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustID` int(11) NOT NULL,
  `CustName` varchar(60) NOT NULL,
  `Email` varchar(80) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `JoinDate` date DEFAULT NULL,
  `DOB` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustID`, `CustName`, `Email`, `City`, `Phone`, `JoinDate`, `DOB`) VALUES
(1, ' Ali Khan ', 'ali.khan@MAIL.com', 'Lahore', '0300-1112233', '2022-01-15', '1995-04-12'),
(2, 'Sara Iqbal', 'sara@example.com', 'Karachi', '0301-4445566', '2022-04-22', '1998-11-20'),
(3, 'HAMZA RAZA', 'hamza@example.com', 'Lahore', '0302-7778899', '2023-02-10', '1997-08-05'),
(4, 'Ayesha Noor', NULL, 'Islamabad', '0303-1234567', '2023-05-18', '1999-02-14'),
(5, 'bilal ahmed', 'bilal@MAIL.COM', 'Karachi', '0304-2345678', '2023-09-01', '2000-06-30'),
(6, 'Fatima Sheikh', 'fatima@example.com', NULL, '0305-3456789', '2024-01-12', '1996-10-25'),
(7, 'Usman Tariq', 'usman@example.com', 'Lahore', NULL, '2024-06-30', '2001-03-18'),
(8, 'Maira Javed', 'maira@example.com', 'Islamabad', '0307-5678901', '2024-08-25', '1994-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `ProdID` int(11) NOT NULL,
  `ProdName` varchar(60) NOT NULL,
  `Category` varchar(30) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `StockQty` int(11) DEFAULT NULL,
  `LaunchDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`ProdID`, `ProdName`, `Category`, `Price`, `StockQty`, `LaunchDate`) VALUES
(101, 'Laptop Pro 15', 'Electronics', 185000.00, 12, '2023-03-10'),
(102, 'Wireless Mouse', 'Electronics', 2500.00, 50, '2022-07-22'),
(103, 'USB-C Cable', 'Electronics', 800.00, 100, '2021-11-05'),
(104, 'Office Chair', 'Furniture', 18500.00, 8, '2023-01-15'),
(105, 'Standing Desk', 'Furniture', 45000.50, 5, '2024-02-28'),
(106, 'Notebook A4', 'Stationery', 350.00, 200, '2020-04-01'),
(107, 'Ballpoint Pen 10pk', 'Stationery', 450.00, 150, '2020-04-01'),
(108, 'Coffee Beans 1kg', 'Grocery', 1899.99, 30, '2023-09-20'),
(109, 'Green Tea Box', 'Grocery', 650.00, 45, '2022-12-12'),
(110, 'Bluetooth Speaker', 'Electronics', 7500.00, 18, '2024-05-18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProdID`);
COMMIT;



-- =================================================
-- PART A - STRING FUNCTIONS
-- =================================================

-- Task A1
SELECT
CustID,
CustName AS Original,
TRIM(CustName) AS CleanedName
FROM Customer;


-- Task A2
SELECT
CustID,
UPPER(CustName) AS UpperName,
LOWER(CustName) AS LowerName
FROM Customer;


-- Task A3
SELECT
CustID,
TRIM(CustName) AS CleanedName,
CHAR_LENGTH(TRIM(CustName)) AS NameLength
FROM Customer;


-- Task A4
SELECT
CustID,
CONCAT('Dear ', TRIM(CustName), ', welcome!') AS Greeting
FROM Customer;


-- Task A5
SELECT
CustName,
SUBSTRING(Email, 1, LOCATE('@', Email) - 1) AS Username
FROM Customer
WHERE Email IS NOT NULL;


-- Task A6
SELECT
CustName,
SUBSTRING(Email, LOCATE('@', Email) + 1) AS Domain
FROM Customer
WHERE Email IS NOT NULL;


-- Task A7
SELECT
CustID,
CustName,
LEFT(TRIM(CustName), 3) AS FirstThreeCharacters
FROM Customer;


-- Task A8
SELECT
CustName,
CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Customer
WHERE Phone IS NOT NULL;


-- Task A9
SELECT
ProdID,
REPLACE(ProdName, ' ', '-') AS SlugName
FROM Product;


-- Task A10
SELECT
ProdID,
LPAD(ProdID, 5, '0') AS PaddedID
FROM Product;


-- Task A11
SELECT
ProdID,
ProdName,
LOCATE('Pro', ProdName) AS ProPosition
FROM Product
WHERE LOCATE('Pro', ProdName) > 0;


-- Task A12
SELECT
CustID,
CustName,
SUBSTRING(
TRIM(CustName),
1,
LOCATE(' ', TRIM(CustName)) - 1
) AS FirstName
FROM Customer;

-- =====================================
-- PART B - NUMERIC & DATE/TIME
-- =====================================

-- Task B1
SELECT
ProdName,
Price,
ROUND(Price * 0.85, 2) AS DiscountedPrice
FROM Product;


-- Task B2
SELECT
ProdName,
ROUND(Price * 0.17, 2) AS Tax,
ROUND(Price * 1.17, 2) AS PriceWithTax
FROM Product;


-- Task B3
SELECT
ProdName,
Price,
FLOOR(Price / 1000) AS FloorVal,
CEIL(Price / 1000) AS CeilVal
FROM Product;


-- Task B4
SELECT
ProdName,
Price,
ROUND(Price, -2) AS RoundedToHundred
FROM Product;


-- Task B5
SELECT
ProdID,
ProdName
FROM Product
WHERE MOD(ProdID, 2) = 1;


-- Task B6
SELECT
CustID,
CustName,
YEAR(JoinDate) AS JoinYear,
MONTHNAME(JoinDate) AS JoinMonth,
DAYNAME(JoinDate) AS JoinDay
FROM Customer;


-- Task B7
SELECT
CustName,
DATE_FORMAT(DOB, '%d-%M-%Y') AS FormattedDOB
FROM Customer;


-- Task B8
SELECT
CustName,
DOB,
TIMESTAMPDIFF(YEAR, DOB, CURDATE()) AS Age
FROM Customer;


-- Task B9
SELECT
CustName,
JoinDate,
DATEDIFF(CURDATE(), JoinDate) AS DaysSinceJoin
FROM Customer;


-- Task B10
SELECT
CustID,
CustName,
JoinDate
FROM Customer
WHERE YEAR(JoinDate) = 2023;


-- Task B11
SELECT
ProdID,
ProdName,
LaunchDate
FROM Product
WHERE MONTH(LaunchDate) IN (10, 11, 12);


-- Task B12
SELECT
CustID,
CustName,
JoinDate
FROM Customer
WHERE JoinDate >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);


-- Task B13
SELECT
ProdName,
LaunchDate,
DATEDIFF(CURDATE(), LaunchDate) AS AgeInDays
FROM Product;


-- Task B14
SELECT
ProdName,
LaunchDate,
DATE_ADD(LaunchDate, INTERVAL 90 DAY) AS NinetyDaysLater
FROM Product;


-- Task B15
SELECT
    CONCAT(
'Hello ',
UPPER(TRIM(CustName)),
', age ',
TIMESTAMPDIFF(YEAR, DOB, CURDATE()),
', joined ',
DATE_FORMAT(JoinDate, '%b %Y')
) AS Summary
FROM Customer;