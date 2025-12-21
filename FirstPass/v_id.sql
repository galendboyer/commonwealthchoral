WITH

 w_email AS (SELECT DISTINCT(email) FROM v_email)
 
,w_Plus_Vol AS
(
SELECT
 "Full name"
,"Voice part"
,w_email."Email"
,"Phone"
FROM w_email
LEFT OUTER JOIN t_202504_Plus_Volunteer t
ON w_email.email = t.email
)

,w_Member AS
(
SELECT
 "Full name"
,"Voice part"
,"Email"
FROM t_MemberDB_FullInfo
)

,w_Member_V2 AS
(
SELECT
 "Full name"
,"Voice part"
,"Email"
,"Phone"
FROM t_MemberDB_V2
)

,w_202504 AS
(
SELECT
 "Full name"
,"Voice part"
,"Email"
,"Phone"
,"Address"
FROM t_202504
)

,w_202507 AS
(
SELECT
 "Full name"
,"Voice part"
,"Email"
,"Phone"
,"Address"
FROM t_202507
)

,w_sel AS
(
SELECT
        w_email.email
,       CASE WHEN w_Plus_Vol."Full Name" <> w_Member."Full Name"
            OR w_Plus_Vol."Full Name" <> w_202504."Full Name"
            OR w_Plus_Vol."Full Name" <> w_202507."Full Name"
            OR w_Plus_Vol."Full Name" <> w_Member_V2."Full Name"
            THEN 1 ELSE 0 END AS diff_Full_Name
,       CASE WHEN w_Plus_Vol."Voice Part" <> w_Member."Voice Part"
            OR w_Plus_Vol."Voice Part" <> w_202504."Voice Part"
            OR w_Plus_Vol."Voice Part" <> w_202507."Voice Part"
            OR w_Plus_Vol."Voice Part" <> w_Member_V2."Voice Part"
            THEN 1 ELSE 0 END AS diff_Voice_Part
,       CASE WHEN w_Plus_Vol."Phone" <> w_202504."Phone"
            OR w_Plus_Vol."Phone" <> w_202507."Phone"
            OR w_Plus_Vol."Phone" <> w_Member_V2."Phone"
            THEN 1 ELSE 0 END AS diff_Phone
,       CASE WHEN w_202504."Address" <> w_202507."Address"
            THEN 1 ELSE 0 END AS diff_Address
,       w_Plus_Vol."Phone" AS phone_plus_vol
,       w_202504."Phone" AS phone_202504
,       w_202507."Phone" AS phone_202507
,       w_Member_V2."Phone" AS phone_member_v2
FROM w_email
INNER JOIN w_Plus_Vol ON w_email.email = w_Plus_Vol.email
INNER JOIN w_Member ON w_email.email = w_Member.email
INNER JOIN w_202504 ON w_email.email = w_202504.email
INNER JOIN w_202507 ON w_email.email = w_202507.email
INNER JOIN w_Member_V2 ON w_email.email = w_Member_V2.email
)

SELECT
        email
,       phone_plus_vol
,       phone_202504
,       phone_202507
,       phone_member_v2
FROM w_sel
WHERE diff_Address = 1
