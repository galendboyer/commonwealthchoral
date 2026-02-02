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
