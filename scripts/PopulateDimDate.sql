/*==============================================================
   Stored Procedure: usp_PopulateDimDate
   Purpose: Populate DimDate with basic attributes
   Inputs: @StartDate, @EndDate
   Output: Inserts rows into dbo.DimDate
   Notes: Loops day-by-day between StartDate and EndDate
==============================================================*/

-- 1. Make sure table exists
IF OBJECT_ID('dbo.DimDate','U') IS NOT NULL
    DROP TABLE dbo.DimDate;
GO

CREATE TABLE dbo.DimDate
(
    DateKey     INT         NOT NULL PRIMARY KEY,  -- YYYYMMDD format
    InvoiceDate DATE        NOT NULL,
    [Year]      INT         NOT NULL,
    [Month]     INT         NOT NULL,
    DayOfMonth  INT         NOT NULL,
    DayOfWeek   INT         NOT NULL,              -- 1 = Sunday, 7 = Saturday (default SQL Server)
    DayName     VARCHAR(20) NOT NULL,
    IsWeekend   BIT         NOT NULL
);
GO

-- 2. Stored procedure to populate table
IF OBJECT_ID('dbo.usp_PopulateDimDate','P') IS NOT NULL
    DROP PROCEDURE dbo.usp_PopulateDimDate;
GO

CREATE PROCEDURE dbo.usp_PopulateDimDate
    @StartDate DATE,
    @EndDate   DATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentDate DATE = @StartDate;

    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO dbo.DimDate (DateKey, InvoiceDate, [Year], [Month], DayOfMonth, DayOfWeek, DayName, IsWeekend)
        VALUES
        (
            CONVERT(INT, FORMAT(@CurrentDate,'yyyyMMdd')), -- DateKey
            @CurrentDate,                                  -- InvoiceDate
            YEAR(@CurrentDate),                            -- Year
            MONTH(@CurrentDate),                           -- Month
            DAY(@CurrentDate),                             -- DayOfMonth
            DATEPART(WEEKDAY, @CurrentDate),               -- DayOfWeek (1=Sunday default)
            DATENAME(WEEKDAY, @CurrentDate),               -- DayName (e.g., 'Monday')
            CASE WHEN DATENAME(WEEKDAY,@CurrentDate) IN ('Saturday','Sunday') THEN 1 ELSE 0 END
        );

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END;
GO

-- 3. Run the procedure (example: 2013-2016)
EXEC dbo.usp_PopulateDimDate @StartDate = '2013-01-01', @EndDate = '2016-05-31';

-- 4. Check results
SELECT TOP 10 * FROM dbo.DimDate ORDER BY InvoiceDate;
