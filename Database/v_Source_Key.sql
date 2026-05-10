DROP VIEW IF EXISTS v_Source_Key
go
CREATE VIEW v_Source_Key
AS
SELECT source_key, source_description FROM (
  SELECT CAST(NULL AS INT) AS source_key
  ,      CAST(NULL AS VARCHAR(30)) AS source_description
  UNION ALL
  SELECT 1, 'General'             UNION ALL
  SELECT 2, 'Prev_Donor'          UNION ALL
  SELECT 3, 'Alums'               UNION ALL
  SELECT 4, 'Members'             UNION ALL
  SELECT 5, 'OnLine_Ticket_sales' UNION ALL
  SELECT NULL, NULL
  ) t WHERE source_key IS NOT NULL
go
