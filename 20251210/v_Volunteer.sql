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
