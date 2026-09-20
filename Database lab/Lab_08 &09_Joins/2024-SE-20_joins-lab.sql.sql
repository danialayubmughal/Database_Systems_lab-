
--====================================
-- 2024-SE-20_Joins Lab.sql

--====================================  
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";




--
-- Database: `joins-lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `EmpID` int(11) NOT NULL,
  `ProjectID` int(11) NOT NULL,
  `HoursPerWeek` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`EmpID`, `ProjectID`, `HoursPerWeek`) VALUES
(101, 1001, 10),
(102, 1001, 20),
(102, 1002, 15),
(103, 1002, 30),
(104, 1003, 25),
(105, 1003, 40),
(106, 1004, 35),
(108, 1005, 20),
(109, 1005, 30);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DeptID` int(11) NOT NULL,
  `DeptName` varchar(40) NOT NULL,
  `Location` varchar(30) DEFAULT NULL,
  `Budget` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DeptID`, `DeptName`, `Location`, `Budget`) VALUES
(10, 'Engineering', 'Lahore', 5000000.00),
(20, 'Marketing', 'Karachi', 2000000.00),
(30, 'Finance', 'Islamabad', 3000000.00),
(40, 'Research', 'Lahore', 4000000.00),
(50, 'Sales', 'Lahore', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `EmpName` varchar(50) NOT NULL,
  `Gender` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `ManagerID` int(11) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmpID`, `EmpName`, `Gender`, `Salary`, `HireDate`, `City`, `ManagerID`, `DeptID`) VALUES
(101, 'Ali Khan', 'M', 120000.00, '2018-03-15', 'Lahore', NULL, 10),
(102, 'Sara Iqbal', 'F', 95000.00, '2019-06-01', 'Lahore', 101, 10),
(103, 'Hamza Raza', 'M', 85000.00, '2020-01-20', 'Karachi', 101, 10),
(104, 'Ayesha Noor', 'F', 110000.00, '2017-11-10', 'Karachi', NULL, 20),
(105, 'Bilal Ahmed', 'M', 70000.00, '2021-04-05', 'Karachi', 104, 20),
(106, 'Fatima Sheikh', 'F', 90000.00, '2021-09-12', 'Islamabad', NULL, 30),
(107, 'Usman Tariq', 'M', 78000.00, '2022-02-18', 'Islamabad', 106, 30),
(108, 'Maira Javed', 'F', 115000.00, '2016-07-22', 'Lahore', NULL, 40),
(109, 'Zain Abbas', 'M', 60000.00, '2023-01-09', 'Lahore', 108, 40),
(110, 'Nida Yousaf', 'F', 72000.00, '2022-08-30', NULL, 108, 10);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `ProjectID` int(11) NOT NULL,
  `ProjectName` varchar(50) NOT NULL,
  `StartDate` date DEFAULT NULL,
  `EndDate` date DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`ProjectID`, `ProjectName`, `StartDate`, `EndDate`, `DeptID`) VALUES
(1001, 'Website Revamp', '2024-10-05', '2024-06-30', 10),
(1002, 'Mobile App', '2024-03-01', '2024-12-31', 10),
(1003, 'Brand Champaign', '2024-02-15', '2024-05-15', 20),
(1004, 'Audit System', '2024-04-01', NULL, 30),
(1005, 'AI Research', '2024-05-01', '2025-04-30', 40),
(1006, 'Internal Tool', '2024-06-01', '2024-09-30', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`EmpID`,`ProjectID`),
  ADD KEY `ProjectID` (`ProjectID`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DeptID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`),
  ADD KEY `DeptID` (`DeptID`),
  ADD KEY `ManagerID` (`ManagerID`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `DeptID` (`DeptID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`EmpID`) REFERENCES `employee` (`EmpID`),
  ADD CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `project` (`ProjectID`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`),
  ADD CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`ManagerID`) REFERENCES `employee` (`EmpID`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`);
COMMIT;

-- =============================================================
-- SQL Joins Lab Solution
-- =============================================================
-- Part A(Inner,Left,Right joins)
-- =============================================================
-- Task A1

SELECT e.EmpID,e.EmpName,
d.DeptName,d.Location
FROM employee   e 
INNER JOIN department d 
on e.DeptID=d.DeptID;
-- Task A2
SELECT e.EmpID,e.EmpName, 
d.DeptName,d.Location
FROM employee e 
LEFT JOIN department d 
ON e.DeptID=d.DeptID;
-- Task A3
SELECT d.DeptName,e.EmpName
FROM department d 
LEFT JOIN employee e 
ON d.DeptID=e.DeptID;
-- Task A4
SELECT p.ProjectName,d.DeptName,d.Location
FROM project p 
LEFT JOIN department d 
ON p.DeptID=d.DeptID;
-- Task A5

