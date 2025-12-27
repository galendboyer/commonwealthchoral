WITH
 w_pk AS
(
SELECT
        ContactIPK
,       Email
FROM (
  SELECT CAST(NULL AS INT) AS ContactIPK
  ,      CAST(NULL AS VARCHAR(100)) AS Email
  UNION ALL
  SELECT 1468, 'carolhabrahams@gmail.com' UNION ALL
  SELECT 1467, 'megan.baker1@gmail.com' UNION ALL
  SELECT 1466, 'nmacgaffey@gmail.com' UNION ALL
  SELECT NULL, NULL
  ) t WHERE Email IS NOT NULL
)
,w_select AS
(
SELECT
        'Individual' AS ContactType
-- ,       w_pk.ContactIPK        
,       COALESCE(ros.Email,aud.Email) AS Email
,       COALESCE(ros.LName,aud.LName) AS Last
,       COALESCE(ros.FName,aud.FName) AS First
,       aud.tags1 AS SubscriberTags
,       ros.Voice_Part AS "Voice Part"
,       ros.MobilePH AS Cell
,       ros.WorkPH AS WorkPhone
,       ros.HomePH AS Phone
,       ros.Address1
,       ros.Address2
,       ros.City
,       ros.State AS "State/Province"
,       ros.ZIP AS "Zip/Postal Code"
,       ros.Capabilities
,       ros.IsCCActive
FROM v_Member_Roster  ros
-- LEFT OUTER JOIN w_pk
-- ON ros.Email = w_pk.Email
FULL OUTER JOIN v_Subscribed_Email_Audience aud
ON ros.email = aud.email
)
SELECT
        SubscriberTags
,       ContactType
-- ,    ContactIPK        
,       Email
,       Last
,       First
,       "Voice Part"
,       IsCCActive
-- ,       Cell
-- ,       WorkPhone
-- ,       Phone
-- ,       CAST('Yes' AS VARCHAR(10)) AS Active
-- ,       Address1
-- ,       Address2
-- ,       City
-- ,       "State/Province"
-- ,       "Zip/Postal Code"
,       Capabilities
FROM w_select
WHERE email in (NULL
-- Roster
,'galendboyer@gmail.com'
,'nmacgaffey@gmail.com'
,'carolhabrahams@gmail.com'
,'megan.baker1@gmail.com'
,'cctreas@proton.me'
-- Audience Subscribers
,'bkeller100@gmail.com'
,'w.hartner@northeastern.edu'
,'jamesthist@gmail.com'
,'skaufman@pcgus.com'
,'kenneth.mcintosh@childrens.harvard.edu'
,'tdriscoll@esboulos.com'
,'leahdriscoll@me.com'
,'selinathehill@gmail.com'
,'ronseverson@gmx.net'
)
ORDER BY SubscriberTags, Last
