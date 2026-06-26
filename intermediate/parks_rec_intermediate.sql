-- Parks & Recreation SQL Practice
-- Concepts: CTEs, Window Functions, Subqueries
-- Intermediate problems using GROUP BY, PARTITION BY, RANK, LAG/LEAD,
-- PERCENT_RANK, correlated subqueries, and multi-CTE queries
-- Dataset: Alex the Analyst Parks & Rec practice database
-- Written from memory after completing intermediate problem set
-- Date: June 2026


-- Running total of salary within each department ordered lowest to highest
SELECT first_name, last_name, department_name, salary,
    SUM(salary) OVER(PARTITION BY dept_id ORDER BY salary ASC) AS running_dept_salary
FROM employee_salary
JOIN parks_departments
    ON employee_salary.dept_id = parks_departments.department_id
;


-- Rank employees by salary within their department, highest salary = rank 1
SELECT first_name, last_name, department_name, salary,
    DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
FROM employee_salary
JOIN parks_departments
    ON employee_salary.dept_id = parks_departments.department_id
;


-- Employees earning above their department average
-- CTE calculates department average, outer query filters and joins
WITH dept_averages AS (
    SELECT dept_id, AVG(salary) AS dept_avg_salary
    FROM employee_salary
    GROUP BY dept_id
)
SELECT es.first_name, es.last_name, pd.department_name, es.salary, da.dept_avg_salary
FROM employee_salary es
JOIN dept_averages da
    ON es.dept_id = da.dept_id
JOIN parks_departments pd
    ON es.dept_id = pd.department_id
WHERE es.salary > da.dept_avg_salary
;


-- Department headcount and average salary shown on every employee row
-- CTE calculates stats per department, joined back to employee list
WITH dept_stats AS (
    SELECT dept_id,
        COUNT(*) AS dept_headcount,
        AVG(salary) AS dept_avg_salary
    FROM employee_salary
    GROUP BY dept_id
)
SELECT es.first_name, es.last_name, pd.department_name, es.salary,
    ds.dept_headcount, ds.dept_avg_salary
FROM employee_salary es
JOIN dept_stats ds
    ON es.dept_id = ds.dept_id
JOIN parks_departments pd
    ON es.dept_id = pd.department_id
;


-- Top 2 earners per department, ties included
-- Window function ranks inside CTE, outer query filters on rank
WITH ranked_salaries AS (
    SELECT es.first_name, es.last_name, pd.department_name, es.salary,
        DENSE_RANK() OVER(PARTITION BY es.dept_id ORDER BY es.salary DESC) AS salary_rank
    FROM employee_salary es
    JOIN parks_departments pd
        ON es.dept_id = pd.department_id
)
SELECT first_name, last_name, department_name, salary, salary_rank
FROM ranked_salaries
WHERE salary_rank <= 2
;


-- Employees in salary table with no record in demographics table
-- NOT IN subquery identifies the missing employee_ids
SELECT employee_id, first_name, last_name, occupation
FROM employee_salary
WHERE employee_id NOT IN (
    SELECT employee_id
    FROM employee_demographics
)
;


-- Global salary percentile rank across all employees
-- PERCENT_RANK returns 0 to 1, multiplied by 100 and rounded
SELECT first_name, last_name, salary,
    ROUND(PERCENT_RANK() OVER(ORDER BY salary) * 100, 2) AS percentile_rank
FROM employee_salary
;


-- Department salary summary using two chained CTEs
-- CTE 1 totals salary per department, CTE 2 counts headcount per department
WITH total_salary AS (
    SELECT dept_id,
        SUM(salary) AS dept_total_salary
    FROM employee_salary
    GROUP BY dept_id
),
headcount AS (
    SELECT dept_id,
        COUNT(*) AS dept_headcount
    FROM employee_salary
    GROUP BY dept_id
)
SELECT pd.department_name,
    ts.dept_total_salary,
    hc.dept_headcount,
    ROUND(ts.dept_total_salary / hc.dept_headcount, 2) AS avg_cost_per_head
FROM parks_departments pd
JOIN total_salary ts
    ON pd.department_id = ts.dept_id
JOIN headcount hc
    ON pd.department_id = hc.dept_id
;


-- Salary of the employee hired before and after each person
-- employee_id used as hire order proxy, LAG looks back, LEAD looks forward
SELECT employee_id, first_name, last_name, salary,
    LAG(salary) OVER(ORDER BY employee_id) AS prev_employee_salary,
    LEAD(salary) OVER(ORDER BY employee_id) AS next_employee_salary
FROM employee_salary
;


-- Headcount per department using a correlated subquery in SELECT
-- Subquery counts matching rows in employee_salary for each department row
SELECT department_name,
    (SELECT COUNT(*)
    FROM employee_salary es
    WHERE es.dept_id = pd.department_id) AS headcount
FROM parks_departments pd
;