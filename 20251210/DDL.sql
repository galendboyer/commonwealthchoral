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
