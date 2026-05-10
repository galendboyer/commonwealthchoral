DROP VIEW IF EXISTS v_Tag
go
CREATE VIEW v_Tag
AS
SELECT tag_key, tag_desc FROM (
  SELECT CAST(NULL AS INT) AS tag_key
  ,      CAST(NULL AS VARCHAR(30)) AS tag_desc
  UNION ALL
  SELECT 1, 'Alum'               UNION ALL
  SELECT 2, 'Family and Friends' UNION ALL
  SELECT 3, 'Roster'             UNION ALL
  SELECT 4, 'Subscriber'         UNION ALL
  SELECT NULL, NULL
  ) t WHERE tag_key IS NOT NULL
go