SELECT e.EmpID,e.EmpName
FROM employee e 
LEFT JOIN assignment a 
ON e.EmpID=a.EmpID
WHERE a.EmpID IS NULL;
-- Task A6
SELECT p.ProjectID,p.ProjectName
FROM project p
LEFT JOIN assignment a 
ON p.ProjectID=a.ProjectID
WHERE a.ProjectID IS NULL;
-- Task A7
SELECT e.EmpName,e.Salary
FROM employee e INNER JOIN department d 
ON e.DeptID=d.DeptID
WHERE d.DeptName='Engineering'
ORDER BY e.Salary DESC;
--Task A8
SELECT e.EmpName,d.DeptName
FROM employee e 
INNER JOIN department d 
ON e.DeptID=d.DeptID
WHERE Location='Lahore';
--Task A9
SELECT d.DeptName, COUNT(e.EmpID) AS 
TotalEmployees
FROM department d 
LEFT JOIN employee e 
ON d.DeptID=e.DeptID
GROUP BY d.DeptName;
-- Task A10
SELECT e.EmpName,d.DeptName
FROM employee e 
LEFT JOIN department d 
ON e.DeptID=d.DeptID

UNION

SELECT e.Empname, d.DeptName
FROM employee e 
RIGHT JOIN department d 
ON e.DeptID=d.DeptID;

--=============================================================
-- Part B(Self Joins,Multi-Table joins,and Combined Challenges)
--=============================================================
-- Task B1
SELECT e.EmpName AS Employee,
m.EmpName AS Manager
FROM Employee e
LEFT JOIN Employee m
ON e.ManagerID = m.EmpID;

-- Task B2
SELECT e.EmpName AS Employee,
 e.Salary AS EmployeeSalary,
 m.EmpName AS Manager,
 m.Salary AS ManagerSalary
FROM Employee e
INNER JOIN Employee m
ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Task B3
SELECT e.EmpName,
 m.EmpName AS ManagerName,
 d1.DeptName AS EmployeeDepartment,
d2.DeptName AS ManagerDepartment
FROM Employee e
INNER JOIN Employee m
ON e.ManagerID = m.EmpID
INNER JOIN Department d1
ON e.DeptID = d1.DeptID
INNER JOIN Department d2
ON m.DeptID = d2.DeptID
WHERE e.DeptID <> m.DeptID;

-- Task B4
SELECT e.EmpName,
p.ProjectName,
a.HoursPerWeek
FROM Employee e
JOIN Assignment a
ON e.EmpID = a.EmpID
JOIN Project p
ON a.ProjectID = p.ProjectID;

-- Task B5
SELECT e.EmpName,
p.ProjectName,
d.DeptName
FROM Employee e
JOIN Assignment a
ON e.EmpID = a.EmpID
JOIN Project p
ON a.ProjectID = p.ProjectID
JOIN Department d
ON p.DeptID = d.DeptID;

-- Task B6
SELECT e.EmpName,
a.HoursPerWeek
FROM Employee e
JOIN Assignment a
ON e.EmpID = a.EmpID
JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';

-- Task B7
SELECT e.EmpName,
p.ProjectName,
a.HoursPerWeek
FROM Employee e
LEFT JOIN Assignment a
ON e.EmpID = a.EmpID
LEFT JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore';

-- Task B8
SELECT e.EmpName,
 p.ProjectName
FROM Employee e
JOIN Assignment a
ON e.EmpID = a.EmpID
JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE e.DeptID <> p.DeptID;

-- Task B9
SELECT d.DeptName,
p.ProjectName
FROM Department d
LEFT JOIN Project p
ON d.DeptID = p.DeptID
AND YEAR(p.StartDate) = 2024;

-- Task B10
SELECT e.EmpName,
IFNULL(SUM(a.HoursPerWeek),0) AS TotalHours
FROM Employee e
LEFT JOIN Assignment a
ON e.EmpID = a.EmpID
GROUP BY e.EmpID, e.EmpName;


--=============================================
--Database liabrary_lab
--=============================================

-- Table structure for table `author`
--

CREATE TABLE `author` (
  `AuthorID` int(11) NOT NULL,
  `AuthorName` varchar(60) NOT NULL,
  `Country` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`AuthorID`, `AuthorName`, `Country`) VALUES
(1, 'Jane Austen', 'UK'),
(2, 'Chinua Achebe', 'Nigeria'),
(3, 'Haruki Murakami', 'Japan'),
(4, 'Bapsi Sidhwa', 'Pakistan'),
(5, 'Mohsin Hamid', 'Pakistan'),
(6, 'Anonymous Writer', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `BookID` int(11) NOT NULL,
  `Title` varchar(80) NOT NULL,
  `Genre` varchar(30) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `AuthorID` int(11) DEFAULT NULL,
  `PublishedYear` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`BookID`, `Title`, `Genre`, `Price`, `AuthorID`, `PublishedYear`) VALUES
