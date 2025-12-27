WITH w_join AS
(
SELECT
        mbr.email AS email_mbr
,       vol.email AS email_vol
,       vol.Full_Name AS full_name_vol
,       mbr.Full_Name AS full_name_mbr
FROM v_Member_Roster mbr
FULL OUTER JOIN v_Volunteer_Responses vol
ON mbr.email = vol.email
)
SELECT
        email_mbr
,       Full_Name_mbr
,       email_vol
,       Full_Name_vol
FROM w_join
WHERE (email_vol IS NOT NULL OR email_mbr IS NOT NULL)
AND (email_vol IS NULL OR email_mbr IS NULL)
ORDER BY Full_Name_mbr, Full_Name_vol
