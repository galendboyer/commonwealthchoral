DROP TABLE IF EXISTS t_Volunteer_Responses
go
CREATE TABLE t_Volunteer_Responses
(
  LoadID VARCHAR(MAX)
, Timestmp       VARCHAR(MAX)
, Email          VARCHAR(MAX)
, Full_Name      VARCHAR(MAX)
, LName          VARCHAR(MAX)
, FName          VARCHAR(MAX)
, Occupation     VARCHAR(MAX)
, Retired        VARCHAR(MAX)
, Capabilities   VARCHAR(MAX)
, CT_Ads         VARCHAR(MAX)
, CT_Board       VARCHAR(MAX)
, CT_Concerts    VARCHAR(MAX)
, CT_Development VARCHAR(MAX)
, CT_Finance     VARCHAR(MAX)
, CT_Hospitality VARCHAR(MAX)
, CT_Investment  VARCHAR(MAX)
, CT_Marketing   VARCHAR(MAX)
, CT_Membership  VARCHAR(MAX)
, CT_Outreach    VARCHAR(MAX)
, CT_ProgramBook VARCHAR(MAX)
, CT_Rehearsal   VARCHAR(MAX)
, CT_Technology  VARCHAR(MAX)
, CT_Website     VARCHAR(MAX)
, CT_SocialMedia VARCHAR(MAX)
)
go


DROP TABLE IF EXISTS t_Member_Roster
go
CREATE TABLE t_Member_Roster
(
  LoadID            VARCHAR(MAX)
, Lname             VARCHAR(MAX)
, Fname             VARCHAR(MAX)
, Voice             VARCHAR(MAX)
, Email             VARCHAR(MAX)
, Active            VARCHAR(MAX)
, CC_Role           VARCHAR(MAX)
, CC_YoungSinger    VARCHAR(MAX)
, HomePH            VARCHAR(MAX)
, MobilePH          VARCHAR(MAX)
, WorkPH            VARCHAR(MAX)
, Address           VARCHAR(MAX)
, AddressNormalized VARCHAR(MAX)
, Original_Phone    VARCHAR(MAX)
)
go


DROP TABLE IF EXISTS t_Mailing_List
go
CREATE TABLE t_Mailing_List
(
  LoadID VARCHAR(MAX)
, Email  VARCHAR(MAX)
, LNameFname  VARCHAR(MAX)
, LName  VARCHAR(MAX)
, FName  VARCHAR(MAX)
, Street  VARCHAR(MAX)
, Street1  VARCHAR(MAX)
, City  VARCHAR(MAX)
, State  VARCHAR(MAX)
, Zip  VARCHAR(MAX)
, SOURCE_KEY VARCHAR(MAX)
)
go


DROP TABLE IF EXISTS t_Subscribed_Email_Audience
go
CREATE TABLE t_Subscribed_Email_Audience
(
  LoadID         VARCHAR(MAX)
, Email          VARCHAR(MAX)
, FName          VARCHAR(MAX)
, LName          VARCHAR(MAX)
, Address_line_1 VARCHAR(MAX)
, Address_line_2 VARCHAR(MAX)
, City           VARCHAR(MAX)
, State          VARCHAR(MAX)
, Zip_code       VARCHAR(MAX)
, Website        VARCHAR(MAX)
, EMAIL_TYPE     VARCHAR(MAX)
, MEMBER_RATING  VARCHAR(MAX)
, OPTIN_TIME     VARCHAR(MAX)
, OPTIN_IP       VARCHAR(MAX)
, CONFIRM_TIME   VARCHAR(MAX)
, CONFIRM_IP     VARCHAR(MAX)
, GMTOFF         VARCHAR(MAX)
, DSTOFF         VARCHAR(MAX)
, TIMEZONE       VARCHAR(MAX)
, CC             VARCHAR(MAX)
, REGION         VARCHAR(MAX)
, LAST_CHANGED   VARCHAR(MAX)
, LEID           VARCHAR(MAX)
, EUID           VARCHAR(MAX)
, NOTES          VARCHAR(MAX)
, TAGS           VARCHAR(MAX)
, TAGS1          VARCHAR(MAX)
)
go
DROP VIEW IF EXISTS v_Member_Roster
go
CREATE VIEW v_Member_Roster
AS
WITH w_roster AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Lname)           AS LName
,       TRIM(Fname)           AS Fname
,       TRIM(Voice)           AS Voice_Part
,       TRIM(Email)           AS Email
,       TRIM(Active)          AS IsCCActive
,       TRIM(CC_Role)         AS CC_Role
,       TRIM(CC_YoungSinger)  AS CC_YoungSinger
,       TRIM(HomePH)          AS HomePH
,       TRIM(MobilePH)        AS MobilePH
,       TRIM(WorkPH)          AS WorkPH
,       TRIM(AddressNormalized)        AS AddressNormalized
,       TRIM(Original_Phone)  AS Original_Phone
FROM t_Member_Roster
)
,w_voicepart AS
(
SELECT code, description FROM (
  SELECT CAST(NULL AS VARCHAR(1)) AS code
  ,      CAST(NULL AS VARCHAR(10)) AS description
  UNION ALL
  SELECT 'S', 'Soprano' UNION ALL
  SELECT 'A', 'Alto'    UNION ALL
  SELECT 'T', 'Tenor'   UNION ALL
  SELECT 'B', 'Bass'    UNION ALL
  SELECT 'N', 'None'    UNION ALL
  SELECT NULL, NULL
  ) t WHERE code IS NOT NULL
)
,w_address AS
(
SELECT
        LoadID
,       MAX(CASE WHEN s.ordinal = 1 THEN TRIM(s.value) END) AS Address1
,       MAX(CASE WHEN s.ordinal = 2 THEN TRIM(s.value) END) AS Address2
,       MAX(CASE WHEN s.ordinal = 3 THEN TRIM(s.value) END) AS City
,       MAX(CASE WHEN s.ordinal = 4 THEN TRIM(s.value) END) AS State
,       MAX(CASE WHEN s.ordinal = 5 THEN TRIM(s.value) END) AS ZIP
FROM w_roster
CROSS APPLY STRING_SPLIT(AddressNormalized, ',', 1) AS s
GROUP BY LoadID
)
SELECT
        w_roster.LoadID
