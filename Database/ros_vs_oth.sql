WITH
 w_ros AS
(
SELECT *
FROM v_Member_Roster 
WHERE email NOT IN (SELECT email FROM v_Subscribed_Email_Audience)
)
,w_oth AS
(
SELECT *
FROM v_Subscribed_Email_Audience
WHERE email NOT IN (SELECT email FROM v_Member_Roster)
)
, w_join AS
(
SELECT
        w_ros.LoadID as LoadID_ros
,       w_oth.LoadID as LoadID_oth
,       w_ros.email AS email_ros
,       w_oth.email AS email_oth
,       w_oth.Full_Name AS full_name_oth
,       w_ros.Full_Name AS full_name_ros
,       w_oth.Fname AS fname_oth
,       w_ros.Fname AS fname_ros
,       w_oth.Lname AS lname_oth
,       w_ros.Lname AS lname_ros
,       COALESCE(w_oth.Fname,w_ros.Fname) AS FName
,       COALESCE(w_oth.Lname,w_ros.Lname) AS LName
FROM w_ros
FULL OUTER JOIN w_oth
-- ON w_ros.email = w_oth.email
-- ON w_ros.full_name = w_oth.full_name
-- ON w_ros.FName = w_oth.FName
ON LOWER(w_ros.LName) = LOWER(w_oth.LName)
)
SELECT
        LoadID_ros
,       LoadID_oth
,       email_ros
,       email_oth
,       Fname
,       Lname
,       Fname_oth
,       Lname_oth
,       Fname_ros
,       Lname_ros
FROM w_join
WHERE 1=1
AND LoadID_oth IS NOT NULL
-- AND LoadID_ros IS NOT NULL
AND NOT(fname_oth IS NULL and lname_oth IS NULL AND fname_ros IS NULL AND lname_ros IS NULL)
ORDER BY Fname, Lname_Oth, Lname_ros
