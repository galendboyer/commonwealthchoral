
DROP VIEW IF EXISTS v_Subscribed_Email_Audience
go
CREATE VIEW v_Subscribed_Email_Audience
AS
WITH w_aud AS
(
SELECT
        TRIM(Email) AS Email
,       TRIM(FName) AS FName
,       TRIM(LName) AS LName
,       TRIM(OPTIN_TIME) AS OPTIN_TIME
,       TRIM(TAGS1) AS TAGS1
FROM t_Subscribed_Email_Audience
)
SELECT
        LOWER(Email) AS Email
,       FName
,       LName
,       OPTIN_TIME
,       TAGS1
FROM w_aud
go
