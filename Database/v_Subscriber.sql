DROP VIEW IF EXISTS v_Subscriber
go
CREATE VIEW v_Subscriber
AS
WITH w_subs AS (
SELECT
        CAST(LEFT(LoadID, CHARINDEX('.', LoadID + '.') - 1) AS INT) AS LoadID
        -- CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email)           AS Email
,       TRIM(Email_Roster)    AS Email_Roster
,       TRIM(FName)           AS FName
,       TRIM(LName)           AS LName
,       TRIM(OPTIN_TIME)      AS OPTIN_TIME
,       TRIM(TAGS1)           AS TAGS1
,       TRIM(IS_A_DUPLICATE)  AS IS_A_DUPLICATE
FROM t_Subscribed_Email_Audience
)
,w_subs2 AS (
SELECT
        LoadID
,       LOWER(Email) AS Email
,       LOWER(Email_Roster) AS Email_Roster
,       FName
,       LName
,       dbo.f_full_name(w_subs.FName,w_subs.LName) AS Full_Name
,       OPTIN_TIME
,       TAGS1
,       CASE WHEN lower(tags1) like 'alum%' THEN 'Alum' ELSE tags1 END AS tag_desc
,       IS_A_DUPLICATE
FROM w_subs
)
SELECT
        LoadID
,       Email_Roster AS Email
,       FName
,       LName
,       Full_Name
,       tags1
,       v_tag.tag_key
,       v_tag.tag_desc
FROM w_subs2
LEFT OUTER JOIN v_tag
ON w_subs2.tag_desc = v_tag.tag_desc
go