,       w_roster.LName
,       w_roster.Fname
,       LOWER(CONCAT(w_roster.FName,' ', w_roster.LName)) AS Full_Name
,       w_voicepart.description AS Voice_Part
,       LOWER(w_roster.Email) AS Email
,       w_roster.IsCCActive
,       w_roster.CC_Role
,       w_roster.CC_YoungSinger
,       w_roster.HomePH
,       w_roster.MobilePH
,       w_roster.WorkPH
,       w_address.Address1
,       w_address.Address2
,       w_address.City
,       w_address.State
,       w_address.ZIP
,       w_roster.Original_Phone
,       vol.capabilities
FROM w_roster
INNER JOIN w_voicepart
ON w_roster.Voice_Part = w_voicepart.code
INNER JOIN w_address
ON w_roster.LoadID = w_address.LoadID
LEFT OUTER JOIN v_Volunteer_Responses vol
ON w_roster.email = vol.email
go
DROP VIEW IF EXISTS v_Snail_Mail
go
CREATE VIEW v_Snail_Mail
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

DROP VIEW IF EXISTS v_Subscribed_Email_Audience
go
CREATE VIEW v_Subscribed_Email_Audience
AS
WITH w_aud AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Email) AS Email
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
DROP VIEW IF EXISTS v_Volunteer_Responses
go
CREATE VIEW v_Volunteer_Responses
AS
WITH w_cte AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Timestmp)        AS Timestmp
,       TRIM(Email)           AS Email
,       TRIM(Full_Name)       AS Full_Name
,       TRIM(LName)           AS LName
,       TRIM(FName)           AS FName
,       TRIM(Occupation)      AS Occupation
,       TRIM(Retired)         AS Retired
,       TRIM(Capabilities)    AS Capabilities
,       TRIM(CT_Ads)          AS CT_Ads
,       TRIM(CT_Board)        AS CT_Board
,       TRIM(CT_Concerts)     AS CT_Concerts
,       TRIM(CT_Development)  AS CT_Development
,       TRIM(CT_Finance)      AS CT_Finance
,       TRIM(CT_Hospitality)  AS CT_Hospitality
,       TRIM(CT_Investment)   AS CT_Investment
,       TRIM(CT_Marketing)    AS CT_Marketing
,       TRIM(CT_Membership)   AS CT_Membership
,       TRIM(CT_Outreach)     AS CT_Outreach
,       TRIM(CT_ProgramBook)  AS CT_ProgramBook
,       TRIM(CT_Rehearsal)    AS CT_Rehearsal
,       TRIM(CT_Technology)   AS CT_Technology
,       TRIM(CT_Website)      AS CT_Website
,       TRIM(CT_SocialMedia)  AS CT_SocialMedia
FROM t_Volunteer_Responses
)
SELECT
        LoadID
,       Timestmp
,       LOWER(Email) AS Email
,       LOWER(Full_Name) AS Full_Name
,       LName
,       FName
,       Occupation
,       Retired
,       Capabilities
,       CT_Ads
,       CT_Board
,       CT_Concerts
,       CT_Development
,       CT_Finance
,       CT_Hospitality
,       CT_Investment
,       CT_Marketing
,       CT_Membership
,       CT_Outreach
,       CT_ProgramBook
,       CT_Rehearsal
,       CT_Technology
,       CT_Website
,       CT_SocialMedia
FROM w_cte
go


