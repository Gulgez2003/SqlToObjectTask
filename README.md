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
```sql
## C# Class Generation

Execute the following SQL script to generate a C# class based on the structure of the `Employees` table:
