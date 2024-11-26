CREATE DATABASE lab9;

-- 1/ Write a stored procedure named increase_value that takes one integer parameter and returns 
-- the parameter value increased by 10

CREATE OR REPLACE PROCEDURE increase_value(INOUT num INTEGER)
LANGUAGE plpgsql AS $$
BEGIN
    num := num + 10;
END;
$$;

-- 2/ Create a stored procedure compare_numbers that takes two integers and returns 'Greater', 'Equal', 
-- or ‘Lesser' as an out parameter, depending on the comparison result of these two numbers


CREATE OR REPLACE PROCEDURE compare_numbers(num1 INTEGER, num2 INTEGER, OUT resultat VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
    IF num1 > num2 THEN
        resultat := 'Greater';
    ELSIF num1 = num2 THEN
        resultat := 'Equal';
    ELSE
        resultat := 'Lesser';
    END IF;
END;
$$;

-- 3/ Write a stored procedure number_series that takes an integer n 
-- and returns a series from 1 to n. Use a looping construct within 
-- the procedure.

CREATE OR REPLACE PROCEDURE number_series (n INTEGER,
										  OUT series TEXT)
LANGUAGE plpgsql AS $$
DECLARE 
	i INTEGER := 1;
BEGIN
	series := '';
	WHILE i<=n LOOP
		series := series || i || CASE WHEN i<n THEN ',' ELSE '' END;
		
		i := i + 1;
		
	END LOOP;
END; 
$$

-- 4/ Write a stored procedure find_employee that takes a
-- employee name as a parameter and returns the employee 
-- details by performing a query.
	
-- i supposed this is the employee table
CREATE TABLE employee(
    emp_id INTEGER,
    emp_name VARCHAR(50),
    emp_job VARCHAR(50),
    emp_salary INTEGER
);

CREATE OR REPLACE PROCEDURE find_employee (employee_name VARCHAR,
										  OUT employee_details VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
	SELECT CONCAT('ID: ', emp_id, ', Name: ', emp_name, ', Job: ', emp_job)
    INTO emp_details
    FROM employee
    WHERE emp_name = employee_name;
END;
$$

--5/ Develop a stored procedure list_products that returns a table 
--with product details from a given category.

--I didn't suppose a table here, because i will create a temp tble))
CREATE OR REPLACE list_products (category VARCHAR)
LANGUAGE plpgsql AS $$
BEGIN
	CREATE TEMPORARY TABLE temp_prods AS
	SELECT prod_id, prod_name, prod_price, prod_category
	FROM products
	WHERE prod_category = category;
END;
$$
--I will create a function, since stored procedures DON'T RETURN tables, instead we can only store em 
-- in temp tables or raise noticem this function will actually return our resulting table:

-- CREATE OR REPLACE FUNCTION list_products(category_name TEXT)
-- RETURNS TABLE(id INT, name TEXT, price NUMERIC, category TEXT) AS $$
-- BEGIN
--     RETURN QUERY
--     SELECT prod_id, prod_name, prod_price, prod_category
-- 	FROM products
-- 	WHERE prod_category = category;
-- END;
-- $$ LANGUAGE plpgsql;
		
		
-- 6/  Create two stored procedures where the first procedure call
-- the second one. For example, a procedure calculate_bonus 
-- that calculates a bonus, and another procedure update_salary 
-- that uses calculate_bonus to update the salary of an employee.

--I can't create procedure for this, so i created function instead since we will have to query
-- the first function into the second, which can't be done by procedures only functions
CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INTEGER
										   OUT bonus INTEGER)
RETURNS NUMERIC AS $$
DECLARE
    bonus INTEGER;
BEGIN
    SELECT salary * 0.2 INTO bonus FROM employees WHERE emp_id = employee_id;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql


CREATE OR REPLACE FUNCTION update_salary(employee_id INTEGER)
RETURNS VOID AS $$
DECLARE
    bonus INTEGER;
BEGIN
    bonus := calculate_bonus(employee_id);
    UPDATE employees SET salary = salary + bonus WHERE emp_id = employee_id;
END;
$$

-- 7/ Write a stored procedure named complex_calculation.
-- • The procedure should accept multiple parameters of various 
-- types (e.g., INTEGER, VARCHAR).
-- • The main block should include at least two nested subblocks.
-- • Each subblock should perform a distinct operation (e.g., a 
-- string manipulation and a numeric computation).
-- • The main block should then combine results from these 
-- subblocks in some way.
-- • Return a final result that depends on both subblocks' output
-- • Use labels to differentiate the main block and subblocks

CREATE OR REPLACE PROCEDURE complex_calculation(numero INTEGER, test VARCHAR, OUT final_result TEXT)
LANGUAGE plpgsql AS $$
DECLARE
    num_result INTEGER;
    str_result TEXT;
BEGIN
    -- main_block
    -- main blk will combine results from the 2 subblocks
    main_block:

    -- 1st subblock: Numeric computation , labe: num_subblock
    num_subblock:
    BEGIN
        -- Numeric computation:
        num_result := numero * 10;
        RAISE NOTICE 'Numeric result: %', num_result;
    END num_subblock;

    -- 2nd subblock: String manipulation, labe: str_subblock
    str_subblock:
    BEGIN
        -- String manipulation:
        str_result := 'Hello, Mr ' || test;
        RAISE NOTICE 'String result: %', str_result;
    END str_subblock;

    -- Combining results
    final_result := str_result || ' Result: ' || num_result;

END main_block;
$$;
