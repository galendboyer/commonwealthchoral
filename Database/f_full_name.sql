DROP FUNCTION IF EXISTS f_full_name
go
CREATE FUNCTION f_full_name(@FName VARCHAR(100), @LName VARCHAR(100))
RETURNS VARCHAR(200)
AS
BEGIN
     DECLARE @str VARCHAR(200);
     IF @FName IS NULL OR @LName IS NULL
     BEGIN
        SET @str = COALESCE(@FName,@LName);
     END;
     ELSE
        SET @str = LOWER(CONCAT(ISNULL(@FName,''),' ',ISNULL(@LName,'')));
     RETURN @str;
END
go
-- SELECT dbo.f_full_name(NULL,NULL)
-- SELECT dbo.f_full_name('A',NULL)
-- SELECT dbo.f_full_name('A','B')
-- SELECT dbo.f_full_name(NULL,'B')

