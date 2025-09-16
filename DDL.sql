DROP TABLE IF EXISTS t_MemberDB_FullInfo
go
CREATE TABLE t_MemberDB_FullInfo
(
 "Full name"  VARCHAR(100)
,"Voice part" VARCHAR(100)
,"Email"      VARCHAR(100)
,"Paid Staff" VARCHAR(100)
,"Active"     VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_MemberDB_V2
go
CREATE TABLE t_MemberDB_V2
(
 "Full name"                  VARCHAR(100)
,"Voice part"                 VARCHAR(100)
,"Email"                      VARCHAR(100)
,"Phone"                      VARCHAR(100)
,"Section Leads"              VARCHAR(100)
,"Occupation current or past" VARCHAR(8000)
,"Skills Interests"           VARCHAR(1000)
,"Ad Campaign"                VARCHAR(1000)
,"Board of Directors"         VARCHAR(1000)
,"Concert Management"         VARCHAR(1000)
,"Develepmont"                VARCHAR(1000)
,"Finance"                    VARCHAR(1000)
,"Hospitality"                VARCHAR(1000)
,"Investment"                 VARCHAR(1000)
,"Marketing"                  VARCHAR(1000)
,"Membership"                 VARCHAR(1000)
,"Outreach"                   VARCHAR(1000)
,"Program Book"               VARCHAR(1000)
,"Program Committee"          VARCHAR(1000)
,"Rehearsal Management"       VARCHAR(1000)
,"Tech Support"               VARCHAR(1000)
,"Website_and_SocialMedia"    VARCHAR(1000)
)
go

DROP TABLE IF EXISTS t_202504_Plus_Volunteer
go
CREATE TABLE t_202504_Plus_Volunteer
(
 "Full name"  VARCHAR(100)
,"Voice part" VARCHAR(100)
,"Email"      VARCHAR(100)
,"Phone"      VARCHAR(100)
,"Note"       VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_202504
go
CREATE TABLE t_202504
(
 "Full name"  VARCHAR(100)
,"Voice part" VARCHAR(100)
,"Email"      VARCHAR(100)
,"Phone"      VARCHAR(100)
,"Address"    VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_202507
go
CREATE TABLE t_202507
(
 "Full name"  VARCHAR(100)
,"Voice part" VARCHAR(100)
,"Email"      VARCHAR(100)
,"Phone"      VARCHAR(100)
,"Address"    VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_2024_2025
go
CREATE TABLE t_2024_2025
(
 "Name"    VARCHAR(100)
,"Title"    VARCHAR(100)
,"Organization Name"    VARCHAR(100)
,"Email"    VARCHAR(100)
,"tks out"    VARCHAR(100)
,"Nbr of  tickets"    VARCHAR(100)
,"Ticket Nbr Sequence"    VARCHAR(100)
,"Nbr Attended"    VARCHAR(100)
,"Ticket Nbrs collected"    VARCHAR(100)
,"Street"    VARCHAR(100)
,"Town"    VARCHAR(100)
,"State"    VARCHAR(100)
,"Zip"    VARCHAR(100)
,"Member sending"    VARCHAR(100)
,"CC Source"    VARCHAR(100)
,"Concert"      VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_2023_2024
go
CREATE TABLE t_2023_2024
(
 "Name"   VARCHAR(100)
,"Title"    VARCHAR(100)
,"Organization Name"    VARCHAR(100)
,"Email"    VARCHAR(100)
,"Nbr of tickets"    VARCHAR(100)
,"Ticket Nbr Sequence"    VARCHAR(100)
,"Nbr Attended"    VARCHAR(100)
,"Ticket Nbrs collected"    VARCHAR(100)
,"Street"    VARCHAR(100)
,"Town"    VARCHAR(100)
,"State"    VARCHAR(100)
,"Zip"    VARCHAR(100)
,"Member sending"    VARCHAR(100)
,"CC Source"    VARCHAR(100)
,"Concert"    VARCHAR(100)
)
go


DROP TABLE IF EXISTS t_Records
go
CREATE TABLE t_Records
(
 LNAME   VARCHAR(100)
,FNAME   VARCHAR(100)
,STREET   VARCHAR(100)
,CITY   VARCHAR(100)
,ST   VARCHAR(100)
,ZIP   VARCHAR(100)
,SOURCE_KEY VARCHAR(1)
)
go


DROP TABLE IF EXISTS t_Non_NewEngland
go
CREATE TABLE t_Non_NewEngland
(
 FNAME   VARCHAR(100)
,LNAME   VARCHAR(100)
,STREET   VARCHAR(100)
,CITY   VARCHAR(100)
,ST   VARCHAR(100)
,ZIP   VARCHAR(100)
,SOURCE_KEY   VARCHAR(1)
,EMAIL_1   VARCHAR(100)
,EMAIL_2   VARCHAR(100)
,PHONE   VARCHAR(100)
,ORG   VARCHAR(100)
,DONATED_1   VARCHAR(100)
,DONATED_2   VARCHAR(100)
,DONATED_3   VARCHAR(100)
,DONATED_4   VARCHAR(100)
,DONATED_5   VARCHAR(100)
,DONATED_6   VARCHAR(100)
,DONATED_7   VARCHAR(100)
,DONATED_8   VARCHAR(100)
,DONATED_9   VARCHAR(100)
,DONATED_10   VARCHAR(100)
,DONATED_11   VARCHAR(100)
)
go

DROP TABLE IF EXISTS t_Key_To_Source
go
CREATE TABLE t_Key_To_Source
(
 Source_Key   VARCHAR(1)
,File_Name   VARCHAR(100)
)
go
