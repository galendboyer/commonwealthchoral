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


