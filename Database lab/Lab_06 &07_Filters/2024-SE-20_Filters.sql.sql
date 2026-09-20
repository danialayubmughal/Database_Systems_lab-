
-- =====================================

-- 2024-SE-20_Filters.sql


-- =====================================
-- Database: `filter-lab`

-- Table structure for table `employee`

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `EmpName` varchar(50) NOT NULL,
  `GENDER` char(1) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `JobTitle` varchar(40) DEFAULT NULL,
  `DeptName` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmpID`, `EmpName`, `GENDER`, `Salary`, `HireDate`, `City`, `JobTitle`, `DeptName`) VALUES
(101, 'ALi Khan', 'M', 120000.00, '2018-03-15', 'Lahore', 'Senior Engineer', 'Engineering'),
(102, 'Sara Iqbal', 'F', 95000.00, '2019-06-01', 'Lahore', 'Software Engineering', 'Engineering'),
(103, 'Hamza Raza', 'M', 85000.00, '2020-01-20', 'Karachi', 'Software Engineering', 'Engineering'),
(104, 'Ayesha Noor', 'F', 110000.00, '2017-11-10', 'Karachi', 'Marketing Lead', 'Marketing'),
(105, 'Bilal Ahmed', 'M', 70000.00, '2021-04-05', 'Karachi', 'Marketing Exce', 'Marketing'),
(106, 'Fatima Sheikh', 'F', 90000.00, '2019-09-12', 'Islamabad', 'Accoutant', 'Finance'),
(107, 'Usman Tariq', 'M', 78000.00, '2022-02-18', 'Islamabad', 'Accoutant', 'Finance'),
(108, 'Maria Javed', 'F', 115000.00, '2016-07-22', 'Lahore', 'Research Lead', 'Research'),
(109, 'Zain Abbas', 'M', 60000.00, '2023-01-09', 'Lahore', 'Research Lead', 'Research'),
(110, 'Nida Yousaf', 'F', 72000.00, '2022-08-30', NULL, 'Research Analyst', 'Research'),
(111, 'Adeel Akhtar', 'M', 88000.00, '2020-05-14', 'Lahore', 'QA Engineer', 'Engineering'),
(112, 'Sana Malik', 'F', 102000.00, '2018-12-01', 'Karachi', 'Sale Manager', 'Sales'),
(113, 'Talha Hussain', 'M', 65000.00, '2023-07-18', 'Islamabad', 'Sale Exec', 'Sales'),
(114, 'Mehwish Anwar', 'F', 80000.00, '2021-10-25', 'Lahore', 'HR Officer', 'HR'),
(115, 'Imran Shafi', 'M', 125000.00, '2015-04-30', NULL, 'Director', 'Engineering');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`);
COMMIT;

-- =============================================================
-- SQL Filter Lab Solution
-- =============================================================
-- Part A(Comparision and Logical Operators)
-- =============================================================

-- Task A1
SELECT EmpID,EmpName,Salary
FROM employee
WHERE Salary>90000;
-- Task A2
SELECT EmpName,Salary
FROM employee
WHERE Salary<=75000;
-- Task A3
SELECT* 
FROM employee
WHERE City='Lahore' AND Salary>90000;
-- Task A4
SELECT EmpName,City
FROM employee
WHERE City='Karachi' OR City='Islamabad';
-- Task A5
SELECT* 
FROM employee
WHERE GENDER='F' AND DeptName!='Engineering';
--  Task A6
SELECT *
FROM employee
WHERE GENDER='M'
AND Salary>=70000
AND Salary<=90000;
-- Task A7
SELECT * 
FROM employee
WHERE JobTitle='Software Engineering'
OR Salary>100000;
-- Task A8
SELECT * 
FROM employee
WHERE DeptName!='Marketing'
AND DeptName!='Sales';

-- ===================================================
-- Part B(BETWEEN,IN,LIKE,IS NULL,ORDER BY,LIMIT)
-- ===================================================

-- B1
SELECT * 
FROM employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;
-- B2
SELECT * 
FROM employee 
WHERE HireDate BETWEEN '2020-01-01'
AND '2022-12-31';
-- B3
SELECT * FROM employee
WHERE Salary NOT BETWEEN 80000 AND 100000;
-- B4
SELECT * FROM employee
WHERE City IN('Lahore','Islamabad') 
ORDER BY 'City' ASC,'Salary' DESC;
-- B5
SELECT *
FROM employee
WHERE DeptName NOT IN ('Engineering','Sales','HR');
-- B6
SELECT EmpName
 FROM employee
WHERE EmpName LIKE 'M%';
-- B7
SELECT EmpName
FROM employee
WHERE EmpName
LIKE '%a%';
-- B8
SELECT EmpName
 FROM employee
WHERE EmpName LIKE '%an';
-- B9
SELECT EmpName,JobTitle
 FROM employee
