DROP TABLE IF EXISTS t_Volunteer_Responses
go
CREATE TABLE t_Volunteer_Responses
(
  Timestmp       VARCHAR(MAX)
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

DROP VIEW IF EXISTS v_Volunteer_Responses
go
CREATE VIEW v_Volunteer_Responses
AS
SELECT
        TRIM(Timestmp)        AS Timestmp
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
go


DROP TABLE IF EXISTS t_Member_Roster
go
CREATE TABLE t_Member_Roster
(
  Lname          VARCHAR(MAX)
, Fname          VARCHAR(MAX)
, Voice          VARCHAR(MAX)
, Email          VARCHAR(MAX)
, Active         VARCHAR(MAX)
, CC_Role        VARCHAR(MAX)
, CC_YoungSinger VARCHAR(MAX)
, HomePH         VARCHAR(MAX)
, MobilePH       VARCHAR(MAX)
, WorkPH         VARCHAR(MAX)
, Address        VARCHAR(MAX)
, Original_Phone VARCHAR(MAX)
)
go

DROP VIEW IF EXISTS v_Member_Roster
go
CREATE VIEW v_Member_Roster
AS
SELECT
        TRIM(Lname)           AS LName
,       TRIM(Fname)           AS Fname
,       TRIM(Voice)           AS Voice
,       TRIM(Email)           AS Email
,       TRIM(Active)          AS Active
,       TRIM(CC_Role)         AS CC_Role
,       TRIM(CC_YoungSinger)  AS CC_YoungSinger
,       TRIM(HomePH)          AS HomePH
,       TRIM(MobilePH)        AS MobilePH
,       TRIM(WorkPH)          AS WorkPH
,       TRIM(Address)         AS Address
,       TRIM(Original_Phone)  AS Original_Phone
FROM t_Member_Roster
go

DROP TABLE IF EXISTS t_Mailing_List
go
CREATE TABLE t_Mailing_List
(
  Email  VARCHAR(MAX)
, LNameFname  VARCHAR(MAX)
, LName  VARCHAR(MAX)
, FName  VARCHAR(MAX)
, Street  VARCHAR(MAX)
, City  VARCHAR(MAX)
, State  VARCHAR(MAX)
, Zip  VARCHAR(MAX)
, SOURCE_KEY VARCHAR(MAX)
)
go

DROP VIEW IF EXISTS v_Mailing_List
go
CREATE VIEW v_Mailing_List
AS
SELECT
        TRIM(Email) AS Email
,       TRIM(LNameFName) AS LNameFName
,       TRIM(LName) AS LName
,       TRIM(FName) AS FName
,       TRIM(Street) AS Street
,       TRIM(City) AS City
,       TRIM(State) AS State
,       TRIM(Zip) AS Zip
,       CAST(CAST(SOURCE_KEY AS DECIMAL(38,10)) AS INT) AS source_key
FROM t_Mailing_List
go


DROP TABLE IF EXISTS t_Subscribed_Email_Audience
go
CREATE TABLE t_Subscribed_Email_Audience
(
  Email          VARCHAR(MAX)
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
)
go

DROP VIEW IF EXISTS v_Subscribed_Email_Audience
go
CREATE VIEW v_Subscribed_Email_Audience
AS
SELECT
        TRIM(Email) AS Email
,       TRIM(FName) AS FName
,       TRIM(LName) AS LName
-- ,       TRIM(Address_line_1) AS Address_line_1
-- ,       TRIM(Address_line_2) AS Address_line_2
-- ,       TRIM(City) AS City
-- ,       TRIM(State) AS State
-- ,       TRIM(Zip_code) AS Zip_code
-- ,       TRIM(Website) AS Website
-- ,       TRIM(EMAIL_TYPE) AS EMAIL_TYPE
-- ,       TRIM(MEMBER_RATING) AS MEMBER_RATING
,       TRIM(OPTIN_TIME) AS OPTIN_TIME
-- ,       TRIM(OPTIN_IP) AS OPTIN_IP
-- ,       TRIM(CONFIRM_TIME) AS CONFIRM_TIME
-- ,       TRIM(CONFIRM_IP) AS CONFIRM_IP
-- ,       TRIM(GMTOFF) AS GMTOFF
-- ,       TRIM(DSTOFF) AS DSTOFF
-- ,       TRIM(TIMEZONE) AS TIMEZONE
-- ,       TRIM(CC) AS CC
-- ,       TRIM(REGION) AS REGION
-- ,       TRIM(LAST_CHANGED) AS LAST_CHANGED
-- ,       TRIM(LEID) AS LEID
-- ,       TRIM(EUID) AS EUID
-- ,       TRIM(NOTES) AS NOTES
,       TRIM(TAGS) AS TAGS
FROM t_Subscribed_Email_Audience
go
