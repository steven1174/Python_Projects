-- 0. DDL statement for table 'HR' database

CREATE TABLE EMPLOYEES (
	EMP_ID CHAR(9) NOT NULL, 
        F_NAME VARCHAR(15) NOT NULL,
        L_NAME VARCHAR(15) NOT NULL,
        SSN CHAR(9),
        B_DATE DATE,
        SEX CHAR,
        ADDRESS VARCHAR(30),
        JOB_ID CHAR(9),
        SALARY DECIMAL(10,2),
        MANAGER_ID CHAR(9),
        DEP_ID CHAR(9) NOT NULL,
        PRIMARY KEY(EMP_ID));
                            
CREATE TABLE JOB_HISTORY (
	EMPL_ID CHAR(9) NOT NULL, 
	START_DATE DATE,
	JOBS_ID CHAR(9) NOT NULL,
	DEPT_ID CHAR(9),
	PRIMARY KEY(EMPL_ID,JOBS_ID));
 
CREATE TABLE JOBS (
	JOB_IDENT CHAR(9) NOT NULL, 
	JOB_TITLE VARCHAR(25),
	MIN_SALARY DECIMAL(10,2),
	MAX_SALARY DECIMAL(10,2),
	PRIMARY KEY(JOB_IDENT));

CREATE TABLE DEPARTMENTS (
	DEPT_ID_DEP CHAR(9) NOT NULL, 
	DEP_NAME VARCHAR(15),
	MANAGER_ID CHAR(9),
	LOC_ID CHAR(9),
	PRIMARY KEY(DEPT_ID_DEP));

CREATE TABLE LOCATIONS (
	LOCT_ID CHAR(9) NOT NULL,
	DEP_ID_LOC CHAR(9) NOT NULL,
	PRIMARY KEY (LOCT_ID,DEP_ID_LOC));

-- 1. Query 1
SELECT F_NAME, L_NAME, ADDRESS FROM EMPLOYEES 
	WHERE ADDRESS LIKE '%Elgin,IL%';

-- 2. Query 2
SELECT  F_NAME, L_NAME, B_DATE FROM EMPLOYEES
	WHERE B_DATE LIKE '197%';

-- 3. Query 3
SELECT F_NAME, L_NAME, DEP_ID, SALARY FROM EMPLOYEES 
	WHERE (SALARY BETWEEN 60000 AND 70000) AND DEP_ID = 5;

-- 4A. Query 4A
SELECT F_NAME, L_NAME, DEP_ID FROM EMPLOYEES
	ORDER BY DEP_ID; 

-- 4B. Query 4B
SELECT F_NAME, L_NAME, DEP_ID FROM EMPLOYEES
	ORDER BY DEP_ID DESC, L_NAME DESC;

-- 5A. Query 5A
SELECT DEP_ID, COUNT(DEP_ID) AS EMPLOYEES FROM EMPLOYEES 
	GROUP BY DEP_ID;

-- 5B. Query 5B
SELECT DEP_ID, COUNT(DEP_ID), AVG(SALARY) FROM EMPLOYEES
	GROUP BY DEP_ID;

-- 5C. Query 5C
SELECT DEP_ID, COUNT(DEP_ID) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES
	GROUP BY DEP_ID; 

-- 5D. Query 5D
SELECT DEP_ID, COUNT(DEP_ID) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES
	GROUP BY DEP_ID
	ORDER BY AVG_SALARY;

-- 5E. Query 5E
SELECT DEP_ID, COUNT(DEP_ID) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES
	GROUP BY DEP_ID
	HAVING COUNT(DEP_ID) < 4
	ORDER BY AVG_SALARY;

-- 5E. Query 5E (Alternative)
SELECT DEP_ID, NUM_EMPLOYEES, AVG_SALARY FROM 
	(SELECT DEP_ID, COUNT(DEP_ID) AS NUM_EMPLOYEES, AVG(SALARY) AS AVG_SALARY FROM EMPLOYEES
	GROUP BY DEP_ID)
	WHERE NUM_EMPLOYEES < 4
	ORDER BY AVG_SALARY;

-- 6. Query 6
SELECT  D.DEP_NAME, E.F_NAME, E.L_NAME FROM EMPLOYEES AS  E, DEPARTMENTS AS D 
	WHERE E.DEP_ID = D.DEPT_ID_DEP
	ORDER BY D.DEP_NAME, E.L_NAME DESC;