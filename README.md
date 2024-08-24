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
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE,
    birth_date DATE,
    sex CHAR(1)
);

CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE titles (
    title_id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

CREATE TABLE salaries (
    emp_id INT REFERENCES employees(emp_id),
    salary DECIMAL(10, 2),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, start_date)
);

CREATE TABLE dept_emp (
    emp_id INT REFERENCES employees(emp_id),
    dept_id INT REFERENCES departments(dept_id),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, dept_id, start_date)
);

CREATE TABLE emp_titles (
    emp_id INT REFERENCES employees(emp_id),
    title_id INT REFERENCES titles(title_id),
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (emp_id, title_id, start_date)
);