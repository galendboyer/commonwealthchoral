WITH
 w_chosen AS
(
  SELECT LoadID, ContactIPK, Email FROM
    (
    SELECT
           CAST(NULL AS INT) AS LoadID
    ,      CAST(NULL AS INT) AS ContactIPK
    ,      CAST(NULL AS VARCHAR(100)) AS Email
    UNION ALL
  -- Roster
  SELECT  1,1468,'carolhabrahams@gmail.com'               UNION ALL
  SELECT 77,NULL,'cctreas@proton.me'                      UNION ALL
  SELECT 12,NULL,'galendboyer@gmail.com'                  UNION ALL
  SELECT 57,1466,'nmacgaffey@gmail.com'                   UNION ALL
  SELECT  4,1467,'megan.baker1@gmail.com'                 UNION ALL
  -- Audience Subscribers
  SELECT 1035,NULL,'bkeller100@gmail.com'                   UNION ALL
  SELECT 1183,NULL,'jamesthist@gmail.com'                   UNION ALL
  SELECT 1020,NULL,'kenneth.mcintosh@childrens.harvard.edu' UNION ALL
  SELECT 1093,NULL,'leahdriscoll@me.com'                    UNION ALL
  SELECT 1021,NULL,'ronseverson@gmx.net'                    UNION ALL
  SELECT 1019,NULL,'selinathehill@gmail.com'                UNION ALL
  SELECT 1241,NULL,'skaufman@pcgus.com'                     UNION ALL
  SELECT 1271,NULL,'tdriscoll@esboulos.com'                 UNION ALL
  SELECT 1125,NULL,'w.hartner@northeastern.edu'             UNION ALL
    SELECT NULL,NULL,NULL
  ) t WHERE LoadID IS NOT NULL
)
,w_board AS
(
-- SELECT * from v_Volunteer WHERE CT_Board = 'Is_Doing' ORDER BY email
SELECT LoadID, Email FROM
  (
  SELECT CAST(NULL AS INT) AS LoadID
  ,      CAST(NULL AS VARCHAR(100)) AS Email
  UNION ALL
  SELECT 52,'abigailrosesweeney@gmail.com' UNION ALL
  SELECT 48,'cctreas@proton.me'            UNION ALL
  SELECT 27,'cej321@gmail.com'             UNION ALL
  SELECT 20,'fwgratz@gmail.com'            UNION ALL
  SELECT 25,'judyje15@gmail.com'           UNION ALL
  SELECT 13,'kosydney@gmail.com'           UNION ALL
  SELECT  7,'michele.berman@prodigy.net'   UNION ALL
  SELECT 40,'michele.michaud@comcast.net'  UNION ALL
  SELECT 36,'nmacgaffey@gmail.com'         UNION ALL
  SELECT NULL,NULL
  ) t WHERE LoadID IS NOT NULL
)
,w_select AS
(
SELECT
        'Individual' AS ContactType
,       w_chosen.ContactIPK        
,       COALESCE(w_chosen.Email,ros.Email) AS Email
,       COALESCE(ros.LName,subs.LName) AS Last
,       COALESCE(ros.FName,subs.FName) AS First
,       subs.tags AS SubscriberTags
,       ros.Voice_Part AS "Voice Part"
,       ros.MobilePH AS Cell
,       ros.WorkPH AS WorkPhone
,       ros.HomePH AS Phone
,       ros.Address1
,       ros.Address2
,       ros.City
,       ros.State AS "State/Province"
,       ros.ZIP AS "Zip/Postal Code"
-- ,       ros.Capabilities
-- ,       ros.IsCCActive
FROM  w_chosen
LEFT OUTER JOIN v_Member  ros
ON w_chosen.Email = ros.Email
LEFT OUTER JOIN w_board
ON ros.LoadID = w_board.LoadID
LEFT OUTER JOIN v_Subscriber subs
ON ros.email = subs.email
)
SELECT
        SubscriberTags
,       ContactType
,       ContactIPK        
,       Email
,       Last
,       First
,       "Voice Part"
-- ,       IsCCActive
,       Cell
,       WorkPhone
,       Phone
,       CAST('Yes' AS VARCHAR(10)) AS Active
,       Address1
,       Address2
,       City
,       "State/Province"
,       "Zip/Postal Code"
-- ,       Capabilities
-- ,       TasksInterested
-- ,       TasksDoing
FROM w_select
ORDER BY
 email
-- SubscriberTags, Last
