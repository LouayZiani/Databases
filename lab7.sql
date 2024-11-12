CREATE DATABASE lab7;

CREATE TABLE countries(
	country_id SERIAL,
	country_name VARCHAR(50)
);

INSERT INTO countries(country_name) 
VALUES ('Morocco'), ('USA'), ('Kazakhstan'), ('Argentina');

SELECT * FROM countries;

CREATE TABLE departments(
	department_id SERIAL PRIMARY KEY,
	department_name VARCHAR(50),
	budget INTEGER
);

INSERT INTO departments(department_name, budget)
VALUES ('Finance', 4000),
('Human Resources', 2000),
('Sales', 6000);

SELECT * FROM departments;

CREATE TABLE employees(
	employee_id SERIAL,
	employee_name VARCHAR(50),
	employee_surname VARCHAR(50),
	employee_salary INTEGER,
	department_id INTEGER REFERENCES departments
);

INSERT INTO employees(employee_name, employee_salary, department_id)
VALUES ('Jonathan Kirk', 500, 1),
('Sammy', 1000, 3),
('Jaythan', 2000, 2);

SELECT * FROM employees;

-- 1
CREATE INDEX index_country_name ON countries(country_name);


-- 2
CREATE INDEX index_emp_full_name ON employees(employee_name, employee_surname);


-- 3
CREATE UNIQUE INDEX index_emp_salary ON employees(employee_salary);


-- 4
CREATE INDEX index_sub_name ON employees(SUBSTRING(employee_surname from 1 for 4));


-- 5
CREATE INDEX index_depts_budg_salary ON employees(department_id, employee_salary);
CREATE INDEX index_depts_budg ON departments(budget);