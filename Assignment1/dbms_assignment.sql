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
('Ram Sharma','Suryabinayak','Bhaktapur'),
('Shyam Poudel','Pulchowk','Lalitpur'),
('Hari Dhital','Kupondole','Lalitpur'),
('Krishna Neupane','Gwarko','Lalitpur'),
('Gopal Sharma','Jawalakhel','Lalitpur'),
('Jones','Pulchowk','Lalitpur');

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
('Gopal Sharma','First Bank Corporation',50000),
('Jones','Leapfrog Technology',100000);

SELECT * FROM tbl_works;

--Inserting into tbl_manages
INSERT INTO tbl_manages(Employee_name,manager_name)
VALUES('Hari Dhital','Pratima Dawadi'),
('Gopal Sharma','Pratima Dawadi'),
('Rashmi Khadka','Krishna Neupane'),
('Shiwani Shah','Krishna Neupane'),
('Pratigya Paudel','Shyam Poudel'),
('Sushank Ghimire','Nistha Bajracharya'),
('Prinsa Joshi','Ram Sharma'),
('Jones','Shyam Poudel');

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
(b) Find the names and cities of residence of all employees who work for First Bank Corporation.
*/

SELECT tbl_employee.employee_name,tbl_employee.city 
FROM tbl_Employee
INNER JOIN tbl_works ON tbl_Employee.employee_name=tbl_works.employee_name
WHERE tbl_works.company_name='First Bank Corporation';

/*
(c) Find the names, street addresses, and cities of residence of all employees who work for
First Bank Corporation and earn more than $10,000.
*/

SELECT tbl_Employee.employee_name,tbl_Employee.street,tbl_Employee.city
FROM tbl_Employee
INNER JOIN tbl_works ON tbl_Employee.employee_name=tbl_works.employee_name
WHERE tbl_works.company_name='First Bank Corporation' AND tbl_works.salary>10000;

/*
(d) Find all employees in the database who live in the same cities as the companies for
which they work.
*/

SELECT tbl_Employee.employee_name,tbl_Employee.city 
FROM tbl_Employee
INNER JOIN tbl_works ON tbl_Employee.employee_name=tbl_works.employee_name
INNER JOIN tbl_company ON tbl_works.company_name=tbl_company.company_name
WHERE tbl_company.city = tbl_employee.city;

/*
(e) Find all employees in the database who live in the same cities and on the same streets
as do their managers.
*/

SELECT tbl_manages.employee_name AS Employee,tbl_manages.manager_name as Manager
FROM tbl_manages
INNER JOIN tbl_Employee AS emp ON tbl_manages.employee_name=emp.Employee_name
INNER JOIN tbl_Employee AS mgr ON tbl_manages.manager_name=mgr.employee_name
WHERE emp.city=mgr.city AND emp.street=mgr.street;

/*
(f) Find all employees in the database who do not work for First Bank Corporation
*/
SELECT employee_name FROM tbl_works WHERE company_name!='First Bank Corporation';

/*
(g) Find all employees in the database who earn more than each employee of Small Bank
Corporation.
*/
SELECT tbl_works.employee_name,tbl_works.salary
FROM tbl_works
INNER JOIN tbl_Employee ON tbl_works.employee_name=tbl_Employee.employee_name
WHERE tbl_works.salary > ALL(SELECT salary FROM tbl_works WHERE company_name='Small Bank Corporation');

/*
(h) Assume that the companies may be located in several cities. Find all companies located
in every city in which Small Bank Corporation is located.
*/

SELECT * FROM tbl_company WHERE tbl_company.city=(SELECT tbl_company.city WHERE tbl_company.company_name='Small Bank Corporation');

/*
(i) Find all employees who earn more than the average salary of all employees of their
company.
*/

SELECT tbl_works.employee_name, tbl_works.company_name 
FROM (SELECT company_name, AVG(salary) AS average_salary FROM tbl_works
GROUP BY company_name) AS avg_salary
JOIN tbl_works ON avg_salary.company_name = tbl_works.company_name WHERE tbl_works.salary > avg_salary.average_salary;

/*
(j) Find the company that has the most employees.
*/

SELECT w.company_name, COUNT(*) AS num_employees
FROM tbl_works w
GROUP BY w.company_name
ORDER BY num_employees DESC;

/*
(k) Find the company that has the smallest payroll.
*/

SELECT w.company_name, SUM(w.salary) AS payroll
FROM tbl_Employee e
INNER JOIN tbl_works w
ON e.employee_name=w.employee_name
GROUP BY w.company_name
ORDER BY payroll ASC;

/*
(l) Find those companies whose employees earn a higher salary, on average, than the
average salary at First Bank Corporation.
*/
SELECT w.company_name, AVG(w.salary) AS avg_salary
FROM tbl_Employee e
INNER JOIN tbl_works w
ON e.employee_name=w.employee_name
GROUP BY w.company_name
HAVING AVG(w.salary) > (SELECT AVG(w.salary) FROM tbl_Employee e INNER JOIN tbl_works w ON e.employee_name=w.employee_name WHERE w.company_name='First Bank Corporation');


/*
3. Consider the relational database of Figure 5. Give an expression in SQL for each of the
following queries:
*/

/*
(a) Modify the database so that Jones now lives in Newtown
*/

UPDATE tbl_employee SET city = 'Newtown' WHERE employee_name = 'Jones';

SELECT * FROM tbl_Employee WHERE employee_name='Jones';

/*
(b) Give all employees of First Bank Corporation a 10 percent raise.
*/

UPDATE tbl_works SET salary = salary * 1.1
WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name='First Bank Corporation');

SELECT * FROM tbl_works WHERE company_name='First Bank Corporation';

/*
(c) Give all managers of First Bank Corporation a 10 percent raise.
*/

UPDATE tbl_works SET salary = salary * 1.1
WHERE employee_name IN (SELECT manager_name FROM tbl_manages WHERE employee_name
IN (SELECT employee_name FROM tbl_works WHERE company_name='First Bank Corporation'));

SELECT * FROM tbl_works WHERE company_name='First Bank Corporation';

/*
(d) Give all managers of First Bank Corporation a 10 percent raise unless the salary becomes greater than $100,000; in such cases, give only a 3 percent raise.
*/

UPDATE tbl_works
SET salary = 
    CASE
        WHEN salary * 1.1 <= 100000 THEN salary * 1.1
        ELSE salary * 1.03
    END
WHERE employee_name IN 
(SELECT manager_name FROM tbl_manages WHERE employee_name IN (SELECT employee_name FROM tbl_works WHERE company_name='First Bank Corporation'));
SELECT * FROM tbl_works WHERE company_name='First Bank Corporation';

/*
(e) Delete all tuples in the works relation for employees of Small Bank Corporation.
*/
SET foreign_key_checks = 0;
DELETE tbl_works , tbl_employee , tbl_manages FROM tbl_works
JOIN
tbl_employee ON tbl_employee.employee_name = tbl_works.employee_name
JOIN
tbl_manages ON tbl_works.employee_name = tbl_manages.employee_name 
WHERE tbl_works.company_name = 'Small Bank Corporation';
SET foreign_key_checks = 1;
