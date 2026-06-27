-- Parks & Recreation SQL Practice
-- Concepts: Recursive CTEs, NTILE, PERCENT_RANK, LAG/LEAD, Multi-CTE Queries
-- Advanced problems using org hierarchy traversal, salary analytics, retention proxies,
-- and full salary reports combining multiple window functions in a single query
-- Dataset: Alex the Analyst Parks & Rec practice database
-- Written from memory after completing advanced problem set
-- Date: June 2026


-- Recursive CTE walks the org hierarchy using employee_id and dept_id as proxies
-- Anchor starts at employee_id 2, recursive member joins on shared dept_id
-- Level column increments with each recursive step to show depth
WITH RECURSIVE org_hierarchy AS (
    SELECT employee_id, first_name, last_name, dept_id,
        1 AS level
    FROM employee_salary
    WHERE employee_id = 2

    UNION ALL

    SELECT es.employee_id, es.first_name, es.last_name, es.dept_id,
        oh.level + 1
    FROM employee_salary es
    JOIN org_hierarchy oh
        ON es.dept_id = oh.dept_id
    WHERE es.employee_id > oh.employee_id
)
SELECT *
FROM org_hierarchy
ORDER BY level, employee_id
;


-- Cumulative headcount using employee_id as a hire order proxy
-- COUNT(*) as a window function with ORDER BY produces a running total
SELECT employee_id, first_name, last_name,
    COUNT(*) OVER(ORDER BY employee_id) AS cumulative_headcount
FROM employee_demographics
ORDER BY employee_id
;


-- Salary quartiles assigned using NTILE(4) across all employees
-- CASE statement converts quartile number to Q1-Q4 label
-- Final filter returns only employees in the bottom quartile
WITH quartiles AS (
    SELECT ed.employee_id, ed.first_name, ed.last_name, es.salary,
        NTILE(4) OVER(ORDER BY es.salary) AS quartile
    FROM employee_demographics ed
    JOIN employee_salary es
        ON ed.employee_id = es.employee_id
)
SELECT employee_id, first_name, last_name, salary,
    CASE
        WHEN quartile = 1 THEN 'Q1'
        WHEN quartile = 2 THEN 'Q2'
        WHEN quartile = 3 THEN 'Q3'
        WHEN quartile = 4 THEN 'Q4'
    END AS quartile_label
FROM quartiles
WHERE quartile = 1
;


-- Department salary growth month over month using birth_date as a date proxy
-- First CTE calculates average salary per department per month
-- Second CTE applies LAG to get prior month average for comparison
-- Outer query returns the single department-month with highest salary growth
WITH dept_monthly AS (
    SELECT es.dept_id,
        MONTH(ed.birth_date) AS month_proxy,
        AVG(es.salary) AS avg_salary
    FROM employee_salary es
    JOIN employee_demographics ed
        ON es.employee_id = ed.employee_id
    GROUP BY es.dept_id, MONTH(ed.birth_date)
),
with_lag AS (
    SELECT dept_id, month_proxy, avg_salary,
        LAG(avg_salary) OVER(PARTITION BY dept_id ORDER BY month_proxy) AS prev_avg_salary
    FROM dept_monthly
)
SELECT dept_id, month_proxy, avg_salary, prev_avg_salary,
    avg_salary - prev_avg_salary AS salary_growth
FROM with_lag
WHERE prev_avg_salary IS NOT NULL
ORDER BY salary_growth DESC
LIMIT 1
;


-- Employees earning above their own department average
-- CTE calculates average salary per department, joined back to filter employees
-- Returns name, salary, department, and department average for context
WITH dept_avg AS (
    SELECT dept_id,
        AVG(salary) AS avg_salary
    FROM employee_salary
    GROUP BY dept_id
)
SELECT ed.first_name, ed.last_name, es.salary, es.dept_id,
    ROUND(da.avg_salary, 2) AS dept_avg_salary
FROM employee_demographics ed
JOIN employee_salary es
    ON ed.employee_id = es.employee_id
