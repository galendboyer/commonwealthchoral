DROP VIEW IF EXISTS v_Subscriber
go
CREATE VIEW v_Subscriber
AS
WITH w_aud AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email)           AS Email
,       TRIM(FName)           AS FName
,       TRIM(LName)           AS LName
,       TRIM(OPTIN_TIME)      AS OPTIN_TIME
,       TRIM(TAGS1)           AS TAGS1
FROM t_Subscribed_Email_Audience
)
SELECT
        LoadID
,       LOWER(Email) AS Email
,       FName
,       LName
,       dbo.f_full_name(w_aud.FName,w_aud.LName) AS Full_Name
,       OPTIN_TIME
,       TAGS1
FROM w_aud
go
