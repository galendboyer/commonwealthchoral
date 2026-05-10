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
,       B_isYoungSinger AS B_IsYoungSinger
,       CC_Role AS RosterRole
,       B_isCCActive AS B_isRosterActive
,       CAST('Roster' AS VARCHAR(10))  AS ChoralContactType
,       Occupation
,       CASE WHEN B_isRetired IS NULL THEN 'NA' ELSE B_isRetired END  AS 	B_isRetired
,       COALESCE(w_chosen.Email,ros.Email) AS Email
,       ros.LName AS Last
,       ros.FName AS First
,       ros.tags AS MemberType
,       ros.Voice_Part AS RosterVoicePart
,       ros.MobilePH AS Cell
,       ros.WorkPH AS WorkPhone
,       ros.HomePH AS Phone
,       ros.Address1
,       ros.Address2
,       ros.City
,       State AS "State/Province"
,       ZIP AS "Zip/Postal Code"
,       Capabilities AS RosterCapabilities
,       TasksInterested AS RosterTasksInterested
,       TasksDoing AS RosterTasksDoing
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
