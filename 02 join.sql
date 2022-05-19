USE employees;
SELECT * FROM employees limit 100;
SELECT dept_no FROM departments;
SELECT * FROM departments;
SELECT * FROM employees WHERE first_name = 'Elvis';
SELECT * FROM employees WHERE gender = 'F' AND first_name = 'Kellie';
SELECT * FROM employees WHERE gender = 'F' and (first_name = 'Kellie' OR first_name = 'Aruna');
SELECT * FROM employees WHERE first_name IN ('Denis', 'Elvis');
SELECT * FROM employees WHERE first_name NOT IN ('John', 'Mark', 'Jacob');
SELECT * FROM employees WHERE first_name LIKE 'Mark%';
SELECT * FROM employees WHERE hire_date LIKE '2000%';
SELECT * FROM employees WHERE YEAR(hire_date) = 2000;
SELECT * FROM employees WHERE emp_no LIKE '1000_';
SELECT * FROM employees WHERE hire_date NOT BETWEEN '1990-01-01' AND '2000-01-01';
SELECT * FROM departments WHERE dept_no IS NOT NULL;
SELECT * FROM employees WHERE hire_date >= '2000-01-01' AND gender = 'F';
SELECT DISTINCT hire_date FROM employees;
SELECT COUNT(*) FROM salaries WHERE salary >= 100000;

SELECT salary, COUNT(*) AS emps_with_same_salary
FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY salary;

SELECT emp_no, AVG(salary)
FROM salaries
WHERE from_date < '2000-01-01'
GROUP BY emp_no
Having AVG(salary) >120000
ORDER BY emp_no;

-- Employees who have more than 1 contracts
SELECT emp_no, COUNT(emp_no)
FROM dept_emp
WHERE from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(emp_no) > 1
ORDER BY emp_no;

INSERT INTO employees
VALUES
(
    999903,
    '1977-09-14',
    'Johnathan',
    'Creek',
    'M',
    '1999-01-01'
);

INSERT INTO titles(
emp_no,
title,
from_date)
VALUES (
999903,
'Senior Engineer',
'1997-10-01');

INSERT INTO dept_emp
VALUES (
999903,
'd005',
'1997-01-01',
'9999-01-01');

CREATE TABLE departments_dup
(dept_no CHAR(4) NOT NULL,
dept_name varchar(40) not null);

INSERT INTO departments_dup
(dept_no,
dept_name)
SELECT * FROM departments;

INSERT INTO departments
VALUES (
'd010',
'Business Analysis');

UPDATE employees
SET 
first_name = 'Ste',
last_name = 'Pa',
birth_date = '1990-12-31',
gender = 'M'
WHERE emp_no = '999903';

COMMIT;

ROLLBACK;

UPDATE departments
SET
dept_name = 'Data Analysis'
WHERE dept_no = 'd010';

DELETE FROM employees
WHERE emp_no = 999903;

DELETE FROM departments_dup; 
-- It will delete all the data in this table.

DELETE FROM departments
WHERE dept_no = 'd010';

SELECT COUNT(DISTINCT dept_no) FROM dept_emp;

SELECT SUM(salary) FROM salaries
WHERE from_date > '1997-01-01';

SELECT MIN(emp_no), MAX(emp_no) FROM employees;

SELECT ROUND(AVG(salary),2) FROM salaries
WHERE from_date > '1997-01-01';

-- IFNULL and COALESCE
ALTER TABLE departments_dup
ADD COLUMN department_manager VARCHAR(255) AFTER dept_name;

ALTER TABLE departments_dup
MODIFY dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup (dept_no)
VALUES 
('d010'),
('d011');

SELECT dept_no, IFNULL(dept_name, 'Department name not provided') AS dept_name
FROM departments_dup;

ALTER TABLE departments_dup
RENAME COLUMN department_manager TO dept_manager;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_manager, dept_name, 'N/A') AS dept_manager
FROM
    departments_dup
ORDER BY dept_no;

SELECT 
    dept_no,
    dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM departments_dup
ORDER BY dept_no;

SELECT 
    IFNULL(dept_no, 'N/A') AS dept_no,
    IFNULL(dept_name,
            'Department name not provided') AS dept_name,
    COALESCE(dept_no, dept_name) AS dept_info
FROM
    departments_dup
ORDER BY dept_no;

-- Prepare for Joins
ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

INSERT INTO departments_dup(dept_name)
VALUES ('Public Relations');

DELETE FROM departments_dup
WHERE dept_no = 'd002';

CREATE TABLE dept_manager_dup
 (
  emp_no int(11) NOT NULL,
  dept_no char(4) NULL,
  from_date date NOT NULL,
  to_date date NULL
  );
  
INSERT INTO dept_manager_dup
select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES
(999904, '2017-01-01'),
(999905, '2017-01-01'),
(999906, '2017-01-01'),
(999907, '2017-01-01');

DELETE FROM dept_manager_dup
WHERE
    dept_no = 'd001';
    
-- Inner Join
SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
INNER JOIN departments_dup d
ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT m.dept_no, m.emp_no, e. first_name, e.last_name, e.hire_date
FROM dept_manager_dup m
INNER JOIN employees e
ON e.emp_no = m.emp_no;

-- Duplicate records
INSERT INTO dept_manager_dup
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup
VALUES ('d009', 'Customer Service');

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
Inner JOIN departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no -- Use group by to delete duplicates
ORDER BY dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM dept_manager_dup m
Left JOIN departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no -- Use group by to delete duplicates
ORDER BY dept_no;

