-- t_Volunteer_Responses
-- t_Member_Roster
-- t_Mailing_List
-- t_Subscribed_Email_Audience

-- = B2 & "|" & C2

-- =IFERROR(VLOOKUP(B2, VLookupEmail!A:B, 2, FALSE),"")


-- WITH w_ml AS
-- (
-- SELECT * FROM v_Mailing_List
-- WHERE SOURCE_KEY IN (3,4)
-- AND Email IS NULL
-- )
-- SELECT
--         w_ml.Lname AS LName_ml
-- ,       w_ml.Fname AS FName_ml
-- ,       mr.Lname AS LName_mr
-- ,       mr.Fname AS FName_mr
-- ,       mr.email
-- FROM w_ml
-- LEFT OUTER JOIN v_member_roster mr
-- -- ON UPPER(w_ml.FName) = UPPER(mr.Fname)
-- ON UPPER(w_ml.LName) = UPPER(mr.Lname)
-- -- AND UPPER(w_ml.LName) = UPPER(mr.Lname)
-- WHERE 1=1
-- AND mr.Lname IS NOT NULL
-- ORDER BY 
--        LName_ml
-- ,      FName_ml


WITH w_ml AS
(
SELECT *
,      CASE WHEN email IS NOT NULL THEN 1 ELSE 0 END AS has_email
FROM v_Mailing_List
WHERE SOURCE_KEY IN (3,4)
)
SELECT LName
,      FName
,      email
FROM w_ml
ORDER BY has_email, LName, FName
