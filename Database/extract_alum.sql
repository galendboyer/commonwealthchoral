WITH w_chosen AS (
  SELECT email FROM (
    SELECT CAST(NULL AS VARCHAR(50)) AS email
    UNION ALL
    SELECT 'acmorpe11@gmail.com' UNION ALL
    SELECT 'adrianne.fedorchuk@gmail.com' UNION ALL
    SELECT 'ae.arditti@gmail.com' UNION ALL
    SELECT NULL
  ) t WHERE email IS NOT NULL
)
SELECT 
       'Individual' AS ContactType
,      'Member'     AS CCContactCategory
,      'Alum'       AS CCContactType
,      v.Email
,      v.FName AS First
,      v.LName AS Last
-- ,      v.Full_Name
FROM v_Subscriber v
-- INNER JOIN w_chosen
-- ON v.email = w_chosen.email
WHERE v.tag_desc = 'Alum'
;
