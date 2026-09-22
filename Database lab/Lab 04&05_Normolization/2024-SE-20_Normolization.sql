--=============================================================
--2024-SE-20-Normolization.sql
--=============================================================
-- Database Systems  Database Normalization
-- ============================================================

CREATE DATABASE IF NOT EXISTS bookstore_normalization_lab;
USE bookstore_normalization_lab;


DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Student;

-- ============================================================
-- 3NF DESIGN
-- ============================================================
-- StudentID -> StudentName, StudentEmail
-- BookID -> BookTitle, PublisherID, UnitPrice
-- PublisherID -> PublisherName
-- OrderID -> OrderDate, CustomerID
-- CustomerID -> CustomerName, CustomerEmail
-- (OrderID, BookID) -> Qty
--
-- Transitive dependency removed:
-- BookID -> PublisherID -> PublisherName

CREATE TABLE Student (
    StudentID VARCHAR(10) PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- The bookstore task is implemented below according to the raw
-- bookstore data in the manual.

DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    CustID VARCHAR(10) PRIMARY KEY,
    CustName VARCHAR(100) NOT NULL,
    CustEmail VARCHAR(150) NOT NULL
);

CREATE TABLE Publisher (
    PublisherID VARCHAR(10) PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(150) NOT NULL,
    PublisherID VARCHAR(10) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

CREATE TABLE `Order` (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE OrderItem (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- ============================================================
-- LOAD DATA
-- ============================================================

INSERT INTO Customer (CustID, CustName, CustEmail) VALUES
('C-11', 'Bilal', 'bilal@x.com'),
('C-12', 'Areeba', 'areeba@x.com');

INSERT INTO Publisher (PublisherID, PublisherName) VALUES
('PUB-01', 'Pearson'),
('PUB-02', 'OReilly');

INSERT INTO Book (BookID, BookTitle, PublisherID, UnitPrice) VALUES
('B-1', 'SQL Basics', 'PUB-01', 1200),
('B-2', 'Python 101', 'PUB-02', 1500),
('B-3', 'Networks', 'PUB-01', 1800);

INSERT INTO `Order` (OrderID, OrderDate, CustID) VALUES
('O-501', '2026-04-02', 'C-11'),
('O-502', '2026-04-03', 'C-12'),
('O-503', '2026-04-05', 'C-11');

INSERT INTO OrderItem (OrderID, BookID, Qty) VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);

-- ============================================================
-- VERIFICATION OF 3NF STRUCTURE
-- ============================================================
SHOW TABLES;
DESCRIBE Customer;
DESCRIBE Publisher;
DESCRIBE Book;
DESCRIBE `Order`;
DESCRIBE OrderItem;


CREATE DATABASE IF NOT EXISTS bookstore_normalization_lab;
USE bookstore_normalization_lab;

-- This setup makes Task 5 independently runnable.

DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS `Order`;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Publisher;
DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    CustID VARCHAR(10) PRIMARY KEY,
    CustName VARCHAR(100) NOT NULL,
    CustEmail VARCHAR(150) NOT NULL
);

CREATE TABLE Publisher (
    PublisherID VARCHAR(10) PRIMARY KEY,
    PublisherName VARCHAR(100) NOT NULL
);

CREATE TABLE Book (
    BookID VARCHAR(10) PRIMARY KEY,
    BookTitle VARCHAR(150) NOT NULL,
    PublisherID VARCHAR(10) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

CREATE TABLE `Order` (
    OrderID VARCHAR(10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustID VARCHAR(10) NOT NULL,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE OrderItem (
    OrderID VARCHAR(10) NOT NULL,
    BookID VARCHAR(10) NOT NULL,
    Qty INT NOT NULL,
    PRIMARY KEY (OrderID, BookID),
    FOREIGN KEY (OrderID) REFERENCES `Order`(OrderID),
    FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

INSERT INTO Customer VALUES
('C-11', 'Bilal', 'bilal@x.com'),
('C-12', 'Areeba', 'areeba@x.com');

INSERT INTO Publisher VALUES
('PUB-01', 'Pearson'),
('PUB-02', 'OReilly');

INSERT INTO Book VALUES
('B-1', 'SQL Basics', 'PUB-01', 1200),
('B-2', 'Python 101', 'PUB-02', 1500),
('B-3', 'Networks', 'PUB-01', 1800);

INSERT INTO `Order` VALUES
('O-501', '2026-04-02', 'C-11'),
('O-502', '2026-04-03', 'C-12'),
('O-503', '2026-04-05', 'C-11');

INSERT INTO OrderItem VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-3', 1),
('O-503', 'B-2', 1);

-- ============================================================
-- QUERY 1: Original report — one row per book purchased
-- ============================================================
SELECT
    o.OrderID,
    o.OrderDate,
    c.CustID,
    c.CustName,
    c.CustEmail,
    b.BookID,
    b.BookTitle,
    p.PublisherName,
    b.UnitPrice,
    oi.Qty,
    (b.UnitPrice * oi.Qty) AS LineTotal
FROM `Order` AS o
JOIN Customer AS c ON o.CustID = c.CustID
JOIN OrderItem AS oi ON o.OrderID = oi.OrderID
JOIN Book AS b ON oi.BookID = b.BookID
JOIN Publisher AS p ON b.PublisherID = p.PublisherID
ORDER BY o.OrderID, b.BookID;

-- ============================================================
-- QUERY 2: Every customer's total spend
-- ============================================================
SELECT
    c.CustID,
    c.CustName,
    c.CustEmail,
    COALESCE(SUM(b.UnitPrice * oi.Qty), 0) AS TotalSpend
FROM Customer AS c
LEFT JOIN `Order` AS o ON c.CustID = o.CustID
LEFT JOIN OrderItem AS oi ON o.OrderID = oi.OrderID
LEFT JOIN Book AS b ON oi.BookID = b.BookID
GROUP BY c.CustID, c.CustName, c.CustEmail
ORDER BY c.CustID;
