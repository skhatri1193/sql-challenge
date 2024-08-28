## EmployeeSQL Overview

This project involves designing and implementing a SQL database to manage employee data for Pewlett Hackard, a fictional company. The database is populated with data from CSV files representing employee information from the 1980s and 1990s. The project includes data modeling, data engineering, and data analysis.

## Table of Contents

- [EmployeeSQL Overview](#employeesql-overview)
- [CSV Files](#csv-files)
- [Database Schema](#database-schema)
- [Data Analysis Queries](#data-analysis-queries)

## CSV Files

The project includes the following CSV files:

1. `employees.csv` - Contains employee details (e.g., ID, name, hire date).
2. `departments.csv` - Contains department details (e.g., ID, name).
3. `titles.csv` - Contains title details (e.g., ID, title).
4. `salaries.csv` - Contains salary information (e.g., employee ID, salary, dates).
5. `dept_emp.csv` - Contains department-employee assignments (e.g., employee ID, department ID, dates).
6. `dept_managers.csv` - Contains department managers(e.g., department, employee ID).

## Data Analysis Queries
```sql
/* 1. List the employee number, last name, first name, 
   sex, and salary of each employee.*/

SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
  FROM employees e
  JOIN salaries s
    ON e.emp_no = s.emp_no;


/* 2. List the first name, last name, and hire date 
      for the employees who were hired in 1986.*/

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

/* 3. List the manager of each department along with their 
      department number, department name, employee number, 
      last name, and first name. */

SELECT d.dept_no, d.dept_name, dm.emp_no, e.first_name, e.last_name
  FROM departments d
  JOIN dept_managers dm
    ON d.dept_no = dm.dept_no
  JOIN employees e
    ON dm.emp_no = e.emp_no;

/* 4. List the department number for each employee along with that 
      employee’s employee number, last name, first name,
	  and department name.*/
	  
SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
  FROM dept_emp de
  JOIN employees e
    ON de.emp_no = e.emp_no
  JOIN departments d
    ON de.dept_no = d.dept_no;

/* 5. List first name, last name, and sex of each employee whose 
      first name is Hercules and whose last name begins 
	  with the letter B. */
	  
SELECT first_name, last_name, sex
  FROM employees
 WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

/* 6. List each employee in the Sales department, including their
      employee number, last name, and first name. */

SELECT e.emp_no, e.first_name, e.last_name
  FROM employees e
  JOIN dept_emp de
    ON e.emp_no = de.emp_no
  JOIN departments d
    ON de.dept_no = d.dept_no
 WHERE d.dept_name = 'Sales';

/* 7. List each employee in the Sales and Development departments, 
      including their employee number, last name, first name,
	  and department name. */

SELECT e.emp_no, e.first_name, e.last_name, d.dept_name
  FROM employees e
  JOIN dept_emp de
    ON e.emp_no = de.emp_no
  JOIN departments d
    ON de.dept_no = d.dept_no
 WHERE d.dept_name IN ('Sales','Development');

/* 8. List the frequency counts, in descending order, 
      of all the employee last names (that is, how many 
	  employees share each last name) */

SELECT last_name, COUNT(*) AS frequency
  FROM employees
GROUP BY last_name
ORDER BY frequency DESC;
```

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
```