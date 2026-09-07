
--228,265
insert into factsales
SELECT        l.InvoiceID, DimProduct.ProductKey, DimCustomer.CustomerKey, DimDate.DateKey, l.Quantity, l.LineProfit, l.Quantity * l.UnitPrice AS Sales
FROM            WideWorldImporters.Sales.InvoiceLines AS l INNER JOIN
                         WideWorldImporters.Sales.Invoices AS i ON l.InvoiceID = i.InvoiceID INNER JOIN
                         DimProduct ON l.StockItemID = DimProduct.ProductNumber INNER JOIN
                         DimCustomer ON i.CustomerID = DimCustomer.CustomerNumber INNER JOIN
                         DimDate ON i.InvoiceDate = DimDate.InvoiceDate