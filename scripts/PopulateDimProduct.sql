insert into WWISalesDW.dbo.dimproduct

SELECT        si.StockItemID, si.StockItemName, s.SupplierName
FROM            Warehouse.StockItems AS si INNER JOIN
                         Purchasing.Suppliers AS s ON si.SupplierID = s.SupplierID
