SELECT Category, id, Value FROM
(
SELECT CAST(NULL AS VARCHAR(40)) as Category
,      CAST(NULL AS INT) AS id
,      CAST(NULL AS VARCHAR(30)) AS Value
UNION ALL
SELECT 'Concert Management'   ,76 ,'Interested in'   UNION ALL
SELECT 'Concert Management'   ,86 ,'Interested in'   UNION ALL
SELECT 'Concert Management'   ,92 ,'Currently doing' UNION ALL
SELECT 'Development'          ,9  ,'Currently doing' UNION ALL
SELECT 'Development'          ,77 ,'Currently doing' UNION ALL
SELECT 'Development'          ,83 ,'Interested in'   UNION ALL
SELECT 'Development'          ,92 ,'Interested in'   UNION ALL
SELECT 'Finance'              ,3  ,'Currently doing' UNION ALL
SELECT 'Finance'              ,8  ,'Interested in'   UNION ALL
SELECT 'Finance'              ,77 ,'Interested in'   UNION ALL
SELECT 'Hospitality'          ,12 ,'Interested in'   UNION ALL
SELECT 'Hospitality'          ,14 ,'Currently doing' UNION ALL
SELECT 'Investment'           ,3  ,'Currently doing' UNION ALL
SELECT 'Investment'           ,77 ,'Interested in'   UNION ALL
SELECT 'Marketing'            ,75 ,'Currently doing' UNION ALL
SELECT 'Marketing'            ,83 ,'Interested in'   UNION ALL
SELECT 'Marketing'            ,92 ,'Interested in'   UNION ALL
SELECT 'Membership'           ,3  ,'Currently doing' UNION ALL
SELECT 'Membership'           ,7  ,'Currently doing' UNION ALL
SELECT 'Membership'           ,11 ,'Currently doing' UNION ALL
SELECT 'Membership'           ,13 ,'Currently doing' UNION ALL
SELECT 'Membership'           ,13 ,'Interested in'   UNION ALL
SELECT 'Membership'           ,76 ,'Interested in'   UNION ALL
SELECT 'Membership'           ,79 ,'Currently doing' UNION ALL
SELECT 'Membership'           ,82 ,'Interested in'   UNION ALL
SELECT 'Membership'           ,83 ,'Interested in'   UNION ALL
SELECT 'Membership'           ,92 ,'Interested in'   UNION ALL
SELECT 'Outreach'             ,3  ,'Currently doing' UNION ALL
SELECT 'Outreach'             ,12 ,'Currently doing' UNION ALL
SELECT 'Outreach'             ,77 ,'Currently doing' UNION ALL
SELECT 'Outreach'             ,90 ,'Interested in'   UNION ALL
SELECT 'Outreach'             ,92 ,'Interested in'   UNION ALL
SELECT 'Program Book'         ,3  ,'Currently doing' UNION ALL
SELECT 'Program Book'         ,20 ,'Interested in'   UNION ALL
SELECT 'Program Book'         ,80 ,'Currently doing' UNION ALL
SELECT 'Program Book'         ,83 ,'Interested in'   UNION ALL
SELECT 'Program Book'         ,89 ,'Currently doing' UNION ALL
SELECT 'Program Book'         ,90 ,'Currently doing' UNION ALL
SELECT 'Program Book'         ,92 ,'Interested in'   UNION ALL
SELECT 'Program Committee'    ,3  ,'Currently doing' UNION ALL
SELECT 'Program Committee'    ,92 ,'Currently doing' UNION ALL
SELECT 'Rehearsal Management' ,17 ,'Interested in'   UNION ALL
SELECT 'Rehearsal Management' ,83 ,'Interested in'   UNION ALL
SELECT 'Rehearsal Management' ,87 ,'Interested in'   UNION ALL
SELECT 'Tech Support'         ,13 ,'Interested in'   UNION ALL
SELECT 'Tech Support'         ,15 ,'Interested in'   UNION ALL
SELECT 'Tech Support'         ,82 ,'Currently doing' UNION ALL
SELECT 'Tech Support'         ,83 ,'Interested in'   UNION ALL
SELECT 'Tech Support'         ,87 ,'Interested in' 
) t WHERE id IS NOT NULL
