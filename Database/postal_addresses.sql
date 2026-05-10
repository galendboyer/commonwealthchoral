WITH
 w_roster AS (
SELECT
        email
,       address_normalized        
FROM    v_roster
)
,w_postal AS (
SELECT
        email_roster AS email
,       address_concat        
FROM v_snail_mail
)
SELECT
        w_roster.email
,       w_roster.address_normalized AS address_roster
,       w_postal.address_concat AS address_postal
FROM w_roster
INNER JOIN w_postal
ON w_roster.email = w_postal.email
;
