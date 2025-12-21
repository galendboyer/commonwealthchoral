DROP VIEW IF EXISTS v_quickbooks
go
CREATE VIEW v_quickbooks
AS
WITH

 w_hard AS
(
SELECT LOWER(full_name_ds) AS full_name_ds, LOWER(full_name_qb) AS full_name_qb
FROM
  (
  SELECT CAST(NULL AS VARCHAR(100)) AS full_name_ds
  ,      CAST(NULL AS VARCHAR(100)) AS full_name_qb
  UNION ALL
  SELECT 'bob keller', 'robert keller' UNION ALL
  SELECT 'rosalind walter', 'ros walter' UNION ALL
  SELECT 'bruce longee', 'bruce longy' UNION ALL
  SELECT 'dan fabiano', 'daniel fabiano' UNION ALL
  SELECT 'jenn jerome', 'jennifer jerome' UNION ALL
  SELECT 'matthew mcdonald', 'matt macdonald' UNION ALL
  SELECT 'lissa gilbert', 'elizabeth gilbert' UNION ALL
  SELECT 'mark feldhusen', 'mark feldhusen-donor' UNION ALL
  SELECT 'elizabeth gerlach', 'betsy gerlach' UNION ALL
  SELECT 'jeff fried', 'jeffrey fried' UNION ALL
  SELECT 'pamela goody', 'pam goody' UNION ALL
  SELECT 'meg gayton', 'meghan gayton' UNION ALL
  SELECT 'neil macgaffey', 'neil mcgaffey' UNION ALL
  SELECT 'kate leitermann', 'kathleen leitermann' UNION ALL
  SELECT 'william hartner', 'bill hartner' UNION ALL
  SELECT 'ann mahoney', 'anna mahoney' UNION ALL
  SELECT 'philip carens', 'phil carens' UNION ALL
  SELECT 'san lee', 'sansan lee' UNION ALL
  SELECT 'stacey richard', 'stacy richard' UNION ALL
  -- SELECT '', '' UNION ALL
  SELECT NULL, NULL 
  ) t WHERE full_name_ds IS NOT NULL
)

,w_chorus AS
(
SELECT
       LOWER(CONCAT(First, ' ',Last)) AS full_name
,      Email
FROM v_chorus
)

,w_quickbooks AS
(
SELECT
        CASE WHEN w_hard.full_name_qb IS NULL THEN LOWER(t.full_name) ELSE w_hard.full_name_ds END AS full_name
,       t.full_name as full_name_ds
,       w_hard.full_name_qb
,       Email
,       Customer_ID
FROM t_donor_snap_integrate t
LEFT OUTER JOIN w_hard
ON t.full_name = w_hard.full_name_qb
)

,w_final AS (
SELECT
        w_chorus.full_name AS full_name_ds
,       w_quickbooks.full_name as full_name_qb
,       w_chorus.Email AS email_ds
,       w_quickbooks.Email as email_qb
,       w_quickbooks.Customer_ID
FROM w_chorus
FULL OUTER JOIN w_quickbooks
ON w_chorus.full_name = w_quickbooks.full_name
)

SELECT * FROM w_final 
--ORDER BY COALESCE(full_name_ds,full_name_qb) DESC
go
