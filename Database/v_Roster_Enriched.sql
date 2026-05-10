DROP VIEW IF EXISTS v_Roster_Enriched
go
CREATE VIEW v_Roster_Enriched
AS
WITH
 w_ros AS
(
  SELECT
          ros.LoadID
  ,       ros.LName AS LName
  ,       ros.Fname AS FName
  ,       ros.Voice_Part
  ,       ros.Email AS Email
  ,       ros.Email2
  ,       ros.Email_Private
  ,       ros.IsCCActive
  ,       ros.CC_Role
  ,       ros.CC_YoungSinger
  ,       ros.HomePH
  ,       ros.MobilePH
  ,       ros.WorkPH
  ,       ros.Address1
  ,       ros.Address2
  ,       ros.City
  ,       ros.State
  ,       ros.zip
  ,       ros.Original_Phone
  ,       vol.Occupation
  ,       vol.Retired
  ,       vol.Capabilities
  ,       vol.TasksDoing
  ,       vol.TasksInterested
  FROM v_roster ros
  LEFT OUTER JOIN v_volunteer vol
  ON ros.email = vol.Email_Roster
)
-- ,w_subs AS
-- (
--   SELECT LoadID
--   ,      LName
--   ,      FName
--   ,      Email_Roster
--   ,      Email
--   ,      CASE WHEN LOWER(tags) LIKE 'alum%' Then 'Alum'
--               WHEN LOWER(tags) = 'subscriber' THEN 'Roster'
--               ELSE tags
--          END AS tags
--   FROM v_subscriber
--   WHERE Email_Roster IS NOT NULL
--   AND IS_A_DUPLICATE = 'No'
-- )
SELECT 
        w_ros.LoadID AS LoadID_ros
,       w_ros.LName
,       FName
,       w_ros.Voice_Part
,       Email
,       w_ros.Email2
,       w_ros.Email_Private AS isEmailPrivate
,       w_ros.IsCCActive AS isCCActive
,       w_ros.CC_Role
,       w_ros.CC_YoungSinger AS isYoungSinger
,       w_ros.HomePH
,       w_ros.MobilePH
,       w_ros.WorkPH
,       w_ros.Address1
,       w_ros.Address2
,       w_ros.City
,       w_ros.State
,       w_ros.zip
,       w_ros.Original_Phone
,       w_ros.Occupation
,       w_ros.Retired AS isRetired
,       w_ros.Capabilities
,       w_ros.TasksDoing
,       w_ros.TasksInterested
FROM w_ros
-- LEFT OUTER JOIN w_subs
-- ON w_ros.Email = w_subs.Email_Roster
go
