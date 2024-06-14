CREATE FUNCTION FormatDate (@input_datetime DATETIME)
RETURNS VARCHAR(10)
AS
BEGIN
    DECLARE @formatted_date VARCHAR(10)
    SET @formatted_date = FORMAT(@input_datetime, 'MM/dd/yyyy')
    RETURN @formatted_date
END
DECLARE @input_date DATETIME = '2006-11-21 23:34:05.920'
SELECT dbo.FormatDate(@input_date) AS FormattedDate
