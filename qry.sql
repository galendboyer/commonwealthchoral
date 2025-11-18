SELECT * FROM v_quickbooks
WHERE 1=1
AND ((full_name_ds IS NOT NULL AND full_name_qb IS NULL)
OR (full_name_qb IS NOT NULL AND full_name_ds IS NULL))
-- AND full_name_qb IS NOT NULL AND full_name_ds IS NULL AND email_qb IS NULL
ORDER BY full_name_qb, full_name_ds



-- SELECT * FROM v_chorus
