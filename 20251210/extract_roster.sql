SELECT
        'Individual' AS ContactType
,       chosen.ContactIPK        
,       ros.Email AS Email
,       ros.LName AS Last
,       ros.FName AS First
,       ros.tags AS SubscriberTags
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
,       ros.TasksInterested
,       ros.TasksDoing
,       CAST('Yes' AS VARCHAR(10)) AS Active
FROM  v_tst_chosen chosen
LEFT OUTER JOIN v_Roster_Enriched  ros
ON chosen.Email = ros.Email
ORDER BY
 email
-- SubscriberTags, Last
