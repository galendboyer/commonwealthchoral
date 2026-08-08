WITH w_chosen AS (
  SELECT email FROM (
    SELECT CAST(NULL AS VARCHAR(50)) AS email
    UNION ALL
    SELECT 'carolhabrahams@gmail.com'               UNION ALL
    SELECT 'cctreas@proton.me'                      UNION ALL
    SELECT 'galendboyer@gmail.com'                  UNION ALL
    SELECT 'nmacgaffey@gmail.com'                   UNION ALL
    SELECT 'megan.baker1@gmail.com'                 UNION ALL
    SELECT NULL
  ) t WHERE email IS NOT NULL
)
SELECT
       'Individual' AS ContactType
,      'Member'     AS CCContactCategory
,      'Roster'     AS CCContactType
,       v.isYoungSinger AS CCIsRosterYoungSinger
,       v.CC_Role AS CCRosterRole
,       v.isCCActive AS CCisRosterActive
,       v.Occupation AS CCOccupation
,       CASE WHEN v.isRetired IS NULL THEN 'NA' ELSE v.isRetired END  AS 	CCisRetired
,       v.Email AS Email
,       v.LName AS Last
,       v.FName AS First
,       v.Voice_Part AS CCRosterVoicePart
,       v.MobilePH AS Cell
,       v.WorkPH AS WorkPhone
,       v.HomePH AS Phone
,       v.Address1
,       v.Address2
,       v.City
,       v.State AS "State/Province"
,       v.ZIP AS "Zip/Postal Code"
,       v.Capabilities AS CCRosterCapabilities
,       v.TasksInterested AS CCRosterTasksInterested
,       v.TasksDoing AS CCRosterTasksDoing
FROM  v_Roster_Enriched v
-- INNER JOIN  w_chosen
-- ON v.email = w_chosen.email
ORDER BY v.email
