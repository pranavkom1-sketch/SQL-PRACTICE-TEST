-- SQL PRACTICE TEST 4

CREATE DATABASE CTEVIEW;

CREATE TABLE EMPLOYEES    --USING FROM THE OTHER ASSIGNMENT 
(
EMP_ID INT,
EMP_NAME VARCHAR(50),
DEPARTMENT VARCHAR(50),
SALARY INT,
JOINDATE DATE
);

INSERT INTO EMPLOYEES
VALUES
(101,'VARUN','HR',74000,'2024-11-25'),
(102,'ROY','TEACHING',50000,'2020-04-14'),
(103,'SASHA','FINANCE',95000,'2021-07-04'),
(104,'ARJUN','IT',70000,'2023-11-25'),
(105,'HEMA','TEACHING',52000,'2021-05-14'),
(106,'INDU','CODING',195000,'2019-04-04'),
(107,'JUNI','IT',70000,'2023-10-25'),
(108,'SEB','TEACHING',50000,'2024-04-14');

SELECT * FROM EMPLOYEES;

----------------------------------------------------

WITH EMPCTE AS 
(
SELECT *
FROM EMPLOYEES
)
SELECT * FROM EMPCTE;

----------------------------------------------------

WITH HIGHSAL AS 
(
SELECT *
FROM EMPLOYEES
WHERE SALARY>60000
)
SELECT * FROM HIGHSAL;

----------------------------------------------------

WITH EMPIT AS 
(
SELECT *
FROM EMPLOYEES
WHERE DEPARTMENT='IT'
)
SELECT * FROM EMPIT;

----------------------------------------------------

WITH SALCTE AS 
(
SELECT EMP_ID, 
       SALARY
FROM EMPLOYEES
)
UPDATE SALCTE
SET SALARY=SALARY+3000;

SELECT * FROM EMPLOYEES;

----------------------------------------------------

WITH LOWSAL AS 
(
SELECT EMP_ID
FROM EMPLOYEES
WHERE SALARY<55000
)
DELETE FROM EMPLOYEES
WHERE EMP_ID IN (SELECT EMP_ID FROM LOWSAL);

SELECT * FROM EMPLOYEES;

----------------------------------------------------

CREATE PROCEDURE GETALLEMPLOYEES 
AS
BEGIN
    SELECT * FROM EMPLOYEES;
END;

EXEC GETALLEMPLOYEES;

----------------------------------------------------

--QUESTION 7 - ?

----------------------------------------------------

CREATE PROCEDURE INSERTEMPLOYEE
    @EMP_ID INT,
    @EMP_NAME VARCHAR(100),
    @DEPARTMENT VARCHAR(50),
    @SALARY DECIMAL(10,2),
    @JOINDATE DATE
AS
BEGIN
    INSERT INTO EMPLOYEES (EMP_ID,EMP_NAME,DEPARTMENT,SALARY,JOINDATE)
    VALUES (@EMP_ID,@EMP_NAME,@DEPARTMENT,@SALARY,@JOINDATE);
END;

EXEC INSERTEMPLOYEE 107,'JOHN','IT',65000,'2021-04-06';

SELECT * FROM EMPLOYEES;

----------------------------------------------------

CREATE PROCEDURE UPDATEEMPSAL
    @EMP_ID INT,
    @NEWSALARY DECIMAL(10,2)
AS
BEGIN
    UPDATE EMPLOYEES
    SET SALARY=@NEWSALARY
    WHERE EMP_ID = @EMP_ID;
END;

EXEC UPDATEEMPSAL 101, 345000;

----------------------------------------------------

CREATE PROCEDURE DELEMP
    @EMP_ID INT
AS
BEGIN
    DELETE FROM EMPLOYEES
    WHERE EMP_ID = @EMP_ID;
END;

EXEC DELEMP 105;

----------------------------------------------------

CREATE PROCEDURE SALRANGE
    @MINSAL DECIMAL(10,2),
    @MAXSAL DECIMAL(10,2)
AS
BEGIN
    SELECT * FROM EMPLOYEES
    WHERE SALARY BETWEEN @MINSAL AND @MAXSAL;
END;

EXEC SALRANGE 50000,70000;

----------------------------------------------------

CREATE VIEW VW_EMPBASIC
AS
SELECT 
    EMP_ID,
    EMP_NAME,
    DEPARTMENT
FROM EMPLOYEES;

SELECT * FROM VW_EMPBASIC;

----------------------------------------------------

CREATE VIEW VW_HIGHSALEMP 
AS
SELECT * FROM EMPLOYEES
WHERE SALARY>65000;

SELECT * FROM VW_HIGHSALEMP;

----------------------------------------------------

ALTER VIEW VW_EMPBASIC 
AS
SELECT 
    EMP_ID,
    EMP_NAME,
    DEPARTMENT,
    SALARY
FROM EMPLOYEES;

SELECT * FROM VW_EMPBASIC;

----------------------------------------------------

CREATE VIEW VW_ITEMP 
AS
SELECT 
    EMP_ID,
    EMP_NAME,
    SALARY
FROM EMPLOYEES
WHERE DEPARTMENT ='IT';

SELECT * FROM VW_ITEMP;

----------------------------------------------------

WITH ABOVEAVGSALARY AS 
(
SELECT *
FROM EMPLOYEES
WHERE SALARY>(SELECT AVG(SALARY)FROM EMPLOYEES)
)
SELECT * FROM ABOVEAVGSALARY;

----------------------------------------------------

--BONUS QUESTION 2 - ?

----------------------------------------------------

CREATE VIEW VW_EMPSALHIDE 
AS
SELECT 
    EMP_ID,
    EMP_NAME,
    DEPARTMENT
FROM EMPLOYEES;
SELECT * FROM VW_EMPSALHIDE;

----------------------------------------------------

WITH MAXSALCTE AS (
    SELECT *
    FROM EMPLOYEES
    WHERE SALARY=(SELECT MAX(SALARY) FROM EMPLOYEES)
)
SELECT * FROM MAXSALCTE;

----------------------------------------------------

CREATE PROCEDURE DEP_EMP_COUNT
AS
BEGIN
SELECT 
     DEPARTMENT,
     COUNT(*) AS TOTEMP
FROM EMPLOYEES
GROUP BY DEPARTMENT;
END;

EXEC DEP_EMP_COUNT;

----------------------------------------------------