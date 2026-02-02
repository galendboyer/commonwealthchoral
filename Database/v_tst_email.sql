DROP VIEW IF EXISTS v_tst_email
go
CREATE VIEW v_tst_email
AS
  SELECT Email, Email_tst FROM
    (
    SELECT
           CAST(NULL AS VARCHAR(100)) AS Email
    ,      CAST(NULL AS VARCHAR(100)) AS Email_tst
    UNION ALL
    -- Roster
    SELECT 'carolhabrahams@gmail.com'                   ,'carolhabrahams@gmail.com'               UNION ALL
    SELECT 'cctreas@proton.me'                          ,'cctreas@proton.me'                      UNION ALL
    SELECT 'galendboyer@gmail.com'                      ,'galendboyer@gmail.com'                  UNION ALL
    SELECT 'nmacgaffey@gmail.com'                       ,'nmacgaffey@gmail.com'                   UNION ALL
    SELECT 'megan.baker1@gmail.com'                     ,'megan.baker1@gmail.com'                 UNION ALL
    -- Audience Subscribers
    SELECT 'bkeller100@gmail.com'                       ,'bkeller100@gmail.com'                   UNION ALL
    SELECT 'jamesthist@gmail.com'                       ,'jamesthist@gmail.com'                   UNION ALL
    SELECT 'kenneth.mcintosh@childrens.harvard.edu'     ,'kenneth.mcintosh@childrens.harvard.edu' UNION ALL
    SELECT 'leahdriscoll@me.com'                        ,'leahdriscoll@me.com'                    UNION ALL
    SELECT 'selinathehill@gmail.com'                    ,'selinathehill@gmail.com'                UNION ALL
    SELECT 'skaufman@pcgus.com'                         ,'skaufman@pcgus.com'                     UNION ALL
    SELECT 'tdriscoll@esboulos.com'                     ,'tdriscoll@esboulos.com'                 UNION ALL
    SELECT 'w.hartner@northeastern.edu'                 ,'w.hartner@northeastern.edu'             UNION ALL
    -- Board
    SELECT 'abigailrosesweeney@gmail.com'               ,'abigailrosesweeney@gmail.com'           UNION ALL
    SELECT 'cej321@gmail.com'                           ,'cej321@gmail.com'                       UNION ALL
    SELECT 'fwgratz@gmail.com'                          ,'fwgratz@gmail.com'                      UNION ALL
    SELECT 'judyje15@gmail.com'                         ,'judyje15@gmail.com'                     UNION ALL
    SELECT 'kosydney@gmail.com'                         ,'kosydney@gmail.com'                     UNION ALL
    SELECT 'michele.berman@prodigy.net'                 ,'michele.berman@prodigy.net'             UNION ALL
    SELECT 'michele.michaud@comcast.net'                ,'michele.michaud@comcast.net'            UNION ALL
    SELECT NULL,NULL
    ) t WHERE Email IS NOT NULL
go
