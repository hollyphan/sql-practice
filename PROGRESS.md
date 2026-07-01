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
- Completed intermediate section: JOINs, UNION, String Functions, CASE,
  Subqueries, Window Functions
- End of session practice: 6 queries from memory, 4 errors identified and fixed

## 2026-06-25
- Completed advanced section: CTEs, Temp Tables
- Consolidation practice: all concepts written from memory, all queries clean
- Committed parks_rec_fundamentals.sql to fundamentals/
- Starting LeetCode SQL 50 next session

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
- Problems completed: Recyclable and Low Fat Products, Find Customer Referee, Big Countries, Article Views I, Invalid Tweets
- Concepts covered: basic SELECT, WHERE with multiple conditions, OR logic, NULL handling with IS NULL / IS NOT NULL, LENGTH() for string filtering

## 2026-06-29

- Cold recall warm-up: 4/5 correct on first pass (WHERE/HAVING, LEFT JOIN behavior, RANK/DENSE_RANK concept correct; derived table naming and CTE definition required correction)
- Correlated subquery execution direction: outstanding item from prior session, resolved and correctly restated (outer query drives, feeds each row to inner query, inner re-executes per row)
- LeetCode SQL 50 - Managers with at Least 5 Direct Reports (Medium): solved after one correction round (GROUP BY column typo, HAVING off-by-one). Drilled COUNT(*) vs COUNT(column) NULL-exclusion behavior and why they're equivalent when counting the GROUP BY column itself
- LeetCode SQL 50 - Confirmation Rate (Medium): started, stopped mid-approach. Identified need for confirmed rows but missed that the denominator requires total requests, not just confirmed count. Open item for next session.

## 2026-06-30

- Cold recall warm-up: 4/5 correct on first pass; correlated subquery execution direction fully restated and closed out from prior session
- LeetCode SQL 50 - Confirmation Rate (Medium): completed. Drilled LEFT JOIN as base table anchor, conditional aggregation with SUM(CASE WHEN), ROUND(), and COALESCE necessity vs. ELSE 0 distinction
- LeetCode SQL 50 - Not Boring Movies (Easy): completed after two syntax corrections (IS NOT vs !=, MOD syntax). MOD(column, divisor) = 1 pattern for odd number filtering
- LeetCode SQL 50 - Average Selling Price (Easy): completed after multiple correction rounds. Key lessons: SUM(price * units) / SUM(units) for weighted average, date range condition belongs in ON clause not WHERE, LEFT JOIN required when products may have no matching sales rows, COALESCE(ROUND(...), 0) to handle NULL from unmatched LEFT JOIN rows
- LeetCode SQL 50 - Project Employees I (Easy): completed. AVG() for straight averages vs SUM()/SUM() for weighted averages
- LeetCode SQL 50 - Percentage of Users Attended a Contest (Easy): completed. Subquery in SELECT clause for fixed denominator, COUNT(*) / (SELECT COUNT(*) FROM table) * 100 percentage pattern, GROUP BY and ORDER BY are separate clauses

## 2026-07-01
- Completed all 18 SQLBolt lessons (Intro through Dropping Tables) — full syntax fluency pass: SELECT, constraints, filtering/sorting, JOINs (incl. OUTER), NULLs, expressions, aggregates, order of execution, INSERT/UPDATE/DELETE, CREATE/ALTER/DROP TABLE.
- Completed cold recall warm-up: MOD() syntax, weighted vs. straight average, 
  correlated subquery mechanism, WHERE vs. ON, COUNT(*) vs. COUNT(column) — 
  all corrected and restated cleanly, dropped from active rotation
- LeetCode SQL 50 — Basic Aggregate Functions section: COMPLETE (8/8, including 
  all 3 Medium problems)