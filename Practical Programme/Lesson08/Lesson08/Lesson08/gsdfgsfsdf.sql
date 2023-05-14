CREATE DATABASE Lesson08;

USE Lesson08;

CREATE TABLE EMPLOYEE (
FNAME VARCHAR(30) NOT NULL,
MINIT VARCHAR(30) NOT NULL,
LNAME VARCHAR(30) NOT NULL,
SSN INT NOT NULL,
BDATE DATE NOT NULL,
ADDRESS VARCHAR(50) NOT NULL,
SEX CHAR NOT NULL,
SALARY INT NOT NULL,
SUPERSSN INT,
DNO INT NOT NULL
);

DESC EMPLOYEE;

INSERT INTO EMPLOYEE VALUES
('John', 'B', 'Smith', '123456789', '1965-01-09' , '731 Fondren, Houston, TX', 'M', '30000', '333445555', '5'),
('Franklin', 'T', 'Wong', '333445555', '1965-12-08' , '638 Voss, Houston, TX', 'M', '40000', '888665555', '5'),
('Alicia', 'J', 'Zelaya', '999887777', '1968-07-19' , '3321 Castle, Spring, TX', 'F', '25000', '987654321', '4'),
('Jennifer', 'S', 'Wallace', '987654321', '1941-06-20' , '291 Berry, Bellaire, TX', 'F', '43000', '888665555', '4'),
('Ramesh', 'K', 'Narayan', '666884444', '1962-09-15' , '975 Fire Oak, Humble, TX', 'F', '38000', '333445555', '5'),
('Joyce', 'A', 'English', '453453453', '1972-07-31' , '5631 Rice, Houston, TX', 'F', '25000', '333445555', '5'),
('Ahmad', 'V', 'Jabbar', '987987987', '1969-03-29' , '980 Dallas, Houston, TX', 'M', '25000', '987654321', '4')
;

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE (FNAME, MINIT, LNAME, SSN, BDATE, ADDRESS, SEX, SALARY, DNO)
VALUES
('James', 'E', 'Borg', '888665555', '1937-11-10' , '450 Stone, Houston, TX', 'M', '55000', '1');


CREATE TABLE DEPT_LOCATIONS (
DNUMBER INT NOT NULL,
DLOCATION VARCHAR(30) NOT NULL
);

INSERT INTO DEPT_LOCATIONS VALUES
('1', 'Houston'),
('4', 'Stafford'),
('5', 'Bellaire'),
('5', 'Sugarlane'),
('5', 'Houston')
;

CREATE TABLE DEPARTMENT (
DNAME VARCHAR(30) NOT NULL,
DNUMBER INT NOT NULL,
MGRSSN INT NOT NULL,
MGRSTARTDATE DATE NOT NULL
);

INSERT INTO DEPARTMENT VALUES
('Research', '5', '333445555', '1988-05-22'),
('Administration', '4', '987654321', '1995-01-01'),
('Headquarters', '1', '888665555', '1981-06-19')
;

CREATE TABLE PROJECT (
PNAME VARCHAR(30) NOT NULL,
PNUMBER INT NOT NULL,
PLOCATION VARCHAR(30) NOT NULL,
DNUM INT NOT NULL
);

INSERT INTO PROJECT VALUES
('ProductX', '1', 'Bellaire', '5'),
('ProductY', '2', 'Sugarland', '5'),
('ProductZ', '3', 'Houston', '5'),
('Computerization', '10', 'Stafford', '4'),
('Reorganization', '20', 'Houston', '1'),
('Newbenefits', '30', 'Stafford', '4')
;

CREATE TABLE WORKS_ON (
ESSN INT NOT NULL,
PNO INT NOT NULL,
HOURS DECIMAL(3,1)
);

