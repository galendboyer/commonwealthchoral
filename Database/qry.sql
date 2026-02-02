SELECT * FROM v_subscriber where is_member = 1 and email not in (select email from v_roster) order by LName, FName

SELECT * FROM v_roster where fname = 'Megan'

select * from v_volunteer

select * from v_subscriber

select * from v_Snail_Mail WHERE Email_Roster IS NOT NULL

SELECT LoadID, Email_Roster address_concat, fname, lname FROM v_snail_mail where email_roster is null
