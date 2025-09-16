DROP VIEW IF EXISTS v_email
go
CREATE VIEW v_email
AS
SELECT tbl, LOWER(email) AS email FROM (
SELECT 't_202504_Plus_Volunteer' AS tbl, email FROM t_202504_Plus_Volunteer UNION ALL
SELECT 't_MemberDB_FullInfo' AS tbl, email FROM t_MemberDB_FullInfo         UNION ALL
SELECT 't_MemberDB_V2' AS tbl, email FROM t_MemberDB_V2                     UNION ALL
SELECT 't_202504' AS tbl, email FROM t_202504                               UNION ALL
SELECT 't_202507' AS tbl, email FROM t_202507
) t
go
