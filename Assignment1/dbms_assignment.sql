/*
employee(employee-name, street, city)
works(employee-name, company-name, salary)
company(company-name, city)
manages (employee-name, manager-name)
Figure 5: Employee database.
*/

/*
1. Give an SQL schema definition for the employee database of Figure 5. Choose an appropriate
primary key for each relation schema, and insert any other integrity constraints (for example,
foreign keys) you find necessary.
*/

CREATE DATABASE db_Company_info;
USE db_Company_info;

CREATE TABLE tbl_Employee(
employee_name VARCHAR(100) PRIMARY KEY NOT NULL,
street VARCHAR(50),
city VARCHAR(50));

CREATE TABLE tbl_company(
company_name VARCHAR(100) PRIMARY KEY NOT NULL,
city VARCHAR(50));

CREATE TABLE tbl_works(
employee_name VARCHAR(100)
FOREIGN KEY REFERENCES tbl_employee(employee_name),
company_name VARCHAR(100)
FOREIGN KEY REFERENCES tbl_company(company_name),
salary FLOAT);

CREATE TABLE tbl_manages(
Employee_name VARCHAR(100) NOT NULL
FOREIGN KEY REFERENCES tbl_employee(employee_name),
manager_name VARCHAR(100));

--Inserting into tbl_employees
INSERT INTO tbl_employee(employee_name,street,city)
VALUES('Pratima Dawadi','Raniban','Kathmandu'),
('Rashmi Khadka','Budhhanagar','Kathmandu'),
('Pratigya Paudel','Baneshwor','Kathmandu'),
('Sushank Ghimire','Kapan','Kathmandu'),
('Prinsa Joshi','Suryabinayak','Bhaktapur'),
('Nistha Bajracharya','Sallaghari','Bhaktapur'),
('Shiwani Shah','Thimi','Bhaktapur'),
('Ram Sharma','Kamalbinayak','Bhaktapur'),
('Shyam Poudel','Pulchowk','Lalitpur'),
('Hari Dhital','Kupondole','Lalitpur'),
('Krishna Neupane','Gwarko','Lalitpur'),
('Gopal Sharma','Jawalakhel','Lalitpur');

SELECT * FROM tbl_Employee;

--Inserting into tbl_company
INSERT INTO tbl_company(company_name,city)
VALUES('First Bank Corporation','Kathmandu'),
('Leapfrog Technology','Kathmandu'),
('Small Bank Corporation','Bhaktpur'),
('Javra Software','Lalitpur'),
('Logpoint','Lalitpur');

SELECT * FROM tbl_company;

--Inserting into tbl_works
INSERT INTO tbl_works(employee_name,company_name,salary)
VALUES('Pratima Dawadi','First Bank Corporation',40000),
('Rashmi Khadka','Small Bank Corporation',80000),
('Pratigya Paudel','Leapfrog Technology',85000),
('Sushank Ghimire','Logpoint',55000),
('Prinsa Joshi','Javra Software',60000),
('Nistha Bajracharya','Logpoint',50000),
('Shiwani Shah','Small Bank Corporation',45000),
('Ram Sharma','Javra Software',55000),
('Shyam Poudel','Leapfrog Technology',28000),
('Hari Dhital','First Bank Corporation',90000),
('Krishna Neupane','Small Bank Corporation',15000),
('Gopal Sharma','First Bank Corporation',50000);

SELECT * FROM tbl_works;

--Inserting into tbl_manages
INSERT INTO tbl_manages(Employee_name,manager_name)
VALUES('Hari Dhital','Pratima Dawadi'),
('Gopal Sharma','Pratima Dawadi'),
('Rashmi Khadka','Krishna Neupane'),
('Shiwani Shah','Krishna Neupane'),
('Pratigya Paudel','Shyam Poudel'),
('Sushank Ghimire','Nistha Bajracharya'),
('Prinsa Joshi','Ram Sharma');

SELECT * FROM tbl_manages;

/*
2. Consider the employee database of Figure 5, where the primary keys are underlined. Give
an expression in SQL for each of the following queries:
*/

/*
(a) Find the names of all employees who work for First Bank Corporation.
*/

SELECT employee_name FROM tbl_works where company_name='First Bank Corporation';

/*
(b) Find the names and cities of residence of all employees who work for First Bank Corporation.*/SELECT tbl_employee.employee_name,tbl_employee.city FROM tbl_EmployeeINNER JOIN tbl_works ON tbl_Employee.employee_name=tbl_works.employee_nameWHERE tbl_works.company_name='First Bank Corporation';/*(c) Find the names, street addresses, and cities of residence of all employees who work for
First Bank Corporation and earn more than $10,000.*/SELECT tbl_Employee.employee_name,tbl_Employee.street,tbl_Employee.city FROM tbl_EmployeeINNER JOIN tbl_works ON tbl_Employee.employee_name=tbl_works.employee_nameWHERE tbl_works.company_name='First Bank Corporation' AND tbl_works.salary>10000;