JOIN dept_avg da
    ON es.dept_id = da.dept_id
WHERE es.salary > da.avg_salary
ORDER BY es.dept_id, es.salary DESC
;


-- Running headcount and cumulative salary per department over time
-- employee_id used as hire order proxy within each department
-- Both window functions partition by dept_id and order by employee_id
SELECT ed.first_name, ed.last_name, es.dept_id, es.salary,
    COUNT(*) OVER(PARTITION BY es.dept_id ORDER BY ed.employee_id) AS running_headcount,
    SUM(es.salary) OVER(PARTITION BY es.dept_id ORDER BY ed.employee_id) AS cumulative_salary
FROM employee_demographics ed
JOIN employee_salary es
    ON ed.employee_id = es.employee_id
ORDER BY es.dept_id, ed.employee_id
;


-- Employees in the top 25% globally and bottom 50% within their own department
-- Two PERCENT_RANK window functions in the same CTE, one global and one partitioned
-- Outer query filters on both thresholds simultaneously
WITH percentiles AS (
    SELECT ed.employee_id, ed.first_name, ed.last_name, es.salary, es.dept_id,
        PERCENT_RANK() OVER(ORDER BY es.salary) AS global_percentile,
        PERCENT_RANK() OVER(PARTITION BY es.dept_id ORDER BY es.salary) AS dept_percentile
    FROM employee_demographics ed
    JOIN employee_salary es
        ON ed.employee_id = es.employee_id
)
SELECT *
FROM percentiles
WHERE global_percentile >= 0.75
AND dept_percentile <= 0.50
;


-- Salary gaps between consecutive earners ordered lowest to highest
-- LEAD looks at the next salary in line, gap is the difference between them
-- Returns the 5 largest gaps across all employees
WITH salary_order AS (
    SELECT ed.first_name, ed.last_name, es.salary,
        LEAD(es.salary) OVER(ORDER BY es.salary) AS next_salary
    FROM employee_demographics ed
    JOIN employee_salary es
        ON ed.employee_id = es.employee_id
)
SELECT first_name, last_name, salary, next_salary,
    next_salary - salary AS salary_gap
FROM salary_order
WHERE next_salary IS NOT NULL
ORDER BY salary_gap DESC
LIMIT 5
;


-- Department retention proxy treating low employee_id as a signal of long tenure
-- Long-tenured defined as employee_id <= 6, counted per department using CASE
-- Retention rate expressed as a percentage of total department headcount
WITH retention AS (
    SELECT dept_id,
        COUNT(*) AS total_employees,
        SUM(CASE WHEN employee_id <= 6 THEN 1 ELSE 0 END) AS long_tenured
    FROM employee_salary
    WHERE dept_id IS NOT NULL
    GROUP BY dept_id
)
SELECT dept_id, total_employees, long_tenured,
    ROUND(long_tenured / total_employees * 100, 2) AS retention_rate
FROM retention
ORDER BY retention_rate DESC
;


-- Full salary report combining four window functions in a single query
-- Department rank by salary descending, running department total by hire order,
-- difference from department average, and global salary percentile
WITH salary_metrics AS (
    SELECT ed.first_name, ed.last_name, es.dept_id, es.salary,
        RANK() OVER(PARTITION BY es.dept_id ORDER BY es.salary DESC) AS dept_rank,
        SUM(es.salary) OVER(PARTITION BY es.dept_id ORDER BY ed.employee_id) AS running_dept_total,
        AVG(es.salary) OVER(PARTITION BY es.dept_id) AS dept_avg,
        PERCENT_RANK() OVER(ORDER BY es.salary) AS global_percentile
    FROM employee_demographics ed
    JOIN employee_salary es
        ON ed.employee_id = es.employee_id
)
SELECT first_name, last_name, dept_id, salary,
    dept_rank,
    running_dept_total,
    ROUND(salary - dept_avg, 2) AS diff_from_dept_avg,
    ROUND(global_percentile * 100, 2) AS global_percentile_pct
FROM salary_metrics
ORDER BY dept_id, dept_rank
;