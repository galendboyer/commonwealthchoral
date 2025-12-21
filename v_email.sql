DROP VIEW IF EXISTS v_email
go
CREATE VIEW v_email
AS
SELECT tbl, LOWER(email) AS email FROM (
SELECT CAST(NULL AS VARCHAR(100)) AS tbl
,      CAST(NULL AS VARCHAR(100)) AS email
UNION ALL
SELECT 't_202504_Plus_Volunteer' , email FROM t_202504_Plus_Volunteer UNION ALL
SELECT 't_MemberDB_FullInfo'     , email FROM t_MemberDB_FullInfo     UNION ALL
SELECT 't_MemberDB_V2'           , email FROM t_MemberDB_V2           UNION ALL
SELECT 't_202504'                , email FROM t_202504                UNION ALL
SELECT 't_202507'                , email FROM t_202507                UNION ALL
SELECT 't_Volunteer_Responses'   , Email FROM t_Volunteer_Responses   UNION ALL
SELECT 't_Subscribed_Emails'     , Email FROM t_Subscribed_Emails     UNION ALL
SELECT NULL,NULL
) t WHERE tbl IS NOT NULL
go
