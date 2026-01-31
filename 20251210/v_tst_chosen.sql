DROP VIEW IF EXISTS v_tst_chosen
go
CREATE VIEW v_tst_chosen
AS
  SELECT whychosen, is_member, LoadID, ContactIPK, Email FROM
    (
    SELECT
           CAST(NULL AS VARCHAR(20)) AS whychosen
    ,      CAST(NULL AS INT) AS is_member
    ,      CAST(NULL AS INT) AS LoadID
    ,      CAST(NULL AS INT) AS ContactIPK
    ,      CAST(NULL AS VARCHAR(100)) AS Email
    UNION ALL
  -- Roster
  SELECT 'ROSTER',1, 1,1532,'carolhabrahams@gmail.com'               UNION ALL
  SELECT 'ROSTER',1,77,1533,'cctreas@proton.me'                      UNION ALL
  SELECT 'ROSTER',1,12,1536,'galendboyer@gmail.com'                  UNION ALL
  SELECT 'ROSTER',1,57,1545,'nmacgaffey@gmail.com'                   UNION ALL
  SELECT 'ROSTER',1, 4,1542,'megan.baker1@gmail.com'                 UNION ALL
  -- Audience Subscribers
  SELECT 'SUBSCRIBERS',1,1035,1531,'bkeller100@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',0,1183,1537,'jamesthist@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',1,1020,1539,'kenneth.mcintosh@childrens.harvard.edu' UNION ALL
  SELECT 'SUBSCRIBERS',0,1093,1541,'leahdriscoll@me.com'                    UNION ALL
  -- SELECT 'SUBSCRIBERS',1,1021,NULL,'ronseverson@gmx.net'                    UNION ALL
  SELECT 'SUBSCRIBERS',0,1019,1546,'selinathehill@gmail.com'                UNION ALL
  SELECT 'SUBSCRIBERS',1,1241,1547,'skaufman@pcgus.com'                     UNION ALL
  SELECT 'SUBSCRIBERS',0,1271,1548,'tdriscoll@esboulos.com'                 UNION ALL
  SELECT 'SUBSCRIBERS',1,1125,1549,'w.hartner@northeastern.edu'             UNION ALL
  -- Board
  SELECT 'BOARD',1,52,1530,'abigailrosesweeney@gmail.com' UNION ALL
  -- SELECT 48,NULL,'cctreas@proton.me'            UNION ALL
  SELECT 'BOARD',1,27,1534,'cej321@gmail.com'             UNION ALL
  SELECT 'BOARD',1,20,1535,'fwgratz@gmail.com'            UNION ALL
  SELECT 'BOARD',1,25,1538,'judyje15@gmail.com'           UNION ALL
  SELECT 'BOARD',1,13,1540,'kosydney@gmail.com'           UNION ALL
  SELECT 'BOARD',1, 7,1543,'michele.berman@prodigy.net'   UNION ALL
  SELECT 'BOARD',1,40,1544,'michele.michaud@comcast.net'  UNION ALL
  -- SELECT 36,NULL,'nmacgaffey@gmail.com'         UNION ALL
    SELECT NULL,NULL,NULL,NULL,NULL
  ) t WHERE LoadID IS NOT NULL
go
