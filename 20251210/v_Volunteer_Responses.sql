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
