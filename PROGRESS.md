# Progress Log

## 2026-06-21
- Cleaned up GitHub profile and repos
- Started freeCodeCamp SQL full course

## 2026-06-22
- Completed freeCodeCamp SQL full course
- Committed Python data pipeline updates to retail-ops-analytics

## 2026-06-23
- Started Alex the Analyst SQL tutorial
- Completed beginner section: SELECT, WHERE, GROUP BY, HAVING, LIMIT, aliasing
- Imported Parks & Rec database into TablePlus
- End of session practice: 7 queries from memory, 2 errors identified and fixed

## 2026-06-24
- Initialized sql-practice repo
- Set up folder structure: fundamentals, intermediate, advanced, challenges
- Completed intermediate section: JOINs, UNION, String Functions, CASE, Subqueries, Window Functions
- End of session practice: 6 queries from memory, 4 errors identified and fixed

## 2026-06-25
- Completed advanced section: CTEs, Temp Tables
- Consolidation practice: all concepts written from memory, all queries clean
- Committed parks_rec_fundamentals.sql to fundamentals/

## 2026-06-26
- Completed active recall review of all intermediate and advanced SQL concepts
  - Concepts covered: JOINs, GROUP BY, WHERE vs HAVING, subqueries, CASE WHEN, UNION, CTEs, window functions, ROW_NUMBER/RANK/DENSE_RANK, LAG/LEAD, recursive CTEs
- Completed intermediate problem set (10/10 correct)
- Committed parks_rec_intermediate.sql to intermediate/

## 2026-06-27
- Completed advanced problem set (ADV-01 through ADV-10)
  - Concepts covered: recursive CTEs, NTILE, PERCENT_RANK, LAG/LEAD, multi-CTE queries, org hierarchy traversal, salary gap analysis, retention proxies
- Committed parks_rec_advanced.sql to advanced/
- Started LeetCode SQL 50 — Select section, Easy tier (5/5 complete)
  - Recyclable and Low Fat Products
  - Find Customer Referee
  - Big Countries
  - Article Views I
  - Invalid Tweets
  - Concepts covered: basic SELECT, WHERE with multiple conditions, OR logic, NULL handling (IS NULL / IS NOT NULL), LENGTH() for string filtering

## 2026-06-29
- Cold recall warm-up: 4/5 correct on first pass (WHERE/HAVING, LEFT JOIN behavior, RANK/DENSE_RANK concept correct; derived table naming and CTE definition required correction)
- Correlated subquery execution direction: outstanding item from prior session, resolved and correctly restated (outer query drives, feeds each row to inner query, inner re-executes per row)
- LeetCode SQL 50 — Managers with at Least 5 Direct Reports (Medium): solved after one correction round (GROUP BY column typo, HAVING off-by-one). Drilled COUNT(*) vs COUNT(column) NULL-exclusion behavior.
- LeetCode SQL 50 — Confirmation Rate (Medium): started, stopped mid-approach. Missed that denominator requires total requests, not just confirmed count. Open item for next session.

## 2026-06-30
- Cold recall warm-up: 4/5 correct on first pass; correlated subquery execution direction fully restated and closed out from prior session
- LeetCode SQL 50 — Confirmation Rate (Medium): completed. Drilled LEFT JOIN as base table anchor, conditional aggregation with SUM(CASE WHEN), ROUND(), COALESCE necessity vs. ELSE 0 distinction.
- LeetCode SQL 50 — Not Boring Movies (Easy): completed after two syntax corrections (IS NOT vs !=, MOD syntax). MOD(column, divisor) = 1 pattern for odd number filtering.
- LeetCode SQL 50 — Average Selling Price (Easy): completed after multiple correction rounds. Key lessons: SUM(price * units) / SUM(units) for weighted average, date range condition belongs in ON clause not WHERE, LEFT JOIN required when products may have no matching sales rows, COALESCE(ROUND(...), 0) to handle NULL from unmatched LEFT JOIN rows.
- LeetCode SQL 50 — Project Employees I (Easy): completed. AVG() for straight averages vs SUM()/SUM() for weighted averages.
- LeetCode SQL 50 — Percentage of Users Attended a Contest (Easy): completed. Subquery in SELECT clause for fixed denominator, COUNT() / (SELECT COUNT() FROM table) * 100 percentage pattern, GROUP BY and ORDER BY are separate clauses.

