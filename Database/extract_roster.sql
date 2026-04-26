WITH w_chosen AS
(
SELECT
       ch.is_member
,      ch.LoadID
,      ch.ContactIPK
,      ch.Email
,      em.Email_tst
FROM v_tst_chosen ch
INNER JOIN v_tst_email em
ON ch.Email = em.Email
)
SELECT
        'Individual' AS ContactType
,       w_chosen.ContactIPK        
,       ros.CC_YoungSinger AS IsRosterYoungSinger
,       ros.CC_Role AS RosterRole
,       ros.IsCCActive AS IsRosterActive
,       CAST('Roster' AS VARCHAR(10))  AS CCContactType
,       ros.Occupation AS RSOccupation
,       CASE WHEN ros.Retired IS NULL THEN 'NA' ELSE ros.Retired END  AS 	RSIsRetired
,       ros.Email AS Email
-- ,       w_chosen.Email_tst AS Email
,       ros.LName AS Last
,       ros.FName AS First
,       ros.tags AS SubscriberTags
,       ros.Voice_Part AS RosterVoicePart
,       ros.MobilePH AS Cell
,       ros.WorkPH AS WorkPhone
,       ros.HomePH AS Phone
,       ros.Address1
,       ros.Address2
,       ros.City
,       ros.State AS "State/Province"
,       ros.ZIP AS "Zip/Postal Code"
,       ros.Capabilities AS RosterCapabilities
,       ros.TasksInterested AS RosterTasksInterested
,       ros.TasksDoing AS RosterTasksDoing
FROM  w_chosen
LEFT OUTER JOIN v_Roster_Enriched  ros
ON w_chosen.Email = ros.Email
WHERE 1=1
-- AND w_chosen.email IN
-- (NULL
-- ,'abigailrosesweeney@gmail.com'
-- ,'cej321@gmail.com'
-- ,'fwgratz@gmail.com'
-- )
ORDER BY email
-- SubscriberTags, Last
