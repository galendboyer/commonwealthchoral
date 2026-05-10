WITH w_chosen AS (
  SELECT email FROM (
    SELECT CAST(NULL AS VARCHAR(50)) AS email
    UNION ALL
    SELECT '2018leilab@gmail.com' UNION ALL
    SELECT '9961kent@gmail.com' UNION ALL
    SELECT '99sjlee99@gmail.com' UNION ALL
    SELECT NULL
  ) t WHERE email IS NOT NULL
)
SELECT
        'Individual'  AS ContactType
,       'Supporter'   AS CCContactType       
,       'Subscriber'  AS CCContactSubType
,       v.Email
,       v.FName AS First
,       v.LName AS Last
-- ,       v.Full_Name
FROM v_Subscriber v
INNER JOIN w_chosen
ON v.email = w_chosen.email
WHERE v.tag_desc = 'Subscriber'

