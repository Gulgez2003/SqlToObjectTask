# SQL to Object

This repository provides SQL scripts for creating a database named `SqlToObject` and a table named `Employees` within that database. Additionally, it includes a SQL script to generate a C# class corresponding to the structure of the `Employees` table.

## Database and Table Creation

Execute the following SQL script to create the database and the `Employees` table:

```sql
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
```

## C# Class Generation

Execute the following SQL script to generate a C# class based on the structure of the `Employees` table:

```sql
DECLARE @tableName NVARCHAR(255);
SET @tableName = 'Employees';

DECLARE @columnsInfo NVARCHAR(MAX);

-- INT columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'int' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'INT';

-- NOT NULL NVARCHAR columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ '[Required(ErrorMessage = "The LastName is required")]' + CHAR(13) + CHAR(10)
+ '[MaxLength(255)]' + CHAR(13) + CHAR(10)
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'nvarchar' AND IS_NULLABLE='NO';

-- Nullable NVARCHAR columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ '[MaxLength(255)]' + CHAR(13) + CHAR(10)
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'nvarchar' AND IS_NULLABLE='YES';

-- DATETIME columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'DateTime' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'datetime';

-- Image columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'byte[]' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'image';

-- NTEXT columns
SELECT @columnsInfo = COALESCE(@columnsInfo + CHAR(13) + CHAR(10), '') 
+ 'public ' + 'string' + ' ' + COLUMN_NAME + ' { get; set; }'
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName AND DATA_TYPE = 'ntext';

PRINT 'public class ' + @tableName;
PRINT '{';
PRINT @columnsInfo;
PRINT '}';
```

This script generates a C# class with properties corresponding to the columns of the `Employees` table, including appropriate data annotations for validation. Adjust the script as needed for your specific requirements.
