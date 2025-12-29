DROP VIEW IF EXISTS v_Member
go
CREATE VIEW v_Member
AS
WITH w_roster AS
(SELECT  * FROM v_Roster)
,w_Subscriber AS
(
  SELECT *
  FROM v_Subscriber
  WHERE tags1 IN (
   'Alum'
  ,'Alum before 2020'
  ,'Roster'
  )
)
,w_Volunteer AS
(
)
SELECT
        w_roster.LoadID
,       w_roster.LName
,       w_roster.Fname
,       w_roster.Voice_Part
,       w_roster.Email
,       w_roster.Email2
,       w_roster.Email_Private
,       w_roster.IsCCActive
,       w_roster.CC_Role
,       w_roster.CC_YoungSinger
,       w_roster.HomePH
,       w_roster.MobilePH
,       w_roster.WorkPH
,       w_roster.Address1
,       w_roster.Address2
,       w_roster.City
,       w_roster.State
,       w_roster.zip
,       w_roster.Original_Phone
,       .capabilities
FROM w_roster ros
LEFT OUTER JOIN w_Subscriber sub
ON w_roster.email = w_v.email
LEFT OUTER JOIN 
go
