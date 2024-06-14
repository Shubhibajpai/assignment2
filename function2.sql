CREATE FUNCTION FormatDateForSQL(input_date DATETIME)
RETURNS CHAR(8)
BEGIN
    DECLARE formatted_date CHAR(8);
    SET formatted_date = DATE_FORMAT(input_date, '%Y%m%d');
    RETURN formatted_date;
END;