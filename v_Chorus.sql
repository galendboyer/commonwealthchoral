DROP VIEW IF EXISTS v_Chorus
go
CREATE VIEW v_Chorus
AS
WITH

 w_email AS (SELECT DISTINCT(email) FROM v_email)

,w_join AS (
SELECT
       w_email.email AS email
,       CASE WHEN v1."Full Name" IS NOT NULL THEN v1."Full Name"
             WHEN V2."Full Name" IS NOT NULL THEN v2."Full Name"
             WHEN v3."Full Name" IS NOT NULL THEN v3."Full Name"
        END AS "Full Name"
,       CASE WHEN v1."Voice Part" IS NOT NULL THEN v1."Voice Part"
             WHEN V2."Voice Part" IS NOT NULL THEN v2."Voice Part"
             WHEN v3."Voice Part" IS NOT NULL THEN v3."Voice Part"
        END AS "Voice Part"
,       v1."Paid Staff"        
,       v1."Active"
,       v3."Address"
-- ,       CASE WHEN w_Plus_Vol."Phone" <> w_202504."Phone"
--             OR w_Plus_Vol."Phone" <> w_202507."Phone"
--             OR w_Plus_Vol."Phone" <> w_Member_V2."Phone"
--             THEN 1 ELSE 0 END AS diff_Phone

,      v1."Email" AS email_v1
,      v2."Email" AS email_v2
,      v3."Email" AS email_v3
FROM w_email
LEFT OUTER JOIN t_MemberDB_FullInfo v1
ON w_email.email = v1.email 
LEFT OUTER JOIN t_MemberDB_V2 v2
ON w_email.email = v2.email
LEFT OUTER JOIN t_202507 v3
ON w_email.email = v3.email
)

,w_split AS (
SELECT
        email
,       "Full Name"
,       LEFT("Full Name", CHARINDEX(',', "Full Name") - 1) AS "Last Name"
,       LTRIM(RIGHT("Full Name", LEN("Full Name") - CHARINDEX(',', "Full Name"))) AS "First Name"
,       "Voice Part"
,       CASE WHEN "Paid Staff" IS NULL THEN 'N' ELSE "Paid Staff" END AS "Paid Staff"
,       "Active"
,       "Address"
FROM w_join
)

SELECT
        email
,       "Last Name"
,       CASE WHEN "First Name" LIKE '% %' THEN LEFT("First Name", CHARINDEX(' ', "First Name") - 1) ELSE "First Name" END AS "First Name"
,       CASE WHEN "First Name" LIKE '% %' THEN LTRIM(RIGHT("First Name", LEN("First Name") - CHARINDEX(' ', "First Name"))) ELSE NULL END  AS "Middle Name"
,       "Voice Part"
,       "Paid Staff"
,       "Active"
,       "Address"
FROM w_split
go
