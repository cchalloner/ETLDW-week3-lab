insert into WWISalesDW.dbo.DimCustomer

SELECT        c.CustomerID, c.CustomerName, cc.CustomerCategoryName, city.CityName, sp.StateProvinceName, Application.Countries.CountryName
FROM            Sales.Customers AS c INNER JOIN
                         Application.Cities AS city ON c.DeliveryCityID = city.CityID INNER JOIN
                         Application.StateProvinces AS sp ON city.StateProvinceID = sp.StateProvinceID INNER JOIN
                         Application.Countries ON sp.CountryID = Application.Countries.CountryID INNER JOIN
                         Sales.CustomerCategories AS cc ON c.CustomerCategoryID = cc.CustomerCategoryID
