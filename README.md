## EmployeeSQL Overview

This project involves designing and implementing a SQL database to manage employee data for Pewlett Hackard, a fictional company. The database is populated with data from CSV files representing employee information from the 1980s and 1990s. The project includes data modeling, data engineering, and data analysis.

## Table of Contents

- [EmployeeSQL Overview](#employeesql-overview)
- [CSV Files](#csv-files)
- [Database Schema](#database-schema)

## CSV Files

The project includes the following CSV files:

1. `employees.csv` - Contains employee details (e.g., ID, name, hire date).
2. `departments.csv` - Contains department details (e.g., ID, name).
3. `titles.csv` - Contains title details (e.g., ID, title).
4. `salaries.csv` - Contains salary information (e.g., employee ID, salary, dates).
5. `dept_emp.csv` - Contains department-employee assignments (e.g., employee ID, department ID, dates).
6. `emp_titles.csv` - Contains employee titles (e.g., employee ID, title ID, dates).

## Database Schema

The SQL schema for the project includes the following tables:

```sql
-- Create Table Schema
CREATE TABLE titles(
    title_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE employees(
    emp_no INT PRIMARY KEY,
    emp_title_id VARCHAR(20),
    birth_date TEXT, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(1) CHECK (sex IN ('M','F')),
    hire_date TEXT,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
CREATE TABLE salaries(
    emp_no INT PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE departments(
    dept_no VARCHAR(20) PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dept_managers(
    dept_no VARCHAR(20),
    emp_no INT,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no,emp_no)
);

CREATE TABLE dept_emp(
    emp_no INT,
    dept_no VARCHAR(20),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no,dept_no)
);

--Convert Data in order to perform efficient time based queries
ALTER TABLE employees
ADD COLUMN hire_date_converted DATE,
ADD COLUMN birth_date_coverted DATE;
UPDATE employees
SET hire_date_converted = TO_DATE(hire_date, 'MM/DD/YYYY');
UPDATE employees
SET birth_date_converted = TO_DATE(birth_date, 'MM/DD/YYYY');

-- Check to see if dates were converted correctly
SELECT hire_date, hire_date_converted, birth_date, birth_date_converted
FROM employees
LIMIT 10;

--Drop old date column and rename converted column
ALTER TABLE employees
DROP COLUMN hire_date,
DROP COLUMN birth_date;
ALTER TABLE employees
RENAME COLUMN hire_date_converted TO hire_date,
ALTER TABLE
RENAME COLUMN birth_date_converted TO birth_date;