(101, 'Pride and Prejudice', 'Fiction', 850.00, 1, 1813),
(102, 'Emma', 'Fiction', 900.00, 1, 1815),
(103, 'Things Fall Apart', 'Fiction', 1100.00, 2, 1958),
(104, 'Norwegian Wood', 'Fiction', 1500.00, 3, 1987),
(105, 'Kafka on the Shore', 'Fiction', 1700.00, 3, 2002),
(106, 'Ice-Candy-Man', 'Fiction', 1200.00, 4, 1988),
(107, 'The Reluctant Fundamentalist', 'Fiction', 1300.00, 5, 2007),
(108, 'Exit West', 'Fiction', 1450.00, 5, 2017),
(109, 'Mystery Title', 'Mystery', 950.00, NULL, 2020);

-- --------------------------------------------------------

--
-- Table structure for table `loan`
--

CREATE TABLE `loan` (
  `LoanID` int(11) NOT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `BookID` int(11) DEFAULT NULL,
  `LoanDate` date DEFAULT NULL,
  `ReturnDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `loan`
--

INSERT INTO `loan` (`LoanID`, `MemberID`, `BookID`, `LoanDate`, `ReturnDate`) VALUES
(1, 201, 101, '2024-03-01', '2024-03-15'),
(2, 201, 104, '2024-04-10', NULL),
(3, 202, 103, '2024-02-20', '2024-03-05'),
(4, 202, 107, '2024-05-01', NULL),
(5, 203, 105, '2024-04-25', '2024-05-15'),
(6, 204, 102, '2024-01-10', '2024-01-30'),
(7, 204, 108, '2024-06-01', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `member`
--

CREATE TABLE `member` (
  `MemberID` int(11) NOT NULL,
  `MemberName` varchar(60) NOT NULL,
  `City` varchar(30) DEFAULT NULL,
  `JoinDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `member`
--

INSERT INTO `member` (`MemberID`, `MemberName`, `City`, `JoinDate`) VALUES
(201, 'Ahmad Raza', 'Lahore', '2023-01-15'),
(202, 'Sara Imran', 'Karachi', '2023-03-20'),
(203, 'Bilal Khan', 'Lahore', '2024-02-10'),
(204, 'Fatima Ali', 'Islamabad', '2022-09-05'),
(205, 'Hira Yousaf', NULL, '2024-05-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`AuthorID`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BookID`),
  ADD KEY `AuthorID` (`AuthorID`);

--
-- Indexes for table `loan`
--
ALTER TABLE `loan`
  ADD PRIMARY KEY (`LoanID`),
  ADD KEY `MemberID` (`MemberID`),
  ADD KEY `BookID` (`BookID`);

--
-- Indexes for table `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`MemberID`);

--
-- Constraints for dumped tables
--

--==========================================
-- Assesment Question
--==========================================

-- Q1
SELECT b.Title,
a.AuthorName,
a.Country
FROM Book b
INNER JOIN Author a
ON b.AuthorID = a.AuthorID;

-- Q2
SELECT a.AuthorName,
b.Title
FROM Author a
LEFT JOIN Book b
ON a.AuthorID = b.AuthorID;

-- Q3
SELECT m.MemberName
FROM Member m
LEFT JOIN Loan l
ON m.MemberID = l.MemberID
WHERE l.MemberID IS NULL;

-- Q4
SELECT l.LoanID,
m.MemberName,
b.Title,
a.AuthorName
FROM Loan l
JOIN Member m
ON l.MemberID = m.MemberID
JOIN Book b
ON l.BookID = b.BookID
JOIN Author a
ON b.AuthorID = a.AuthorID;

-- Q5
SELECT b.Title,
m.MemberName,
m.City
FROM Loan l
JOIN Book b
ON l.BookID = b.BookID
JOIN Member m
ON l.MemberID = m.MemberID
WHERE l.ReturnDate IS NULL;

-- Q6
SELECT a.AuthorName,
b.Title
FROM Author a
LEFT JOIN Book b
ON a.AuthorID = b.AuthorID
WHERE a.Country = 'Pakistan';

-- Q7
SELECT b.Title,
m.MemberName
FROM Book b
LEFT JOIN Loan l
ON b.BookID = l.BookID
LEFT JOIN Member m
ON l.MemberID = m.MemberID;

-- Q8
SELECT a.AuthorName
FROM Author a
LEFT JOIN Book b
ON a.AuthorID = b.AuthorID
LEFT JOIN Loan l
ON b.BookID = l.BookID
WHERE l.LoanID IS NULL;

-- Q9
SELECT a.AuthorName,
b.Title
FROM Author a
LEFT JOIN Book b
ON a.AuthorID = b.AuthorID

UNION

SELECT a.AuthorName,
b.Title
FROM Author a
RIGHT JOIN Book b
ON a.AuthorID = b.AuthorID;

-- Q10
SELECT m.MemberName,
b.Title,
a.AuthorName
FROM Member m
JOIN Loan l
ON m.MemberID = l.MemberID
JOIN Book b
ON l.BookID = b.BookID
JOIN Author a
ON b.AuthorID = a.AuthorID
WHERE a.Country = 'Pakistan';