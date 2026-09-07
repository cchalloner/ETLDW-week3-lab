CREATE TABLE [FactSales] (
  [FactKey] integer PRIMARY KEY IDENTITY(1, 1),
  [InvoiceNumber] integer,
  [ProductKey] integer,
  [CustomerKey] integer,
  [DateKey] integer,
  [QuantitySold] integer,
  [Profit] decimal(18,2),
  [Sales] decimal(18,2)
)
GO

CREATE TABLE [DimCustomer] (
  [CustomerKey] integer PRIMARY KEY IDENTITY(1, 1),
  [CustomerNumber] integer,
  [CustomerName] varchar(100),
  [CustomerCategory] varchar(50),
  [CityName] varchar(50),
  [State] varchar(50),
  [Country] varchar(60)
)
GO

CREATE TABLE [DimProduct] (
  [ProductKey] integer PRIMARY KEY IDENTITY(1, 1),
  [ProductNumber] integer,
  [ProductName] varchar(100),
  [SupplierName] varchar(100)
)
GO

ALTER TABLE [FactSales] ADD CONSTRAINT [factsales_dimCustomer] FOREIGN KEY ([CustomerKey]) REFERENCES [DimCustomer] ([CustomerKey])
GO

ALTER TABLE [FactSales] ADD CONSTRAINT [factsales_dimProduct] FOREIGN KEY ([ProductKey]) REFERENCES [DimProduct] ([ProductKey])
GO

ALTER TABLE dbo.FactSales ADD CONSTRAINT factsales_DimDate FOREIGN KEY (DateKey) REFERENCES dbo.DimDate (DateKey);
GO
