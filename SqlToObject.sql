CREATE DATABASE SqlToObject
USE SqlToObject
CREATE TABLE Employees (
    EmployeeID int NOT NULL,
    LastName nvarchar(255) NOT NULL,
    FirstName nvarchar(255) NOT NULL,
    Title nvarchar(255) NULL,
    TitleOfCourtesy nvarchar(255) NULL,
    BirthDate datetime NULL,
    HireDate datetime NULL,
    Address nvarchar(255) NULL,
    City nvarchar(255) NULL,
    Region nvarchar(255) NULL,
    PostalCode nvarchar(255) NULL,
    Country nvarchar(255) NULL,
    HomePhone nvarchar(255) NULL,
    Extension nvarchar(255) NULL,
    Photo image NULL,
    Notes ntext NULL,
    ReportsTo int NULL,
    PhotoPath nvarchar(255) NULL
);

DECLARE @tableName NVARCHAR(255);
SET @tableName = 'Employees';

DECLARE @columnsInfo NVARCHAR(MAX);
DECLARE @dataTypeInfo NVARCHAR(MAX);

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'int' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'INT';

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ '[Required(ErrorMessage = "The LastName is required")]' + CHAR(13) + CHAR(10)
+ '[MaxLength(255)]' + CHAR(13) + CHAR(10)
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'nvarchar' AND IS_NULLABLE='NO';

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ '[MaxLength(255)]' + CHAR(13) + CHAR(10)
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'nvarchar' AND IS_NULLABLE='YES';

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'DateTime' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'datetime';

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'byte[]' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'image';

SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'ntext';

PRINT 'public class ' + @tableName;
PRINT '{';
PRINT @columnsInfo;
PRINT '}'
