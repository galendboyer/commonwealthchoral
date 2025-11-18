DECLARE @str VARCHAR(50) = '%KAT%';
SELECT * FROM v_Intuit WHERE UPPER(full_name_chorus) LIKE @str OR UPPER(full_name_intuit) LIKE @str

SELECT * FROM t_intuit



SELECT * FROM v_intuit 
WHERE full_name_intuit IS NOT NULL AND full_name_chorus IS NOT NULL
ORDER BY Full_name_chorus
