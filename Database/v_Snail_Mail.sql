DROP VIEW IF EXISTS v_Snail_Mail
go
CREATE VIEW v_Snail_Mail
AS
WITH w_mail AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email)           AS Email
,       TRIM(Email_Roster)    AS Email_Roster
,       TRIM(LNameFName)      AS LNameFName
,       TRIM(LName)           AS LName
,       TRIM(FName)           AS FName
,       TRIM(Street)          AS Street
,       TRIM(Street1)         AS Street1
,       TRIM(City)            AS City
,       TRIM(State)           AS State
,       TRIM(Zip)             AS Zip
,       CAST(CAST(SOURCE_KEY AS DECIMAL(38,10)) AS INT) AS source_key
FROM t_Mailing_List
)
,w_street AS
(
SELECT
        LoadID
,       MAX(CASE WHEN s.ordinal = 1 THEN TRIM(s.value) END) AS Address1
,       MAX(CASE WHEN s.ordinal = 2 THEN TRIM(s.value) END) AS Address2
FROM w_mail
CROSS APPLY STRING_SPLIT(Street1, ',', 1) AS s
GROUP BY LoadID
)
SELECT
        w_mail.LoadID
,       LOWER(Email) AS Email
,       LOWER(Email_Roster) AS Email_Roster
,       source_key
,       CASE WHEN Email_Roster IS NOT NULL THEN 1 ELSE 0 END AS is_member_by_email
,       CASE WHEN source_key IN (3,4) THEN 1 ELSE 0 END AS is_member_by_source
,       CASE WHEN source_key IN (3,4) OR Email_Roster IS NOT NULL THEN 1 ELSE 0 END AS is_member
,       LName
,       FName
,       dbo.f_full_name(w_mail.FName,w_mail.LName) AS Full_Name
,       CONCAT(w_street.Address1,', ',w_street.Address2,', ',City,', ',State,', ',Zip) AS address_concat
,       w_street.Address1
,       w_street.Address2
,       City
,       State
,       Zip
FROM w_mail
INNER JOIN w_street
ON w_mail.LoadID = w_street.LoadID
go
