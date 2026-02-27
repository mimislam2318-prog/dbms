-- =========================================
-- CREATE DATABASE
-- =========================================
CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

-- =========================================
-- DROP TABLES (Child First)
-- =========================================
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Designation;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Salary_Structure;
DROP TABLE IF EXISTS Department;

-- =========================================
-- CREATE TABLES
-- =========================================

CREATE TABLE Department (
    Dept_id INT AUTO_INCREMENT PRIMARY KEY,
    Dept_name VARCHAR(100) NOT NULL,
    Location VARCHAR(100),
    Manager VARCHAR(100),
    Dept_phone VARCHAR(20)
) ENGINE=InnoDB;

CREATE TABLE Salary_Structure (
    Structure_id INT AUTO_INCREMENT PRIMARY KEY,
    Basic_salary DECIMAL(10,2) NOT NULL,
    Allowance DECIMAL(10,2) DEFAULT 0,
    Deduction DECIMAL(10,2) DEFAULT 0
) ENGINE=InnoDB;

CREATE TABLE Employee (
    Emp_id INT AUTO_INCREMENT PRIMARY KEY,
    Emp_name VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female','Other'),
    Phone VARCHAR(20),
    Dept_id INT,
    Structure_id INT,
    FOREIGN KEY (Dept_id) 
        REFERENCES Department(Dept_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    FOREIGN KEY (Structure_id) 
        REFERENCES Salary_Structure(Structure_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Designation (
    Design_id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100),
    Level VARCHAR(50),
    Basic_salary DECIMAL(10,2),
    Emp_id INT UNIQUE,
    FOREIGN KEY (Emp_id) 
        REFERENCES Employee(Emp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE Attendance (
    Attend_id INT AUTO_INCREMENT PRIMARY KEY,
    Date DATE,
    Status ENUM('Present','Absent','Late'),
    Working_hours INT,
    Emp_id INT,
    FOREIGN KEY (Emp_id) 
        REFERENCES Employee(Emp_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB;

-- =========================================
-- INSERT DATA
-- =========================================

-- Department
INSERT INTO Department (Dept_name, Location, Manager, Dept_phone) VALUES
('HR', 'Dhaka', 'Karim Hasan', '01711111111'),
('IT', 'Khulna', 'Rahim Uddin', '01722222222'),
('Finance', 'Dhaka', 'Nusrat Jahan', '01733333333'),
('Marketing', 'Chittagong', 'Arif Hossain', '01744444444'),
('Admin', 'Khulna', 'Sadia Islam', '01755555555');

-- Salary Structure
INSERT INTO Salary_Structure (Basic_salary, v, Deduction) VALUES
(20000, 5000, 2000),
(30000, 7000, 3000),
(25000, 6000, 2500),
(40000, 10000, 5000),
(35000, 8000, 3500);

-- Employee
INSERT INTO Employee (Emp_name, Gender, Phone, Dept_id, Structure_id) VALUES
('Arafat Khan', 'Male', '01811111111', 1, 1),
('Mim Akter', 'Female', '01822222222', 2, 2),
('Tanvir Islam', 'Male', '01833333333', 3, 3),
('Sumaiya Rahman', 'Female', '01844444444', 4, 4),
('Sabbir Ahmed', 'Male', '01855555555', 5, 5);

-- Designation
INSERT INTO Designation (Title, Level, Basic_salary, Emp_id) VALUES
('HR Officer', 'Junior', 20000, 1),
('Software Engineer', 'Mid', 30000, 2),
('Accountant', 'Mid', 25000, 3),
('Marketing Manager', 'Senior', 40000, 4),
('Admin Officer', 'Junior', 35000, 5);

-- Attendance
INSERT INTO Attendance (Date, Status, Working_hours, Emp_id) VALUES
('2025-01-01', 'Present', 8, 1),
('2025-01-01', 'Present', 9, 2),
('2025-01-01', 'Absent', 0, 3),
('2025-01-01', 'Present', 8, 4),
('2025-01-01', 'Late', 6, 5);

-- =========================================
-- TEST QUERIES
-- =========================================
SELECT * FROM Department;
SELECT * FROM Salary_Structure;
SELECT * FROM Employee;
SELECT * FROM Designation;
SELECT * FROM Attendance;

select Basic_salary, Phone,Allowance,Emp_name
from employee 
 natural join salary_structure
where Emp_name='Mim Akter';



