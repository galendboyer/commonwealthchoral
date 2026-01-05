SELECT
        ros.email
,       ros.address_normalized        
,       snail.email_roster
,       snail.address_concat
FROM v_roster ros
INNER JOIN v_snail_mail snail
-- ON ros.address_normalized = snail.address_concat
ON ros.email = snail.email_roster
-- WHERE snail.email IS NOT NULL
