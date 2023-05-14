-- Q 01 --------------------------------------------------------------------------------------------

SHOW TABLES;

-- Q 02 --------------------------------------------------------------------------------------------

SELECT * FROM project;
SELECT * FROM  dept_location;
SELECT * FROM  department;
SELECT * FROM  works_on;

-- Q 03 --------------------------------------------------------------------------------------------

SELECT * FROM employee
WHERE ssn
IN(SELECT mgrssn FROM department);

-- Q 04 --------------------------------------------------------------------------------------------

SELECT COUNT(*)
FROM works_on
WHERE pno 
IN(SELECT pno FROM project WHERE pname='Inventory Control system');

-- Q 05 --------------------------------------------------------------------------------------------

SELECT fname
FROM employee 
WHERE ssn 
IN(SELECT essn FROM works_on GROUP BY essn HAVING COUNT(essn)>1);

-- Q 06 --------------------------------------------------------------------------------------------

SELECT pname 
FROM project 
WHERE pnumber 
IN(SELECT pno FROM works_on GROUP BY  pno HAVING COUNT(pno)>1);

-- Q 07 --------------------------------------------------------------------------------------------

-- Q 08 --------------------------------------------------------------------------------------------

-- Q 09 --------------------------------------------------------------------------------------------

SELECT employee.fname,employee.salary
FROM employee
INNER JOIN works_on ON works_on.essn=employee.essn;


-- Q 10 --------------------------------------------------------------------------------------------

SELECT fname
FROM employee
WHERE salary=(SELECT MIN(salary) FROM employee);

-- Q 11 --------------------------------------------------------------------------------------------

-- Q 12 --------------------------------------------------------------------------------------------

-- Q 13 --------------------------------------------------------------------------------------------

SELECT essn
FROM works_on
GROUP BY essn HAVING COUNT(pno)>1;

-- Q 15 --------------------------------------------------------------------------------------------

UPDATE employee
SET salary=0.5*salary;

-- Q 16 --------------------------------------------------------------------------------------------

CREATE VIEW managers
 AS SELECT fname
 AS name,salary,dno 
 AS department_number
 FROM employee;

-- Q 17 --------------------------------------------------------------------------------------------

SELECT *  FROM managers;

-- Q 18 --------------------------------------------------------------------------------------------

UPDATE managers 
SET salary=salary+10000;

-- Q 19 --------------------------------------------------------------------------------------------

SELECT *  FROM managers;

-- Q 20 --------------------------------------------------------------------------------------------

CREATE VIEW inventory
AS SELECT fname,salary
FROM employee
INNER JOIN project ON project.dnum=employee.dno
WHERE project.pname='productX';


-- Q 21 --------------------------------------------------------------------------------------------

DESC inventory;

-- Q 22 --------------------------------------------------------------------------------------------

SELECT fname
FROM inventory
INNER JOIN project ON project.dnum= inventory.dno 
WHERE project.pname='computerization';

-- Q 23 --------------------------------------------------------------------------------------------

CREATE TABLE staff(
  fname VARCHAR(20) NOT NULL,
  minit VARCHAR(1),
  lname VARCHAR(20),
  ssn INT,
  bdate DATE,
  address VARCHAR(30),
  sex VARCHAR(1),
  salary INT,
  superssn INT,
  dno INT)
  ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Q 24 --------------------------------------------------------------------------------------------

INSERT INTO inv 
SELECT employee.fname,employee.salary
FROM employee
INNER JOIN project ON project.dnum=employee.dno
WHERE project.pname='recorganization';

-- Q 25 --------------------------------------------------------------------------------------------

UPDATE employee,department,project
SET employee.dno=8, department.dnumber=8, project.dnum=8
WHERE department.dname=' Implementation ' AND department.dnumber=employee.dno AND department.dnumber=project.dnum;

-- Q 26 --------------------------------------------------------------------------------------------

-- Q 27 --------------------------------------------------------------------------------------------

DROP DATABASE company;

-- Q 28 --------------------------------------------------------------------------------------------

-- Q 29 --------------------------------------------------------------------------------------------

mysqldump -u root -p --company staff nameOfBackupFile.sql

-- Q 30 --------------------------------------------------------------------------------------------

-- Q 31 --------------------------------------------------------------------------------------------

-- Q 32 --------------------------------------------------------------------------------------------

