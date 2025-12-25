DROP VIEW IF EXISTS v_Mailing_List
go
CREATE VIEW v_Mailing_List
AS
WITH w_mail AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email)           AS Email
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
        Email
,       LName
,       FName
,       w_street.Address1
,       w_street.Address2
,       City
,       State
,       Zip
FROM w_mail
INNER JOIN w_street
ON w_mail.LoadID = w_street.LoadID
go
