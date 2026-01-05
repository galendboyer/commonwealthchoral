SELECT email_roster, count(1) FROM v_subscriber WHERE IS_A_DUPLICATE = 'No' GROUP BY email_roster HAVING COUNT(1) > 1
