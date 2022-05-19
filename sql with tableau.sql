USE employees_mod;
SELECT 
YEAR(from_date) AS calender_year, 
gender, 
COUNT(e.emp_no) AS num_of_employees
FROM t_employees e
JOIN t_dept_emp d
ON d.emp_no = e.emp_no
GROUP BY calender_year, e.gender
HAVING calender_year >= 1990
ORDER BY calender_year;

SELECT 
d.dept_name, 
ee.gender,
dm.emp_no,
dm.from_date,
dm.to_date,
e.calender_year,
CASE
	WHEN e.calender_year BETWEEN YEAR(dm.from_date) AND YEAR(dm.to_date) THEN 1
    ELSE 0
END AS active
FROM 
	(SELECT YEAR(hire_date) AS calender_year
    FROM t_employees 
    GROUP BY calender_year) e  -- group by here to select distinct years
    CROSS JOIN t_dept_manager dm
    JOIN t_departments d
    ON dm.dept_no = d.dept_no
    JOIN t_employees ee
    ON dm.emp_no = ee.emp_no
ORDER BY  emp_no, calender_year;

SELECT 
e.gender,
d.dept_name,
ROUND(AVG(s.salary), 2) AS salary,
YEAR(s.from_date) AS calender_year
FROM t_employees e
JOIN t_salaries s
ON e.emp_no = s.emp_no
JOIN t_dept_emp de
ON e.emp_no = de.emp_no
JOIN t_departments d
ON de.dept_no = d.dept_no
GROUP BY calender_year, e.gender, d.dept_name
HAVING calender_year <= 2002
ORDER BY d.dept_no;

DROP procedure IF EXISTS filter_salary;

DELIMITER $$
USE emplpyees_mod $$
CREATE PROCEDURE filter_salary (IN p_min_salary FLOAT, IN p_max_salary FLOAT）
BEGIN
SELECT
	e.gender, d.dept_name, AVG(s.salary) AS avg_salary
FROM
	t_salaries s
    JOIN
    t_employees e ON s.emp_no = e.emp_no
    JOIN
    t_dept_emp de ON de.emp_no = e.emp_no
    JOIN
    t_departments d ON d.dept_no = de.dept_no
    WHERE s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_no, e.gender;
END $$

DELIMITER ;

CALL filter_salary(50000, 90000);

SELECT emp_no, first_name, last_name, 
CASE gender
WHEN 'M' THEN 'Male'
ELSE 'Female'
END AS gender
FROM t_employees
LIMIT 30;

SELECT e.emp_no, e.first_name, e.last_name,
CASE WHEN dm.emp_no IS NOT NULL THEN 'Manager'
ELSE 'Employee'
END AS is_manager
FROM t_employees e
LEFT JOIN t_dept_manager dm ON dm.emp_no = e.emp_no
WHERE e.emp_no > 109990;

SELECT  
    dm.emp_no,  
    e.first_name,  
    e.last_name,  
    MAX(s.salary) - MIN(s.salary) AS salary_difference,  
    IF(MAX(s.salary) - MIN(s.salary) > 30000, 'Salary was raised by more then $30,000', 'Salary was NOT raised by more then $30,000') AS salary_increase  
FROM  
    t_dept_manager dm  
        JOIN  
    t_employees e ON e.emp_no = dm.emp_no  
        JOIN  
    t_salaries s ON s.emp_no = dm.emp_no  
GROUP BY s.emp_no;