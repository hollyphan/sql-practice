-- Parks & Recreation SQL Practice
-- Concepts: SELECT, WHERE, GROUP BY, HAVING, JOINs,
--           UNION, String Functions, CASE, Subqueries,
--           Window Functions, CTEs
-- Dataset: Alex the Analyst Parks & Rec practice database
-- Written from memory after completing Alex the Analyst SQL tutorial
-- Date: June 2026

-- SELECT all columns
SELECT *
FROM employee_demographics;

-- SELECT specific columns
SELECT first_name, last_name, age
FROM employee_demographics;

-- WHERE filter
SELECT *
FROM employee_demographics
WHERE age > 40;

-- GROUP BY with COUNT
SELECT dept_id, COUNT(employee_id)
FROM employee_salary
GROUP BY dept_id;

-- GROUP BY with AVG
SELECT dept_id, AVG(salary)
FROM employee_salary
GROUP BY dept_id;

-- HAVING
SELECT dept_id, AVG(salary)
FROM employee_salary
GROUP BY dept_id
HAVING AVG(salary) > 50000;

-- CONCAT
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

-- CASE with two conditions
SELECT first_name, last_name,
CASE
    WHEN age > 40 THEN 'Senior'
    ELSE 'Junior'
END AS seniority
FROM employee_demographics;

-- CASE with three conditions
SELECT first_name, last_name, salary,
CASE
    WHEN salary > 60000 THEN 'High Earner'
    WHEN salary BETWEEN 40000 AND 60000 THEN 'Average Earner'
    ELSE 'Low Earner'
END AS earning_level
FROM employee_salary;

-- Subquery
SELECT first_name, last_name, salary
FROM employee_salary
WHERE salary > (SELECT AVG(salary) FROM employee_salary);

-- Subquery on age
SELECT *
FROM employee_demographics
WHERE age > (SELECT AVG(age) FROM employee_demographics);

-- CTE
WITH above_average_salary AS (
    SELECT first_name, last_name, salary
    FROM employee_salary
    WHERE salary > (SELECT AVG(salary) FROM employee_salary)
)
SELECT *
FROM above_average_salary;

-- JOIN with aliases
SELECT dem.first_name, dem.last_name, dem.age, sal.salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id;

-- JOIN with WHERE filter
SELECT dem.first_name, dem.last_name, dem.age, sal.salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
    ON dem.employee_id = sal.employee_id
WHERE sal.dept_id = 1;

-- UNION
SELECT first_name
FROM employee_demographics
UNION
SELECT department_name
FROM parks_departments;

-- Window Function
SELECT first_name, last_name, salary, dept_id,
RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employee_salary;