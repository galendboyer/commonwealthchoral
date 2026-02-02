--
DROP TABLE IF EXISTS t_Volunteer_Responses
go
DROP TABLE IF EXISTS t_Member_Roster
go
DROP TABLE IF EXISTS t_Mailing_List
go
DROP TABLE IF EXISTS t_Subscribed_Email_Audience
go

DROP FUNCTION IF EXISTS f_full_name
go
DROP VIEW IF EXISTS v_Member
go
DROP VIEW IF EXISTS v_Roster
go
DROP VIEW IF EXISTS v_Snail_Mail
go
DROP VIEW IF EXISTS v_Subscriber
go
DROP VIEW IF EXISTS v_Volunteer
go
DROP TABLE IF EXISTS t_Volunteer_Responses
go
CREATE TABLE t_Volunteer_Responses
(
  LoadID VARCHAR(MAX)
, Timestmp       VARCHAR(MAX)
, Email          VARCHAR(MAX)
, Email_Roster  VARCHAR(MAX)
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
, Email2            VARCHAR(MAX)
, Email_Private     VARCHAR(MAX)
, Active            VARCHAR(MAX)
, CC_Role           VARCHAR(MAX)
, CC_YoungSinger    VARCHAR(MAX)
, HomePH            VARCHAR(MAX)
, MobilePH          VARCHAR(MAX)
, WorkPH            VARCHAR(MAX)
, Address           VARCHAR(MAX)
, Address2          VARCHAR(MAX)
, Original_Phone    VARCHAR(MAX)
)
go


DROP TABLE IF EXISTS t_Mailing_List
go
CREATE TABLE t_Mailing_List
(
  LoadID VARCHAR(MAX)
, Email  VARCHAR(MAX)
, Email_Roster  VARCHAR(MAX)
, LNameFname  VARCHAR(MAX)
, LName  VARCHAR(MAX)
, FName  VARCHAR(MAX)
, Street  VARCHAR(MAX)
, Street1  VARCHAR(MAX)
, City  VARCHAR(MAX)
, State  VARCHAR(MAX)
, Zip  VARCHAR(MAX)
, SOURCE_KEY VARCHAR(MAX)
, Email_Source VARCHAR(MAX)
)
go


DROP TABLE IF EXISTS t_Subscribed_Email_Audience
go
CREATE TABLE t_Subscribed_Email_Audience
(
  LoadID         VARCHAR(MAX)
, Email          VARCHAR(MAX)
, Email_Roster   VARCHAR(MAX)
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
, IS_A_DUPLICATE VARCHAR(MAX)
)
go
DROP FUNCTION IF EXISTS f_full_name
go
CREATE FUNCTION f_full_name(@FName VARCHAR(100), @LName VARCHAR(100))
RETURNS VARCHAR(200)
AS
BEGIN
     DECLARE @str VARCHAR(200);
     IF @FName IS NULL OR @LName IS NULL
     BEGIN
        SET @str = COALESCE(@FName,@LName);
     END;
     ELSE
        SET @str = LOWER(CONCAT(ISNULL(@FName,''),' ',ISNULL(@LName,'')));
     RETURN @str;
END
go
-- SELECT dbo.f_full_name(NULL,NULL)
-- SELECT dbo.f_full_name('A',NULL)
-- SELECT dbo.f_full_name('A','B')
-- SELECT dbo.f_full_name(NULL,'B')

DROP VIEW IF EXISTS v_Roster
go
CREATE VIEW v_Roster
AS
WITH w_roster AS
(
SELECT
        CAST(LoadID AS INT)      AS LoadID
,       TRIM(Lname)              AS LName
,       TRIM(Fname)              AS Fname
,       TRIM(Voice)              AS Voice_Part
,       TRIM(Email)              AS Email
,       TRIM(Email2)             AS Email2
,       TRIM(Email_Private)      AS Email_Private
,       TRIM(Active)             AS IsCCActive
,       TRIM(CC_Role)            AS CC_Role
,       TRIM(CC_YoungSinger)     AS CC_YoungSinger
,       TRIM(HomePH)             AS HomePH
,       TRIM(MobilePH)           AS MobilePH
,       TRIM(WorkPH)             AS WorkPH
,       TRIM(Address2)           AS Address_Normalized
,       TRIM(Original_Phone)     AS Original_Phone
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
CROSS APPLY STRING_SPLIT(Address_Normalized, ',', 1) AS s
GROUP BY LoadID
)
SELECT
        w_roster.LoadID
