CREATE TABLE employees(
    emp_id SERIAL PRIMARY KEY,
    emp_title_id INT,
    birth_date DATE, 
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex VARCHAR(1) CHECK (sex IN ('M','F')),
    hire_date DATE,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);
CREATE TABLE titles(
    title_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE salaries(
    emp_id SERIAL PRIMARY KEY,
    salary INT NOT NULL,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE departments(
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE dept_managers(
    dept_id INT,
    emp_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    PRIMARY KEY (dept_id,emp_id)
);

CREATE TABLE dept_emp(
    emp_id INT,
    dept_id INT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id),
    PRIMARY KEY (emp_id,dept_id)
);


