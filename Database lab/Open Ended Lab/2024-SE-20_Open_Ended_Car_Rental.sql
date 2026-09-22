-- ================================================================
-- DATABASE MANAGEMENT SYSTEM - OPEN-ENDED LAB
-- Car Rental Management System
--================================================================
--2024-SE-20-Open Ended Lab

-- ================================================================
-- PURPOSE
-- Complete implementation of the CarGo Rentals open-ended lab:
-- 1. Database design and implementation
-- 2. Normalization analysis (1NF, 2NF, 3NF)
-- 3. Required JOIN queries
-- 4. Useful VIEW
-- 5. Business-rule TRIGGER
-- 6. Stored procedure for registering a rental
-- 7. Optimization analysis and improved query/design
--

-- ================================================================

DROP DATABASE IF EXISTS CarGo_Rentals;
CREATE DATABASE CarGo_Rentals;
USE CarGo_Rentals;

-- ================================================================
-- SECTION 1: DATABASE DESIGN AND IMPLEMENTATION
-- ================================================================
-- Design rationale:
-- Customer stores customer-specific information.
-- Vehicle stores vehicle-specific information and its current status.
-- Rental stores the business transaction linking a customer and vehicle.
-- Payment stores payment transactions separately to avoid duplication.
--
-- Primary keys uniquely identify records.
-- Foreign keys enforce referential integrity.
-- UNIQUE prevents duplicate phone/email/vehicle registration data.
-- CHECK validates basic business values.
-- DEFAULT supplies sensible values where appropriate.
-- ================================================================

CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE,
    Email VARCHAR(120) UNIQUE,
    CNIC VARCHAR(20) UNIQUE,
    Address VARCHAR(200),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Vehicle (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleNumber VARCHAR(20) NOT NULL UNIQUE,
    VehicleModel VARCHAR(80) NOT NULL,
    VehicleYear YEAR NOT NULL,
    DailyRate DECIMAL(10,2) NOT NULL,
    WeeklyRate DECIMAL(10,2),
    Status ENUM('AVAILABLE','RENTED','MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
    CHECK (DailyRate > 0),
    CHECK (WeeklyRate IS NULL OR WeeklyRate > 0)
);

CREATE TABLE Rental (
    RentalID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    VehicleID INT NOT NULL,
    RentalDate DATE NOT NULL,
    ExpectedReturnDate DATE NOT NULL,
    ActualReturnDate DATE NULL,
    DailyRate DECIMAL(10,2) NOT NULL,
    RentalDays INT NOT NULL,
    RentalCharge DECIMAL(12,2) NOT NULL,
    RentalStatus ENUM('ACTIVE','RETURNED','CANCELLED') NOT NULL DEFAULT 'ACTIVE',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_rental_customer
        FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT fk_rental_vehicle
        FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    CHECK (ExpectedReturnDate >= RentalDate),
    CHECK (ActualReturnDate IS NULL OR ActualReturnDate >= RentalDate),
    CHECK (RentalDays > 0),
    CHECK (RentalCharge >= 0)
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    RentalID INT NOT NULL,
    PaymentDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    Amount DECIMAL(12,2) NOT NULL,
    PaymentMethod ENUM('CASH','CARD','BANK_TRANSFER','ONLINE') NOT NULL,
    PaymentStatus ENUM('PAID','PARTIAL','REFUNDED') NOT NULL DEFAULT 'PAID',
    CONSTRAINT fk_payment_rental
        FOREIGN KEY (RentalID) REFERENCES Rental(RentalID),
    CHECK (Amount > 0)
);

CREATE INDEX idx_rental_customer ON Rental(CustomerID);
CREATE INDEX idx_rental_vehicle_status ON Rental(VehicleID, RentalStatus);
CREATE INDEX idx_rental_dates ON Rental(RentalDate, ExpectedReturnDate);
CREATE INDEX idx_payment_rental ON Payment(RentalID);

-- ================================================================
-- SECTION 2: REALISTIC SAMPLE DATA
-- ================================================================

INSERT INTO Customer (CustomerName, Phone, Email, CNIC, Address) VALUES
('Ali Khan', '0300-1234567', 'ali.khan@example.com', '35202-1111111-1', 'Lahore'),
('Sara Ahmed', '0311-2345678', 'sara.ahmed@example.com', '35202-2222222-2', 'Islamabad'),
('Usman Tariq', '0322-3456789', 'usman.tariq@example.com', '35202-3333333-3', 'Rawalpindi'),
('Ayesha Malik', '0333-4567890', 'ayesha.malik@example.com', '35202-4444444-4', 'Lahore'),
('Hamza Raza', '0344-5678901', 'hamza.raza@example.com', '35202-5555555-5', 'Karachi'),
('Hina Shah', '0355-6789012', 'hina.shah@example.com', '35202-6666666-6', 'Multan'),
('Bilal Ahmed', '0366-7890123', 'bilal.ahmed@example.com', '35202-7777777-7', 'Peshawar');

INSERT INTO Vehicle
(VehicleNumber, VehicleModel, VehicleYear, DailyRate, WeeklyRate, Status) VALUES
('ABC-123', 'Toyota Corolla', 2023, 5000, 30000, 'AVAILABLE'),
('LEA-456', 'Honda Civic', 2024, 6500, 39000, 'AVAILABLE'),
('ISB-789', 'Suzuki Swift', 2022, 4000, 24000, 'AVAILABLE'),
('RWP-321', 'Toyota Yaris', 2024, 5500, 33000, 'AVAILABLE'),
('KHI-654', 'Honda City', 2023, 4800, 28800, 'AVAILABLE'),
('MUX-987', 'Kia Sportage', 2024, 9000, 54000, 'AVAILABLE'),
('PSH-147', 'Toyota Fortuner', 2022, 12000, 72000, 'MAINTENANCE');

INSERT INTO Rental
(CustomerID, VehicleID, RentalDate, ExpectedReturnDate, ActualReturnDate,
 DailyRate, RentalDays, RentalCharge, RentalStatus) VALUES
(1, 1, '2026-09-01', '2026-09-04', '2026-09-04', 5000, 3, 15000, 'RETURNED'),
(2, 2, '2026-09-03', '2026-09-07', '2026-09-07', 6500, 4, 26000, 'RETURNED'),
(3, 3, '2026-09-05', '2026-09-08', NULL, 4000, 3, 12000, 'ACTIVE'),
(1, 4, '2026-09-06', '2026-09-10', NULL, 5500, 4, 22000, 'ACTIVE'),
(4, 5, '2026-08-20', '2026-08-23', '2026-08-23', 4800, 3, 14400, 'RETURNED'),
(5, 6, '2026-08-25', '2026-08-28', '2026-08-28', 9000, 3, 27000, 'RETURNED');

UPDATE Vehicle
SET Status = 'RENTED'
WHERE VehicleID IN (
    SELECT VehicleID
    FROM Rental
    WHERE RentalStatus = 'ACTIVE'
);

INSERT INTO Payment (RentalID, PaymentDate, Amount, PaymentMethod, PaymentStatus) VALUES
(1, '2026-09-04', 15000, 'CASH', 'PAID'),
(2, '2026-09-07', 26000, 'CARD', 'PAID'),
(3, '2026-09-05', 12000, 'ONLINE', 'PAID'),
(4, '2026-09-06', 10000, 'BANK_TRANSFER', 'PARTIAL'),
(5, '2026-08-23', 14400, 'CASH', 'PAID'),
(6, '2026-08-28', 27000, 'CARD', 'PAID');

-- ================================================================
-- SECTION 3: NORMALIZATION ANALYSIS
-- ================================================================
-- Original unnormalized single-record structure:
--
-- RentalID, CustomerName, CustomerPhone, VehicleNumber, VehicleModel,
-- DailyRate, RentalDate, ReturnDate, PaymentAmount
--
-- Example:
-- R001 | Ali Khan | 0300-1234567 | ABC-123 | Toyota Corolla |
-- 5000 | 2026-09-01 | 2026-09-04 | 15000
--
-- 1NF:
-- - Keep each field atomic.
-- - Each rental is represented by one row.
-- - No repeating groups or multi-valued fields.
--
-- 2NF:
-- - Separate attributes that depend on different entities.
-- - CustomerName/CustomerPhone depend on Customer.
-- - VehicleModel/DailyRate depend on Vehicle.
-- - Rental dates/payment belong to the rental transaction.
-- - This removes partial dependency/repetition when rental data grows.
--
-- 3NF:
-- - Remove transitive dependencies.
-- - Customer details are stored only in Customer.
-- - Vehicle details/rates are stored only in Vehicle.
-- - Rental references Customer and Vehicle using foreign keys.
-- - Payment is separated because payment is a transaction related to Rental.
--
-- The implemented tables Customer, Vehicle, Rental, and Payment therefore
-- reduce update, insertion, and deletion anomalies while improving integrity.

-- ================================================================
-- SECTION 4: TASK 3 - REQUIRED JOIN QUERIES
-- ================================================================

SELECT
    c.CustomerName,
    v.VehicleNumber,
    v.VehicleModel,
    r.RentalDate,
    COALESCE(r.ActualReturnDate, r.ExpectedReturnDate) AS ReturnDate
FROM Rental r
INNER JOIN Customer c ON r.CustomerID = c.CustomerID
INNER JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY r.RentalDate;


SELECT
    c.CustomerName,
    v.VehicleNumber,
    v.VehicleModel,
    r.RentalDate,
    r.RentalStatus
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
LEFT JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY c.CustomerName, r.RentalDate;

SELECT
    v.VehicleNumber,
    v.VehicleModel,
    v.Status AS VehicleStatus,
    c.CustomerName,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.RentalStatus
FROM Vehicle v
LEFT JOIN Rental r
    ON v.VehicleID = r.VehicleID
   AND r.RentalStatus = 'ACTIVE'
LEFT JOIN Customer c ON r.CustomerID = c.CustomerID
ORDER BY v.VehicleNumber;


SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(r.RentalID) AS TotalRentals
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRentals DESC, c.CustomerName;

-- ================================================================
-- SECTION 5: TASK 4 - VIEW
-- ================================================================
-- The view consolidates customer, vehicle, rental and payment data.
-- It is useful for management reports because users can query one
-- reusable object instead of repeating several JOIN operations.

DROP VIEW IF EXISTS vw_RentalReport;

CREATE VIEW vw_RentalReport AS
SELECT
    r.RentalID,
    c.CustomerID,
    c.CustomerName,
    c.Phone,
    v.VehicleNumber,
    v.VehicleModel,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.ActualReturnDate,
    r.RentalDays,
    r.RentalCharge,
    r.RentalStatus,
    COALESCE(SUM(p.Amount), 0) AS AmountPaid,
    r.RentalCharge - COALESCE(SUM(p.Amount), 0) AS Balance
FROM Rental r
JOIN Customer c ON r.CustomerID = c.CustomerID
JOIN Vehicle v ON r.VehicleID = v.VehicleID
LEFT JOIN Payment p ON r.RentalID = p.RentalID
GROUP BY
    r.RentalID, c.CustomerID, c.CustomerName, c.Phone,
    v.VehicleNumber, v.VehicleModel, r.RentalDate,
    r.ExpectedReturnDate, r.ActualReturnDate, r.RentalDays,
    r.RentalCharge, r.RentalStatus;

-- Test the view.
SELECT * FROM vw_RentalReport
ORDER BY RentalID;

-- ================================================================
-- SECTION 6: TRIGGER
-- ================================================================
-- Business rule: a vehicle must not be rented while another rental
-- for the same vehicle is already active.
--
-- This trigger prevents an invalid second active rental before data
-- is inserted. It supports the scenario requirement that a vehicle
-- cannot be available for another rental while already rented.

DROP TRIGGER IF EXISTS trg_PreventDoubleRental;

DELIMITER $$

CREATE TRIGGER trg_PreventDoubleRental
BEFORE INSERT ON Rental
FOR EACH ROW
BEGIN
    IF NEW.RentalStatus = 'ACTIVE'
       AND EXISTS (
           SELECT 1
           FROM Rental
           WHERE VehicleID = NEW.VehicleID
             AND RentalStatus = 'ACTIVE'
       )
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is already rented and cannot be assigned to another active rental.';
    END IF;
END$$

DELIMITER ;

-- Trigger demonstration:
-- The following statement is intentionally commented because it should
-- fail when executed for a vehicle that already has an ACTIVE rental.
--
-- INSERT INTO Rental
-- (CustomerID, VehicleID, RentalDate, ExpectedReturnDate, DailyRate,
--  RentalDays, RentalCharge, RentalStatus)
-- VALUES (6, 3, '2026-09-10', '2026-09-12', 4000, 2, 8000, 'ACTIVE');

-- ================================================================
-- SECTION 7: TASK 6 - STORED PROCEDURE
-- ================================================================
-- Procedure: RegisterRental
-- Inputs:
--   p_customer_id  - customer receiving the vehicle
--   p_vehicle_id   - vehicle being rented
--   p_rental_date  - start date
--   p_return_date  - expected return date
--
-- Processing:
--   1. Validate customer and vehicle.
--   2. Ensure return date is not before rental date.
--   3. Ensure vehicle is available.
--   4. Read the vehicle daily rate.
--   5. Calculate rental days.
--   6. Calculate total rental charge.
--   7. Insert the rental.
--   8. Mark the vehicle as RENTED.
--   9. Return the new rental details.

DROP PROCEDURE IF EXISTS RegisterRental;

DELIMITER $$

CREATE PROCEDURE RegisterRental(
    IN p_customer_id INT,
    IN p_vehicle_id INT,
    IN p_rental_date DATE,
    IN p_return_date DATE
)
BEGIN
    DECLARE v_daily_rate DECIMAL(10,2);
    DECLARE v_days INT;
    DECLARE v_charge DECIMAL(12,2);
    DECLARE v_status VARCHAR(20);
    DECLARE v_new_rental_id INT;

    IF NOT EXISTS (
        SELECT 1 FROM Customer WHERE CustomerID = p_customer_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Vehicle WHERE VehicleID = p_vehicle_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle does not exist.';
    END IF;

    IF p_return_date < p_rental_date THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Expected return date cannot be before rental date.';
    END IF;

    SELECT DailyRate, Status
    INTO v_daily_rate, v_status
    FROM Vehicle
    WHERE VehicleID = p_vehicle_id;

    IF v_status <> 'AVAILABLE' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is not available for rental.';
    END IF;

    SET v_days = DATEDIFF(p_return_date, p_rental_date);

    -- A same-day rental is charged as one rental day.
    IF v_days <= 0 THEN
        SET v_days = 1;
    END IF;

    SET v_charge = v_days * v_daily_rate;

    INSERT INTO Rental
    (CustomerID, VehicleID, RentalDate, ExpectedReturnDate,
     DailyRate, RentalDays, RentalCharge, RentalStatus)
    VALUES
    (p_customer_id, p_vehicle_id, p_rental_date, p_return_date,
     v_daily_rate, v_days, v_charge, 'ACTIVE');

    SET v_new_rental_id = LAST_INSERT_ID();

    UPDATE Vehicle
    SET Status = 'RENTED'
    WHERE VehicleID = p_vehicle_id;

    SELECT
        v_new_rental_id AS RentalID,
        p_customer_id AS CustomerID,
        p_vehicle_id AS VehicleID,
        p_rental_date AS RentalDate,
        p_return_date AS ExpectedReturnDate,
        v_days AS RentalDays,
        v_daily_rate AS DailyRate,
        v_charge AS RentalCharge,
        'ACTIVE' AS RentalStatus;
END$$

DELIMITER ;

-- Procedure demonstration using available vehicle 1.
-- This creates an additional sample rental when executed.
-- Uncomment to test:
--
-- CALL RegisterRental(6, 1, '2026-09-15', '2026-09-18');
--
-- Verify:
-- SELECT * FROM vw_RentalReport WHERE RentalID = LAST_INSERT_ID();

-- ================================================================
-- SECTION 8: RETURN OPERATION / DATA CONSISTENCY SUPPORT
-- ================================================================
-- This example shows how an active rental can be returned and the
-- vehicle made available again.

-- Example only; execute against an actual active RentalID:
--
-- START TRANSACTION;
-- UPDATE Rental
-- SET ActualReturnDate = '2026-09-08',
--     RentalStatus = 'RETURNED'
-- WHERE RentalID = 3 AND RentalStatus = 'ACTIVE';
--
-- UPDATE Vehicle
-- SET Status = 'AVAILABLE'
-- WHERE VehicleID = (
--     SELECT VehicleID FROM Rental WHERE RentalID = 3
-- );
-- COMMIT;

-- ================================================================
-- SECTION 9: TASK 7 - OPTIMIZATION ANALYSIS
-- ================================================================
-- Potential inefficiency:
-- Repeatedly joining Rental, Customer, Vehicle and Payment and
-- recalculating payment totals can become expensive as the data grows.
--
-- Improvement:
-- 1. Use indexes on foreign-key and frequently filtered columns.
-- 2. The schema already includes indexes for Rental.CustomerID,
--    Rental.VehicleID/RentalStatus, rental dates, and Payment.RentalID.
-- 3. Reuse vw_RentalReport for common consolidated reporting.
--
-- Example of a less selective query:
-- SELECT * FROM Rental r JOIN Customer c ON r.CustomerID=c.CustomerID;
--
-- Improved query when only active rentals are required:
SELECT
    r.RentalID,
    c.CustomerName,
    v.VehicleNumber,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.RentalCharge
FROM Rental r
JOIN Customer c ON r.CustomerID = c.CustomerID
JOIN Vehicle v ON r.VehicleID = v.VehicleID
WHERE r.RentalStatus = 'ACTIVE'
ORDER BY r.ExpectedReturnDate;

-- EXPLAIN can be used to inspect the execution plan:
EXPLAIN
SELECT
    r.RentalID,
    c.CustomerName,
    v.VehicleNumber,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.RentalCharge
FROM Rental r
JOIN Customer c ON r.CustomerID = c.CustomerID
JOIN Vehicle v ON r.VehicleID = v.VehicleID
WHERE r.RentalStatus = 'ACTIVE';

-- ================================================================
-- SECTION 10: ADDITIONAL MANAGEMENT REPORTS
-- ================================================================
SELECT
    c.CustomerName,
    r.RentalID,
    v.VehicleNumber,
    v.VehicleModel,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.ActualReturnDate,
    r.RentalCharge,
    r.RentalStatus
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
LEFT JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY c.CustomerName, r.RentalDate;

SELECT
    v.VehicleNumber,
    v.VehicleModel,
    c.CustomerName,
    r.RentalDate,
    r.ExpectedReturnDate,
    r.RentalCharge
FROM Vehicle v
JOIN Rental r ON v.VehicleID = r.VehicleID
JOIN Customer c ON r.CustomerID = c.CustomerID
WHERE r.RentalStatus = 'ACTIVE';

SELECT
    v.VehicleNumber,
    v.VehicleModel,
    COUNT(r.RentalID) AS TotalRentals,
    COALESCE(SUM(r.RentalDays), 0) AS TotalRentalDays,
    COALESCE(SUM(r.RentalCharge), 0) AS TotalRevenue
FROM Vehicle v
LEFT JOIN Rental r ON v.VehicleID = r.VehicleID
GROUP BY v.VehicleID, v.VehicleNumber, v.VehicleModel
ORDER BY TotalRentals DESC, v.VehicleNumber;


