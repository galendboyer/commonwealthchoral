DROP VIEW IF EXISTS v_Member
go
CREATE VIEW v_Member
AS
SELECT
        ros.LoadID
,       ros.LName
,       ros.Fname
,       ros.Voice_Part
,       ros.Email
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
,       subs.tags
FROM v_roster ros
LEFT OUTER JOIN (SELECT * FROM v_subscriber WHERE is_member = 1) subs
ON ros.email = subs.email
LEFT OUTER JOIN v_volunteer vol
ON ros.email = vol.email
LEFT OUTER JOIN (SELECT * FROM v_snail_mail WHERE is_member = 1) mail
ON ros.email = mail.email
go