INSERT INTO WORKS_ON VALUES
(123456789, 1, 32.5),
(123456789, 2, 7.5),
(666884444, 3, 40.0),
(453453453, 1, 20.0),
(453453453, 2, 20.0),
(333445555, 2, 10.0),
(333445555, 3, 10.0),
(333445555, 10, 10.0),
(333445555, 20, 10.0),
(999887777, 30, 30.0),
(999887777, 10, 10.0),
(987987987, 10, 35.0),
(987987987, 30, 5.0),
(987654321, 30, 20.0),
(987654321, 20, 15.0),
(888665555, 20, null)
;


CREATE TABLE DEPENDENT (
ESSN INT NOT NULL,
DEPENDENT_NAME VARCHAR(30) NOT NULL,
SEX CHAR NOT NULL,
BDATE DATE NOT NULL,
RELATIONSHIP VARCHAR(30) NOT NULL);


INSERT INTO DEPENDENT VALUES
(333445555, 'Alice', 'F', '1986-04-05', 'Daughter'),
(333445555, 'Theodore', 'M', '1983-10-25', 'Son'),
(333445555, 'Joy', 'F', '1958-05-03', 'Spouse'),
(987654321, 'Abner', 'M', '1942-02-28', 'Spouse'),
(123456789, 'Micheal', 'M', '1988-01-04', 'Son'),
(123456789, 'Alice', 'F', '1988-12-30', 'Daughter'),
(123456789, 'Elizabeth', 'F', '1967-05-05', 'Spouse')
;

/*-----------------------------------------------------------*/

SELECT *
FROM EMPLOYEE;

SELECT *
FROM DEPT_LOCATIONS;

SELECT *
FROM DEPARTMENT;

SELECT *
FROM WORKS_ON;

SELECT *
FROM PROJECT;

SELECT *
FROM DEPENDENT;




/*Q0 --------------------------------------------------*/

SELECT BDATE, ADDRESS
FROM EMPLOYEE
WHERE FNAME ='John' AND MINIT='B'
AND LNAME='Smith'
;

/*Q1 --------------------------------------------------*/

SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE
INNER JOIN DEPARTMENT
ON EMPLOYEE.DNO = DEPARTMENT.DNUMBER
WHERE DNAME = 'Research';

/*Q2 --------------------------------------------------*/

SELECT PNUMBER, DNUM, LNAME, ADDRESS, BDATE
FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE DNUM = DNUMBER AND MGRSSN = SSN AND PLOCATION = 'Stafford';

/*Q3 --------------------------------------------------*/
/*Q4 --------------------------------------------------*/

(SELECT PNAME
FROM PROJECT, DEPARTMENT, EMPLOYEE
WHERE DNUM=DNUMBER AND MGRSSN=SSN AND LNAME='Smith')
;


/*Q5 --------------------------------------------------*/
/*Q6 --------------------------------------------------*/
/*Q7 --------------------------------------------------*/
/*Q8 --------------------------------------------------*/

SELECT EMPLOYEE.FNAME, EMPLOYEE.LNAME, SUPERVISOR.FNAME,
SUPERVISOR.LNAME
FROM EMPLOYEE, EMPLOYEE AS SUPERVISOR
WHERE EMPLOYEE.SUPERSSN = SUPERVISOR.SSN;

/*Q9 --------------------------------------------------*/

SELECT SSN
FROM EMPLOYEE;

/*Q10 --------------------------------------------------*/

SELECT SSN, DNAME
FROM EMPLOYEE,
DEPARTMENT
;

/*Q1 C --------------------------------------------------*/

SELECT *
FROM EMPLOYEE
WHERE DNO=5
;

/*Q1 D --------------------------------------------------*/

SELECT *
FROM EMPLOYEE,DEPARTMENT
WHERE DNAME='Research' AND DNO=DNUMBER
;
/*Q11 --------------------------------------------------*/

SELECT SALARY
FROM EMPLOYEE
;

/*Q11 A --------------------------------------------------*/

SELECT DISTINCT SALARY
FROM EMPLOYEE
;

/*Q1 --------------------------------------------------*/

SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE
WHERE DNO IN (SELECT DNUMBER
FROM DEPARTMENT
WHERE DNAME='Research' )
;

/*Q12 --------------------------------------------------*/

SELECT E.FNAME, E.LNAME
FROM EMPLOYEE AS E
WHERE E.SSN IN (SELECT ESSN
FROM DEPENDENT
WHERE ESSN=E.SSN AND E.FNAME=DEPENDENT_NAME)
;

/*Q12 A --------------------------------------------------*/

SELECT E.FNAME, E.LNAME
FROM EMPLOYEE AS E, DEPENDENT AS D
WHERE E.SSN=D.ESSN AND E.FNAME=D.DEPENDENT_NAME
;
/*Q3 --------------------------------------------------*/

SELECT FNAME, LNAME
FROM EMPLOYEE
WHERE ( (SELECT PNO FROM WORKS_ON
WHERE SSN=ESSN)
CONTAINS
(SELECT PNUMBER
FROM PROJECT
WHERE DNUM=5) )
;

/*Q14 --------------------------------------------------*/

SELECT FNAME, LNAME
FROM EMPLOYEE
WHERE SUPERSSN IS NULL
;

/*Q8 --------------------------------------------------*/

SELECT E.FNAME, E.LNAME, S.FNAME, S.LNAME
FROM (EMPLOYEE E LEFT OUTER JOIN EMPLOYEES
ON E.SUPERSSN=S.SSN)
;

/*Q1 --------------------------------------------------*/

SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE, DEPARTMENT
WHERE DNAME='Research' AND DNUMBER=DNO
;

/*Q1 --Joined Relations Feature------------------------------------------------*/

SELECT FNAME, LNAME, ADDRESS
FROM (EMPLOYEE JOIN DEPARTMENT
ON DNUMBER=DNO)
WHERE DNAME='Research'
;

/*Q1 -----Joined Relations Feature----------------------------------------------*/

SELECT FNAME, LNAME, ADDRESS
FROM (EMPLOYEE NATURAL JOIN DEPARTMENT
AS DEPT(DNAME, DNO, MSSN, MSDATE)
WHERE DNAME='Research'
;

/*Q2 -----------Joined Relations Feature---------------------------------------*/

SELECT PNUMBER, DNUM,
LNAME, BDATE,
ADDRESS
FROM (PROJECT JOIN
DEPARTMENT ON
DNUM=DNUMBER)
JOIN EMPLOYEE ON
MGRSSN=SSN) )
WHERE PLOCATION='Stafford'
;

/*Q15 -------AGGREGATE FUNCTIONS-------------------------------------------*/

SELECT MAX(SALARY),
MIN(SALARY),
AVG(SALARY)
FROM EMPLOYEE
;

/*Q16 ----------AGGREGATE FUNCTIONS (cont.)---------------------------------*/

SELECT MAX(SALARY),
MIN(SALARY),
AVG(SALARY)
FROM EMPLOYEE,
DEPARTMENT
WHERE DNO=DNUMBER AND
DNAME='Research'
;

/*Q17 ---AGGREGATE FUNCTIONS (cont.)-----------------------------------------------*/

SELECT COUNT(*)FROM EMPLOYEE
;

/*Q18 --------------------------------------------------*/

SELECT COUNT(*)
FROM EMPLOYEE,DEPARTMENT
WHERE DNO=DNUMBER AND
DNAME='Research'
;


/*Q20 --------------------------------------------------*/

SELECT DNO, COUNT(*), AVG (SALARY)
FROM EMPLOYEE
GROUP BY DNO
;


/*Q21 --------------------------------------------------*/

SELECT PNUMBER, PNAME,
COUNT(*)
FROM PROJECT, WORKS_ON
WHERE PNUMBER=PNO
GROUP BY PNUMBER,PNAME
;

/*Q22 --------------------------------------------------*/

SELECT PNUMBER, PNAME,
COUNT(*)
FROM PROJECT, WORKS_ON
WHERE PNUMBER=PNO
GROUP BY PNUMBER,PNAME
HAVING COUNT(*) > 2
;