WHERE JobTitle LIKE '%Engineer%'
AND DeptName!='Engineering';
-- B10
SELECT EmpName
FROM employee
WHERE City IS NULL;
-- B11
SELECT *
FROM employee
WHERE City IS NOT NUll
ORDER BY City ASC;
-- B12
SELECT EmpName,Salary
FROM employee
ORDER BY Salary DESC
LIMIT 3;
-- B13
SELECT EmpName,HireDate
FROM employee
ORDER BY HireDate DESC
LIMIT 5;
-- B14
SELECT EmpName,Salary
FROM employee
ORDER BY Salary ASC
LIMIT 3;
-- B15
SELECT *
FROM employee
ORDER BY DeptName ASC,HireDate ASC;

-- =============================================================================

-- Database: `bookstore_lab`


-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `BookID` int(11) NOT NULL,
  `Title` varchar(80) NOT NULL,
  `Aurthor` varchar(60) DEFAULT NULL,
  `Genre` varchar(30) DEFAULT NULL,
  `Price` decimal(8,2) DEFAULT NULL,
  `StokeQty` int(11) DEFAULT NULL,
  `PublishedYear` int(11) DEFAULT NULL,
  `Publisher` varchar(40) DEFAULT NULL,
  `Language` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`BookID`, `Title`, `Aurthor`, `Genre`, `Price`, `StokeQty`, `PublishedYear`, `Publisher`, `Language`) VALUES
(1, 'Pride and Prejudics', 'Jane Austen', 'Fiction', 850.00, 12, 1813, 'Penguin', 'English'),
(2, 'Emma', 'Jane Austen', 'Fiction', 900.00, 8, 1815, 'Penguin', 'English'),
(3, 'Things Fall Apart', 'Chinua Acheba', 'Fiction', 1100.00, 5, 1958, 'Heinemann', 'English'),
(4, 'Norwegian Wood', 'Haruki Marakami', 'Fiction', 1500.00, 3, 1987, 'Vintage', 'English'),
(5, 'Kafka on the Shore', 'Haruki Marakami', 'Fiction', 1700.00, 0, 2002, 'Vintage', 'English'),
(6, 'Ice_Candy_Man', 'Bapsi Sidhwa', 'Fiction', 1200.00, 15, 1988, 'Penguin', 'English'),
(7, 'The Reluctant Fundamentalist', 'Mohsin Hamid', 'Fiction', 1300.00, 9, 2007, 'Penguin', 'English'),
(8, 'Exit West', 'Mohsin Hamid', 'Fiction', 1440.00, 6, 2017, 'Riverhead', 'English'),
(9, 'Atomic Habits', 'James Clear', 'Self Help', 1800.00, 20, 2018, 'Avery', 'English'),
(10, 'The Power of Habit', 'Charles Duhigg', 'Self Help', 1600.00, 11, 2012, 'Random House', 'English'),
(11, 'Sapiens', 'Yuval Harari', 'History', 2200.00, 7, 2011, 'Harper', 'English'),
(12, 'Rich Dead poor Dead', 'Robert Kiyosaki', 'Finance', 1100.00, 25, 1997, 'Plata', 'English'),
(13, 'Abe_e_Hayat', 'Ibn_e_Safi', 'Mystery', 650.00, 18, 1955, 'Asrar', 'Urdu'),
(14, 'Raja Gidh', 'Bano Qudsia', 'Fiction', 900.00, 14, 1981, 'Sang_e_Meel', 'Urdu'),
(15, 'Mystery Title', NULL, 'Mystery', 650.00, 4, 2020, NULL, 'English');


-- Indexes for dumped tables
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`BookID`);
COMMIT;
-- ===============================================================
-- Assesment Questions
-- ===============================================================
-- Q1
SELECT Title, Price
FROM book WHERE
Price>1500;

--Q2
SELECT Title,PublishedYear
FROM book WHERE
PublishedYear BETWEEN
1900 AND 2000
ORDER BY PublishedYear ASC;
--Q3
SELECT *
FROM book
WHERE(Genre='Fiction' OR Genre='Mystery')
AND StokeQty>5;
-- Q4
SELECT Title,Aurthor
FROM book WHERE
Title LIKE %'the'%;
-- Q5
SELECT * FROM book
WHERE Title LIKE 'A%'
OR Title LIKE '%t';
-- Q6
SELECT Title
FROM book
WHERE Aurthor IS NULL;
-- Q7
SELECT * 
FROM book
WHERE StokeQty=0 
OR Publisher IS NULL;
-- Q8
SELECT *
FROM book
WHERE StokeQty>0
ORDER BY Price DESC
LIMIT 3;
-- Q9
SELECT * 
FROM book
WHERE Language='Urdu'
ORDER by PublishedYear ASC;
-- Q10
SELECT * 
FROM book 
WHERE PublishedYear<2000
AND Price>1200
ORDER BY Genre ASC,Title ASC;