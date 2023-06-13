	CREATE TABLE
		tbl_Employee (
			employee_name VARCHAR(255) NOT NULL,
			street VARCHAR(255) NOT NULL,
			city VARCHAR(255) NOT NULL,
			PRIMARY KEY(employee_name)
		);
 

CREATE TABLE
    tbl_Works (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        company_name VARCHAR(255),
        salary DECIMAL(10, 2)
    );
 
CREATE TABLE
    tbl_Company (
        company_name VARCHAR(255),
        city VARCHAR(255),
        PRIMARY KEY(company_name)
    );
 
CREATE TABLE
    tbl_Manages (
        employee_name VARCHAR(255) NOT NULL,
        FOREIGN KEY (employee_name) REFERENCES tbl_Employee(employee_name),
        manager_name VARCHAR(255)
    );
 
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );
 
INSERT INTO
    tbl_Employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );
 
INSERT INTO
    tbl_Works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );
 
INSERT INTO
    tbl_Company (company_name, city)
VALUES (
        'Small Bank Corporation', 'Chicago'), 
        ('ABC Inc', 'Los Angeles'), 
        ('Def Co', 'Houston'), 
        ('First Bank Corporation','New York'), 
        ('456 Corp', 'Chicago'), 
        ('789 Inc', 'Los Angeles'), 
        ('321 Co', 'Houston'),
        ('Pongyang Corporation','Chicago'
    );
	
 
INSERT INTO
    tbl_Manages(employee_name, manager_name)
VALUES 
    ('Mark Thompson', 'Emily Williams'),
    ('Ashley Johnson', 'Jane Doe'),
    ('Alice Williams', 'Emily Williams'),
    ('Samantha Smith', 'Sara Davis'),
    ('Patrick', 'Jane Doe');

SELECT employee_name FROM tbl_Employee
order by employee_name ;
SELECT * FROM tbl_Works
order by employee_name ;
SELECT * FROM tbl_Company;

SELECT * FROM tbl_Manages;
 
-- Update the value of salary to 1000 where employee name= John Smith and company_name = First Bank Corporation
UPDATE tbl_Works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
AND company_name = 'First Bank Corporation';

--2a
SELECT employee_name from tbl_Works
WHERE company_name='First Bank Corporation';

--2b
SELECT employee_name,city
from tbl_Employee
where employee_name in (SELECT employee_name from tbl_Works
WHERE company_name='First Bank Corporation');

--2c
SELECT *
FROM tbl_Employee
WHERE employee_name in (SELECT employee_name from tbl_Works
WHERE company_name='First Bank Corporation' AND salary>10000);

--2d
SELECT employee_name
FROM tbl_Employee
WHERE EXISTS(SELECT employee_name from tbl_Company
where employee_name in
(SELECT employee_name
FROM tbl_Works
WHERE tbl_Works.company_name=tbl_Company.company_name)
AND tbl_Company.city=tbl_Employee.city);

SELECT e.employee_name
FROM tbl_Employee e
JOIN tbl_works w ON e.employee_name = w.employee_name
JOIN tbl_company c ON w.company_name = c.company_name
WHERE e.city = c.city;

--2e
SELECT e.employee_name
FROM tbl_Employee e
JOIN tbl_manages m ON e.employee_name = m.employee_name
JOIN tbl_employee m2 ON m.manager_name = m2.employee_name
WHERE e.city = m2.city AND e.street = m2.street;

--2f
SELECT employee_name 
FROM tbl_Works 
WHERE tbl_Works.company_name!='First Bank Corporation';

--2g
SELECT * FROM tbl_Works where salary>(SELECT MAX(salary) AS max_salary FROM tbl_Works
WHERE  company_name = 'Small Bank Corporation');

--2h
SELECT company_name,city FROM tbl_Company
WHERE city=
(SELECT city FROM tbl_Company 
WHERE company_name='Small Bank Corporation') 
AND company_name<>'Small Bank Corporation';


--2i
CREATE VIEW emp AS		--why taking this as error
SELECT company_name,AVG(salary) AS Salary
FROM tbl_Works
WHERE Salary>AVG(salary)
GROUP BY company_name;

SELECT * FROM tbl_Works 
WHERE salary>
(SELECT Salary FROM emp
WHERE emp.company_name=tbl_Works.company_name);