/*Q25 --------------------------------------------------*/

SELECT FNAME, LNAME
FROM EMPLOYEE
WHERE ADDRESS LIKE '%Houston,TX%'
;
/*Q26 --------------------------------------------------*/

SELECT FNAME, LNAME
FROM EMPLOYEE
WHERE BDATE LIKE
'_______5_'
;

/*Q27 --------------------------------------------------*/

SELECT FNAME, LNAME, 1.1*SALARY
FROM EMPLOYEE, WORKS_ON, PROJECT
WHERE SSN=ESSN AND PNO=PNUMBER AND
PNAME='ProductX'
;

/*Q28 --------------------------------------------------*/

SELECT DNAME, LNAME, FNAME, PNAME
FROM DEPARTMENT, EMPLOYEE,
WORKS_ON, PROJECT
WHERE DNUMBER=DNO AND SSN=ESSN AND PNO=PNUMBER
ORDER BY DNAME, LNAME;

/*Q ----Summary of SQL Queries----------------------------------------------*/

SELECT < attribute list>
FROM <table list>
[WHERE <condition>]
[GROUP BY <grouping attribute(s)>]
[HAVING <group condition>]
[ORDER BY <attribute list>]


/*U1 --------------------------------------------------*/

INSERT INTO EMPLOYEE
VALUES ('Richard','K','Marini', '653298653', '30-DEC52',
'98 Oak Forest,Katy,TX', 'M', 37000,'987654321', 4 );

/*U1 A --------------------------------------------------*/

INSERT INTO EMPLOYEE (FNAME, LNAME, SSN)
VALUES ('Richard', 'Marini', '653298653');

/* -----------INSERT (cont.)
---------------------------------------*/

INSERT INTO EMPLOYEE
VALUES 
('Richard', 'K', 'Marini', '653298653', '1962-12-30', '98Oak Forest,Katy,TX', 'M', 37000, '987654321',4);

/* --------INSERT (cont.)------------------------------------------*/

INSERT INTO EMPLOYEE 
(FNAME, LNAME, DNO, SSN)
VALUES
('Richard', 'Marini', 4,'653298653');

/*U3A --------------------------------------------------*/

CREATE TABLE DEPTS_INFO
(DEPT_NAME VARCHAR(10),
NO_OF_EMPS INTEGER,
TOTAL_SAL INTEGER);

/*U3A --------------------------------------------------*/

CREATE TABLE DEPTS_INFO 
(DEPT_NAME VARCHAR(10),NO_OF_EMPS 
INTEGER, TOTAL_SAL INTEGER);
/*U3B --------------------------------------------------*/

INSERT INTO DEPTS_INFO (DEPT_NAME,
NO_OF_EMPS, TOTAL_SAL)
SELECT DNAME, COUNT(*), SUM(SALARY)
FROM DEPARTMENT, EMPLOYEE
WHERE DNUMBER=DNO
GROUP BY DNAME ;

/*U4A --------------------------------------------------*/

DELETE FROM EMPLOYEE
WHERE LNAME='Brown';

/*U4B --------------------------------------------------*/

DELETE FROM EMPLOYEE
WHERE SSN=123456789;


/*U4c --------------------------------------------------*/

DELETE FROM EMPLOYEE
WHERE DNO IN
(SELECT DNUMBER
FROM DEPARTMENT
WHERE
DNAME='Research');

/*U4D --------------------------------------------------*/

DELETE FROM EMPLOYEE;

/*U5 --------------------------------------------------*/

UPDATE PROJECT
SET PLOCATION = 'Bellaire',
DNUM = 5
WHERE PNUMBER=10;

/*U6 --------------------------------------------------*/

UPDATE EMPLOYEE
SET SALARY = SALARY *1.1
WHERE DNO IN (SELECT DNUMBER
FROM DEPARTMENT
WHERE DNAME='Research')
;