SELECT m.dept_no, m.emp_no, d.dept_name
FROM departments_dup d
LEFT JOIN dept_manager_dup m
ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT e.emp_no, e.first_name, e.last_name, m.dept_no, m. from_date
FROM employees e
LEFT JOIN dept_manager m
ON e.emp_no = m.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY m.dept_no DESC, emp_no;

-- old join syntax, use where
SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no;

SELECT e.first_name, e.last_name, e.hire_date, t.title
FROM employees e
LEFT JOIN titles t
ON e.emp_no = t.emp_no
WHERE e.first_name = 'Margareta' and e.last_name = 'Markovitch';

-- cross join, sometime the same as inner join without on condition
SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

SELECT dm.*, d.*
FROM dept_manager dm
CROSS JOIN departments d
WHERE d.dept_no = 'd009';

SELECT e.*, d.*
FROM employees e
CROSS JOIN departments d
WHERE e.emp_no <= 10011
ORDER BY e.emp_no, d.dept_name;

-- Join & Aggregate functions
SELECT e.emp_no, e.gender, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

-- join multiple tables
SELECT e.first_name, e.last_name, e.hire_date, m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN departments d ON m.dept_no = d.dept_no;

SELECT e.first_name, e.last_name, e.hire_date, t.title, m.from_date, d.dept_name
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
JOIN titles t ON m.emp_no = t.emp_no
JOIN departments d ON m.dept_no = d.dept_no
WHERE t.title = 'Manager';

SELECT d.dept_name, AVG(salary)
FROM departments d
JOIN dept_manager m ON d.dept_no = m.dept_no
JOIN salaries s ON  m.emp_no = s.emp_no
GROUP BY d.dept_name;

-- EXCERCISE: how many male and female managers?
SELECT e.gender, COUNT(m.emp_no)
FROM employees e
JOIN dept_manager m ON e.emp_no = m.emp_no
GROUP BY e.gender;

/* UNION vs. UNION ALL
the SELECT columns should be the same,
union all contains duplicate values
union only display distinct values
*/

SELECT *
FROM
    (SELECT
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM employees e
    WHERE last_name = 'Denis' 
    UNION 
    SELECT
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM dept_manager dm) as a
ORDER BY -a.emp_no DESC;

/* Sub queries */
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.emp_no IN 
(SELECT m.emp_no 
FROM dept_manager m);

SELECT *
FROM employees
WHERE emp_no IN
(SELECT emp_no FROM dept_manager);

SELECT *
FROM dept_manager
WHERE emp_no in
(SELECT emp_no FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1995-01-01');

SELECT e.first_name, e.last_name
FROM employees e
WHERE EXISTS 
(SELECT * FROM dept_manager m
WHERE m.emp_no = e.emp_no)
ORDER BY emp_no;

SELECT * FROM employees
WHERE emp_no IN (
SELECT emp_no FROM titles
WHERE title = 'Assistant Engineer');

SELECT * FROM employees e
WHERE EXISTS 
(SELECT * FROM titles t
WHERE title = 'Assistant Engineer'
AND e.emp_no = t.emp_no);
-- Pick up the records from e that fullfil the conditions after EXISTS
-- Two tables should be connected by a same column

DROP TABLE if exists emp_manager;
CREATE TABLE emp_manager(
emp_no integer(11) NOT NULL,
dept_no CHAR(4) null,
manager_no integer(11) NOT NULL);

INSERT INTO emp_manager
SELECT 
    u.*
FROM
    (SELECT 
        a.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no <= 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no) AS a UNION 
    SELECT 
        b.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no > 10020
    GROUP BY e.emp_no
    ORDER BY e.emp_no
    LIMIT 20) AS b UNION SELECT 
        c.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110039) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110022
    GROUP BY e.emp_no) AS c UNION SELECT 
        d.*
    FROM
        (SELECT 
        e.emp_no AS employee_ID,
            MIN(de.dept_no) AS department_code,
            (SELECT 
                    emp_no
                FROM
                    dept_manager
                WHERE
                    emp_no = 110022) AS manager_ID
    FROM
        employees e
    JOIN dept_emp de ON e.emp_no = de.emp_no
    WHERE
        e.emp_no = 110039
    GROUP BY e.emp_no) AS d) as u;

-- SELF JOIN



-- view
CREATE OR REPLACE VIEW v_dept_emp_lastest_date AS
SELECT emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
FROM dept_emp
GROUP BY emp_no;

CREATE VIEW v_avg_manager_salary AS
SELECT s.emp_no, MAX(s.from_date), AVG(s.salary)
FROM salaries s
WHERE emp_no IN (
SELECT emp_no FROM dept_manager d)
ORDER BY emp_no;

SELECT s.emp_no, MAX(s.from_date), AVG(s.salary)
FROM salaries s
WHERE emp_no IN (
SELECT emp_no FROM dept_manager d)
ORDER BY emp_no;

-- Stored routines
DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$
CREATE PROCEDURE select_employees()
BEGIN
	SELECT * FROM employees
    LIMIT 500;
END$$

DELIMITER ;

CALL employees.select_employees();
CALL select_employees;
-- they are same

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, s.salary, s.from_date, s.to_date
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END$$
DELIMITER ;

call employees.emp_salary(11029);

-- INDEX, used in large datasets
SELECT * FROM employees
WHERE hire_date > '2000-01-01';

CREATE INDEX i_hire_date ON employees(hire_date);

SELECT * FROM employees
WHERE first_name = 'Georgi' AND last_name = 'Facello';

CREATE INDEX i_composite ON employees(first_name, last_name);

SHOW INDEX FROM employees FROM employees; -- FROM table_name FROM database_name
SHOW INDEX FROM employees;

DROP INDEX i_hire_date ON employees;


