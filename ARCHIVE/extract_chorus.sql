SELECT
        email
,       Last
,       First
,       Middle
,       "Voice Part" 
,       "Paid Staff"
,       Active
,       Address1
,       Address2
,       City
,       State AS "State/Province"
,       ZIP AS "Zip/Postal Code"
FROM v_chorus
WHERE email in ('galendboyer@gmail.com','nmacgaffey@gmail.com')