,       w_roster.LName
,       w_roster.Fname
,       dbo.f_full_name(w_roster.FName,w_roster.LName) AS Full_Name
,       w_voicepart.description AS Voice_Part
,       LOWER(w_roster.Email) AS Email
,       LOWER(w_roster.Email2) AS Email2
,       w_roster.Email_Private
,       w_roster.IsCCActive
,       w_roster.CC_Role
,       w_roster.CC_YoungSinger
,       w_roster.HomePH
,       w_roster.MobilePH
,       w_roster.WorkPH
,       w_roster.Address_Normalized
,       w_address.Address1
,       w_address.Address2
,       w_address.City
,       w_address.State
,       w_address.ZIP
,       w_roster.Original_Phone
FROM w_roster
INNER JOIN w_voicepart
ON w_roster.Voice_Part = w_voicepart.code
INNER JOIN w_address
ON w_roster.LoadID = w_address.LoadID
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
,       TRIM(IS_A_DUPLICATE)  AS IS_A_DUPLICATE
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
,       IS_A_DUPLICATE
FROM w_subs
go
DROP VIEW IF EXISTS v_Volunteer
go
CREATE VIEW v_Volunteer
AS
WITH w_cte AS
(
SELECT
        CAST(LoadID AS INT)   AS LoadID
,       TRIM(Timestmp)        AS Timestmp
,       TRIM(Email)           AS Email
,       TRIM(Email_Roster)    AS Email_Roster
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
,w_isdoing AS
(
SELECT LoadID, STRING_AGG(is_doing, ',') AS is_doing
FROM (
  SELECT LoadID, is_doing FROM
    (
    SELECT CAST(NULL AS INT) AS LoadID
    ,      CAST(NULL AS VARCHAR(30)) AS Is_Doing
    UNION ALL
    SELECT LoadID, CASE WHEN CT_Ads         = 'Is_Doing' THEN 'Ads'         ELSE NULL END FROM w_cte WHERE CT_Ads          IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Board       = 'Is_Doing' THEN 'Board'       ELSE NULL END FROM w_cte WHERE CT_Board        IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Concerts    = 'Is_Doing' THEN 'Concerts'    ELSE NULL END FROM w_cte WHERE CT_Concerts     IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Development = 'Is_Doing' THEN 'Development' ELSE NULL END FROM w_cte WHERE CT_Development  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Finance     = 'Is_Doing' THEN 'Finance'     ELSE NULL END FROM w_cte WHERE CT_Finance      IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Hospitality = 'Is_Doing' THEN 'Hospitality' ELSE NULL END FROM w_cte WHERE CT_Hospitality  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Investment  = 'Is_Doing' THEN 'Investment'  ELSE NULL END FROM w_cte WHERE CT_Investment   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Marketing   = 'Is_Doing' THEN 'Marketing'   ELSE NULL END FROM w_cte WHERE CT_Marketing    IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Membership  = 'Is_Doing' THEN 'Membership'  ELSE NULL END FROM w_cte WHERE CT_Membership   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Outreach    = 'Is_Doing' THEN 'Outreach'    ELSE NULL END FROM w_cte WHERE CT_Outreach     IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_ProgramBook = 'Is_Doing' THEN 'ProgramBook' ELSE NULL END FROM w_cte WHERE CT_ProgramBook  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Rehearsal   = 'Is_Doing' THEN 'Rehearsal'   ELSE NULL END FROM w_cte WHERE CT_Rehearsal    IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Technology  = 'Is_Doing' THEN 'Technology'  ELSE NULL END FROM w_cte WHERE CT_Technology   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Website     = 'Is_Doing' THEN 'Website'     ELSE NULL END FROM w_cte WHERE CT_Website      IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_SocialMedia = 'Is_Doing' THEN 'SocialMedia' ELSE NULL END FROM w_cte WHERE CT_SocialMedia  IS NOT NULL UNION ALL
    SELECT NULL, NULL
    ) t WHERE LoadID IS NOT NULL) t
    GROUP BY LoadID
)
,w_interested AS
(
SELECT LoadID, STRING_AGG(interested, ',') AS interested
FROM (
  SELECT LoadID, Interested FROM
    (
    SELECT CAST(NULL AS INT) AS LoadID
    ,      CAST(NULL AS VARCHAR(30)) AS Interested
    UNION ALL
    SELECT LoadID, CASE WHEN CT_Ads         = 'Interested' THEN 'Ads'         ELSE NULL END FROM w_cte WHERE CT_Ads          IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Board       = 'Interested' THEN 'Board'       ELSE NULL END FROM w_cte WHERE CT_Board        IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Concerts    = 'Interested' THEN 'Concerts'    ELSE NULL END FROM w_cte WHERE CT_Concerts     IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Development = 'Interested' THEN 'Development' ELSE NULL END FROM w_cte WHERE CT_Development  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Finance     = 'Interested' THEN 'Finance'     ELSE NULL END FROM w_cte WHERE CT_Finance      IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Hospitality = 'Interested' THEN 'Hospitality' ELSE NULL END FROM w_cte WHERE CT_Hospitality  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Investment  = 'Interested' THEN 'Investment'  ELSE NULL END FROM w_cte WHERE CT_Investment   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Marketing   = 'Interested' THEN 'Marketing'   ELSE NULL END FROM w_cte WHERE CT_Marketing    IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Membership  = 'Interested' THEN 'Membership'  ELSE NULL END FROM w_cte WHERE CT_Membership   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Outreach    = 'Interested' THEN 'Outreach'    ELSE NULL END FROM w_cte WHERE CT_Outreach     IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_ProgramBook = 'Interested' THEN 'ProgramBook' ELSE NULL END FROM w_cte WHERE CT_ProgramBook  IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Rehearsal   = 'Interested' THEN 'Rehearsal'   ELSE NULL END FROM w_cte WHERE CT_Rehearsal    IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Technology  = 'Interested' THEN 'Technology'  ELSE NULL END FROM w_cte WHERE CT_Technology   IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_Website     = 'Interested' THEN 'Website'     ELSE NULL END FROM w_cte WHERE CT_Website      IS NOT NULL UNION ALL
    SELECT LoadID, CASE WHEN CT_SocialMedia = 'Interested' THEN 'SocialMedia' ELSE NULL END FROM w_cte WHERE CT_SocialMedia  IS NOT NULL UNION ALL
    SELECT NULL, NULL
    ) t WHERE LoadID IS NOT NULL) t
    GROUP BY LoadID
)

SELECT
        w_cte.LoadID
,       w_cte.Timestmp
,       LOWER(w_cte.Email) AS Email
,       LOWER(w_cte.Email_Roster) AS Email_Roster
,       LOWER(w_cte.Full_Name) AS Full_Name
,       w_cte.LName
,       w_cte.FName
,       dbo.f_full_name(w_cte.FName,w_cte.LName) AS Full_Name_2
,       w_cte.Occupation
,       w_cte.Retired
,       w_cte.Capabilities
,       w_isdoing.is_doing AS TasksDoing
,       w_interested.interested AS TasksInterested
,       w_cte.CT_Ads
,       w_cte.CT_Board
,       w_cte.CT_Concerts
,       w_cte.CT_Development
,       w_cte.CT_Finance
,       w_cte.CT_Hospitality
,       w_cte.CT_Investment
,       w_cte.CT_Marketing
,       w_cte.CT_Membership
,       w_cte.CT_Outreach
,       w_cte.CT_ProgramBook
,       w_cte.CT_Rehearsal
,       w_cte.CT_Technology
,       w_cte.CT_Website
,       w_cte.CT_SocialMedia
FROM w_cte
LEFT OUTER JOIN w_isdoing
ON w_cte.LoadID = w_isdoing.LoadID
LEFT OUTER JOIN w_interested
ON w_cte.LoadID = w_interested.LoadID
go
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
,w_subs AS
(
  SELECT * FROM v_subscriber
  WHERE Email_Roster IS NOT NULL
  AND IS_A_DUPLICATE = 'No'
)
SELECT 
        w_ros.LoadID
,       COALESCE(w_ros.LName,w_subs.LName) AS LName
,       COALESCE(w_ros.Fname,w_subs.FName) AS FName
,       w_ros.Voice_Part
,       COALESCE(w_ros.Email,w_subs.Email_Roster) AS Email
,       w_ros.Email2
,       w_ros.Email_Private
,       w_ros.IsCCActive
,       w_ros.CC_Role
,       w_ros.CC_YoungSinger
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
,       w_ros.Retired
,       w_ros.Capabilities
,       w_ros.TasksDoing
,       w_ros.TasksInterested
,       w_subs.tags
FROM w_ros
FULL OUTER JOIN w_subs
ON w_ros.Email = w_subs.Email_Roster
go
DROP VIEW IF EXISTS v_tst_chosen
go
CREATE VIEW v_tst_chosen
AS
  SELECT whychosen, is_member, LoadID, ContactIPK, Email FROM
    (
    SELECT
           CAST(NULL AS VARCHAR(20)) AS whychosen
    ,      CAST(NULL AS INT) AS is_member
    ,      CAST(NULL AS INT) AS LoadID
    ,      CAST(NULL AS INT) AS ContactIPK
    ,      CAST(NULL AS VARCHAR(100)) AS Email
    UNION ALL
  -- Roster
  SELECT 'ROSTER',1, 1,1468,'carolhabrahams@gmail.com'               UNION ALL
  SELECT 'ROSTER',1,77,NULL,'cctreas@proton.me'                      UNION ALL
  SELECT 'ROSTER',1,12,NULL,'galendboyer@gmail.com'                  UNION ALL
  SELECT 'ROSTER',1,57,1466,'nmacgaffey@gmail.com'                   UNION ALL
  SELECT 'ROSTER',1, 4,1467,'megan.baker1@gmail.com'                 UNION ALL
  -- Audience Subscribers
  SELECT 'SUBSCRIBERS',1,1035,NULL,'bkeller100@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',0,1183,NULL,'jamesthist@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',1,1020,NULL,'kenneth.mcintosh@childrens.harvard.edu' UNION ALL
  SELECT 'SUBSCRIBERS',0,1093,NULL,'leahdriscoll@me.com'                    UNION ALL
  -- SELECT 'SUBSCRIBERS',1,1021,NULL,'ronseverson@gmx.net'                    UNION ALL
  SELECT 'SUBSCRIBERS',0,1019,NULL,'selinathehill@gmail.com'                UNION ALL
  SELECT 'SUBSCRIBERS',1,1241,NULL,'skaufman@pcgus.com'                     UNION ALL
  SELECT 'SUBSCRIBERS',0,1271,NULL,'tdriscoll@esboulos.com'                 UNION ALL
  SELECT 'SUBSCRIBERS',1,1125,NULL,'w.hartner@northeastern.edu'             UNION ALL
  -- Board
  SELECT 'BOARD',1,52,NULL,'abigailrosesweeney@gmail.com' UNION ALL
  -- SELECT 48,NULL,'cctreas@proton.me'            UNION ALL
  SELECT 'BOARD',1,27,NULL,'cej321@gmail.com'             UNION ALL
  SELECT 'BOARD',1,20,NULL,'fwgratz@gmail.com'            UNION ALL
  SELECT 'BOARD',1,25,NULL,'judyje15@gmail.com'           UNION ALL
  SELECT 'BOARD',1,13,NULL,'kosydney@gmail.com'           UNION ALL
  SELECT 'BOARD',1, 7,NULL,'michele.berman@prodigy.net'   UNION ALL
  SELECT 'BOARD',1,40,NULL,'michele.michaud@comcast.net'  UNION ALL
  -- SELECT 36,NULL,'nmacgaffey@gmail.com'         UNION ALL
    SELECT NULL,NULL,NULL,NULL,NULL
  ) t WHERE LoadID IS NOT NULL
go
