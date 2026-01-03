DROP VIEW IF EXISTS v_Subscriber
go
CREATE VIEW v_Subscriber
AS
WITH w_subs AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email)           AS Email
,       TRIM(Email_Roster)    AS Email_Roster
,       TRIM(FName)           AS FName
,       TRIM(LName)           AS LName
,       TRIM(OPTIN_TIME)      AS OPTIN_TIME
,       TRIM(TAGS1)           AS TAGS1
FROM t_Subscribed_Email_Audience
)
SELECT
        LoadID
,       LOWER(Email) AS Email
,       LOWER(Email_Roster) AS Email_Roster
,       FName
,       LName
,       dbo.f_full_name(w_subs.FName,w_subs.LName) AS Full_Name
,       OPTIN_TIME
,       TAGS1 AS tags
,       CASE WHEN TAGS1 IN ('Alum','Alum before 2020','Roster') THEN 1 ELSE 0 END AS is_member
FROM w_subs
go
