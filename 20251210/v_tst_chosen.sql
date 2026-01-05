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
  SELECT 'ROSTER',1, 1,1468,'carolhabrahams@gmail.com'               UNION ALL
  SELECT 'ROSTER',1,77,NULL,'cctreas@proton.me'                      UNION ALL
  SELECT 'ROSTER',1,12,NULL,'galendboyer@gmail.com'                  UNION ALL
  SELECT 'ROSTER',1,57,1466,'nmacgaffey@gmail.com'                   UNION ALL
  SELECT 'ROSTER',1, 4,1467,'megan.baker1@gmail.com'                 UNION ALL
  -- Audience Subscribers
  SELECT 'SUBSCRIBERS',1,1035,NULL,'bkeller100@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',0,1183,NULL,'jamesthist@gmail.com'                   UNION ALL
  SELECT 'SUBSCRIBERS',1,1020,NULL,'kenneth.mcintosh@childrens.harvard.edu' UNION ALL
  SELECT 'SUBSCRIBERS',0,1093,NULL,'leahdriscoll@me.com'                    UNION ALL
  -- SELECT 'SUBSCRIBERS',1,1021,NULL,'ronseverson@gmx.net'                    UNION ALL
  SELECT 'SUBSCRIBERS',0,1019,NULL,'selinathehill@gmail.com'                UNION ALL
  SELECT 'SUBSCRIBERS',1,1241,NULL,'skaufman@pcgus.com'                     UNION ALL
  SELECT 'SUBSCRIBERS',0,1271,NULL,'tdriscoll@esboulos.com'                 UNION ALL
  SELECT 'SUBSCRIBERS',1,1125,NULL,'w.hartner@northeastern.edu'             UNION ALL
  -- Board
  SELECT 'BOARD',1,52,NULL,'abigailrosesweeney@gmail.com' UNION ALL
  -- SELECT 48,NULL,'cctreas@proton.me'            UNION ALL
  SELECT 'BOARD',1,27,NULL,'cej321@gmail.com'             UNION ALL
  SELECT 'BOARD',1,20,NULL,'fwgratz@gmail.com'            UNION ALL
  SELECT 'BOARD',1,25,NULL,'judyje15@gmail.com'           UNION ALL
  SELECT 'BOARD',1,13,NULL,'kosydney@gmail.com'           UNION ALL
  SELECT 'BOARD',1, 7,NULL,'michele.berman@prodigy.net'   UNION ALL
  SELECT 'BOARD',1,40,NULL,'michele.michaud@comcast.net'  UNION ALL
  -- SELECT 36,NULL,'nmacgaffey@gmail.com'         UNION ALL
    SELECT NULL,NULL,NULL,NULL,NULL
  ) t WHERE LoadID IS NOT NULL
go
