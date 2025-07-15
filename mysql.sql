CREATE DATABASE myDB;

# how to make database read only
-- ALTER DATABASE myDB READ ONLY = 0;

-- Selecting Database to work
use myDB;

-- Creating Employees table
CREATE TABLE employees (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5 , 2),
    hire_date DATE
);

-- displaying the table data
SELECT * FROM employees;

# Rename the table
RENAME TABLE workers to employees;

-- Adding New Column 
ALTER TABLE employees
ADD phone_number VARCHAR(15);

-- Modify column changing the data type
ALTER TABLE employees
MODIFY email VARCHAR(100);

-- Rename the column 
ALTER TABLE employees
RENAME COLUMN phone_number to email;

-- Getting internal structure of Table
DESC employees;

-- move the column email after the last name
ALTER TABLE employees
MODIFY email VARCHAR(100)
AFTER last_name;

-- Drop the column
ALTER TABLE employees
DROP column email;

-- Insert a row into the table
INSERT INTO employees
VALUES (1, "Eugene", "Krabs", 25.50, "2023-01-02");

-- Insert many rows into table at a time
INSERT INTO employees(employee_id, first_name, last_name, hourly_pay, hire_date)
VALUES (2,"Squidward", "Tentacles", 15.00, "2023-01-03"),
(3,"Spongebob", "Squarepants", 12.50, "2023-01-05"),
(4, "Patrick", "Star", 12.50, "2023-01-05"),
(5, "Sandy", "checks", 17.25, "2023-01-06");

-- Column count should be match for inserting the values, if not it will through the error:
-- Error Code: 1136. Column count doesn't match value count at row 1
INSERT INTO employees
VALUES (6, "Sheldon", "Pleankton");
-- we can insert as follows, But Null values filled with left column field
INSERT INTO employees(employee_id, first_name, last_name)
VALUES (6, "Sheldon", "Pleankton");

-- Selecting entire data from the table
SELECT * FROM employees;

-- Selecting only required column data
SELECT last_name, first_name 
FROM employees;

-- If you are looking specific, Then you can use WHERE clause
SELECT *
FROM employees
WHERE employee_id = 4;

SELECT * 
FROM employees
WHERE first_name = "Spongebob";

SELECT *
FROM employees
WHERE hourly_pay >= 15;

SELECT *
FROM employees
WHERE hire_date <= "2023-01-03";

SELECT *
FROM employees
WHERE employee_id != 1;

SELECT *
FROM employees
WHERE hire_date IS NULL;

SELECT *
FROM employees
WHERE hire_date IS NOT NULL; 

# UPDATE and DELETE from the table employees
UPDATE employees
SET hourly_pay = 10.25,
hire_date = "2023-01-07"
WHERE employee_id = 6;

-- Setting hire_date to null 
UPDATE employees
SET hire_date = null
WHERE employee_id = 6;

-- Setting hourly_pay for all the employees at time (need to remove where clause)
UPDATE employees
SET  hourly_pay = 10.25;

-- Deleteing a record from the employee
DELETE FROM employees
WHERE employee_id = 6;

DELETE FROM employees
WHERE employee_id = 6;

SELECT * FROM employees;

--  37.05 mins COMMIT, AUTOCOMMIT, ROLLBACK commands

--  to manually save the queryies , without automatic savepoint
SET AUTOCOMMIT = OFF;    # Now transactions are not going to savepoint, we need to mannually save the transactions
# Remember when we use commit and rollback autocommit should be off, because we are doing mannually

--  Creating the save point
COMMIT;

SELECT * 
FROM employees;

# now i am going to delete the table and againg i will undo the changes

DELETE FROM employees;        # now my all records are deleted

ROLLBACK;

SELECT * FROM employees;

--  Creatign the current date and time in mysql
# creating the test() table
CREATE TABLE test(
	my_date DATE,
    my_time TIME,
    my_datetime DATETIME
    );


# Inserting values into the test table
INSERT INTO TEST(my_date, my_time, my_datetime)
VALUES (CURRENT_DATE(), CURRENT_TIME(), NOW());

# you can add and subtract the date and time 
INSERT INTO test(my_date, my_time, my_datetime)
values(CURRENT_DATE() - 1, NULL, NULL);

SELECT * FROM test;
# UNIQUE constraint will never allow to insert the same product name 
# first i will insert duplicate records and then i will use unique 
# then it will through the erroe while adding duplicate keys

# creating the products table
CREATE TABLE products(
product_id INT,
product_name VARCHAR(25),
price DECIMAL(4,2));


INSERT INTO products(product_id,product_name, price)
values( 1, 'mobile', 13),
(2, 'mobile', 29),
(3, 'mobile', 59);


SELECT * FROM products;
TRUNCATE products;

DESC products;

# modify the product_name column to unique, there are tow methods - 1:
ALTER TABLE products
MODIFY product_name VARCHAR(30) UNIQUE; 

# modify the product_name column to unique, there are tow methods - 2: 
ALTER TABLE products
ADD CONSTRAINT
UNIQUE(product_id);

# Now if you insert the same query , it will throughs the error because we
# have multiple 'mobile' product_name. error code:1062. Duplicate entry  'mobile' for key 'products product_name'

INSERT INTO products(product_id,product_name, price)
values( 1, 'mobile', 13),
(2, 'mobile', 29),
(3, 'mobile', 59);

-- 47: NOT NULL CONSTRAINT
ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL;
# Inserting the null to the price coulumn through the error
INSERT INTO products(product_id, product_name, price)
VALUES	(4, 'cookie', NULL);  # error 1048. Column 'price' Cannot be null

-- 50 mins # Check contstaints
# if you want to add the constraints for the new table
CREATE TABLE employees (
employee_id INT,
fist_name VARCHAR(50),
last_name VARCHAR(50),
hourly_pay DECIMAL(5, 2),
hire_date DATE,
CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);

# if you want to add the constraints to existing table
ALTER TABLE employees
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 10.00);

use mydb;
SELECT * FROM products;  

# data inserting to the table products
INSERT INTO products (product_id, product_name, price)
values	(100, 'hamburger', 3.99),
		(101, 'fries', 1.89),
        (102, 'soda', 1.00),
        (103, 'ice cream', 1.49);

SELECT * FROM products;

# DEFAULT values can also set for columns

CREATE TABLE products1 (
	product_id INT,
    product_name VARCHAR(25),
    price decimal(5, 2) DEFAULT 0
    );
    
INSERT INTO products1 (product_id, product_name)
VALUES (1, 'Mango');

SELECT * FROM products1;
 
    

























































































