## 2026-07-01
- Completed all 18 SQLBolt lessons (Intro through Dropping Tables) — full syntax fluency pass: SELECT, constraints, filtering/sorting, JOINs (incl. OUTER), NULLs, expressions, aggregates, order of execution, INSERT/UPDATE/DELETE, CREATE/ALTER/DROP TABLE
- Cold recall warm-up: MOD() syntax, weighted vs. straight average, correlated subquery mechanism, WHERE vs. ON, COUNT(*) vs. COUNT(column) — all corrected and restated cleanly, dropped from active rotation
- LeetCode SQL 50 — Basic Aggregate Functions section: COMPLETE (8/8, including all 3 Medium problems)

## 2026-07-02
- LeetCode SQL 50 — Sorting and Grouping section: COMPLETE (7/7, including both Mediums)
  - Number of Unique Subjects Taught by Each Teacher (Easy): COUNT(DISTINCT column) with GROUP BY
  - User Activity for the Past 30 Days I (Easy): SUBDATE/INTERVAL for rolling date range in WHERE, COUNT(DISTINCT) grouped by date
  - Product Sales Analysis III (Medium): subquery aggregates MIN(year) per group, joined back on composite key (product_id + year) to pull first-occurrence rows
  - Classes With at Least 5 Students (Easy): GROUP BY + HAVING COUNT() >= threshold
  - Find Followers Count (Easy): GROUP BY with COUNT(DISTINCT), ORDER BY
  - Biggest Single Number (Easy): nested query — GROUP BY HAVING COUNT(*)=1 isolates unique values, outer MAX() on filtered set
  - Customers Who Bought All Products (Medium): GROUP BY HAVING COUNT(DISTINCT) = scalar subquery total — set-containment/"division" pattern

## 2026-07-03
- LeetCode SQL 50 — Advanced Select and Joins section: COMPLETE (7/7)
  - The Number of Employees Which Report to Each Employee (Easy): self-join (employees table to itself) to pair each employee with their manager, GROUP BY manager, AVG() with ROUND()
  - Primary Department for Each Employee (Easy): UNION combining primary-flagged rows with employees who have only one department (HAVING COUNT(employee_id)=1)
  - Triangle Judgement (Easy): CASE WHEN applying triangle inequality across three side columns
  - Consecutive Numbers (Medium): LAG() window function with two offsets to compare current row against two preceding rows, DISTINCT to dedupe
  - Product Price at a Given Date (Medium): derived table for MAX(change_date) per product up to cutoff, joined back on product_id + date; UNION with NOT IN subquery to default price 10 for products with no prior change
  - Last Person to Fit in the Bus (Medium): running total via SUM() OVER (ORDER BY), filtered to <=1000, ORDER BY DESC LIMIT 1 to isolate the last qualifying row
  - Count Salary Categories (Medium): conditional COUNT via CASE WHEN inside COUNT(), UNION ALL to stack category rows

- LeetCode SQL 50 — Subqueries section: COMPLETE (7/7)
  - Employees Whose Manager Left the Company (Easy): NOT EXISTS to filter employees whose manager_id has no matching row in the employees table
  - Exchange Seats (Medium): CASE WHEN on odd/even id parity, LEAST() with subquery MAX(id) to handle the last unpaired seat
  - Movie Rating (Medium): two independent ranked subqueries (most ratings by user, highest avg rating by movie in a date range) combined with UNION ALL
  - Restaurant Growth (Medium): CTE chain — daily total via GROUP BY, then rolling 7-day SUM() OVER with ROWS BETWEEN, ROW_NUMBER() to exclude incomplete leading windows
  - Friend Requests II: Who Has the Most Friends (Medium): UNION ALL to combine requester and accepter into one id column, GROUP BY + COUNT to find max
  - Investments in 2016 (Medium): correlated conditions via IN subqueries — duplicate tiv_2015 values and unique (lat, lon) pairs — combined with SUM
  - Department Top Three Salaries (Hard): CTE with DENSE_RANK() PARTITION BY department, JOIN back to department table, filtered to rank <=3
