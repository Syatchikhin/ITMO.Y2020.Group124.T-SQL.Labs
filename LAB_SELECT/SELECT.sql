USE  AdventureWorks2016
GO
SELECT *
FROM Person.Person
GO

USE  AdventureWorks2016
GO
SELECT Title, FirstName, LastName, MiddleName
FROM Person.Person
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, ListPrice, Color, Size, Weight
FROM Production.Product
WHERE ListPrice < 100
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, ListPrice, Color, Size, Weight
FROM Production.Product
WHERE ListPrice < 100 AND ProductNumber LIKE 'SO%'
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, ListPrice, Color, Size, Weight
FROM Production.Product
WHERE ListPrice < 100 
AND ProductNumber LIKE 'SO%'
OR ProductNumber Like 'TG%'
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, ListPrice, Color, Size, Weight
FROM Production.Product
WHERE ProductNumber LIKE 'SO%'
OR (ListPrice Between  50 and 180 and ProductNumber Like 'TG%')
GO

--6
USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, ListPrice, Color, Size, Weight
FROM Production.Product
WHERE ProductNumber LIKE 'SO%'
OR (ListPrice Between  50 and 180 and ProductNumber Like 'TG%'
and Size IN ('M', 'L'))
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Weight
FROM Production.Product
WHERE ProductLine IS NULL
GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Weight,
isnull(ProductLine, 'NA')
FROM Production.Product
 GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Weight,
isnull(ProductLine, 'NA') As 'Product Line'
FROM Production.Product
 GO

 USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, COALESCE(CONVERT(NVARCHAR,Weight),
SIZE, 'NA') AS Measurement,
isnull(ProductLine, 'NA') As 'Product Line'
FROM Production.Product
 GO

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Class
FROM Production.Product
ORDER BY Class

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Class, ListPrice
FROM Production.Product
ORDER BY Class, ListPrice Desc

USE  AdventureWorks2016
GO
SELECT ProductNumber, Name, Class, ListPrice
FROM Production.Product
ORDER BY ListPrice Desc

USE  AdventureWorks2016
GO
SELECT DISTINCT COLOR
FROM Production.Product
WHERE ProductNumber LIKE 'HL%'

SELECT *
FROM Production.Product
WHERE ProductNumber LIKE 'HL%'

--10--
USE  AdventureWorks2016
GO
SELECT (LastName +' , ' + FirstName)
FROM Person.Person

USE  AdventureWorks2016
GO
SELECT (LastName +' , ' + FirstName)
AS Contacts
FROM Person.Person

USE  AdventureWorks2016
GO
SELECT (LastName +' , ' + FirstName) AS Contacts
FROM Person.Person
WHERE SubString (LastName,1,3) = 'Mac'

--11--
SELECT AVG(VacationHours)
AS 'AverageVacationHours',
SUM (SickLeaveHours) AS 'TotalSickLeave Hours'
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Vice President%'

SELECT COUNT(*)
FROM HumanResources.Employee

SELECT *
FROM HumanResources.Employee

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE '%Design Engineer%'

--12--
SELECT COUNT (*)
FROM Person.Address
WHERE ISNULL (AddressLine2, '0') = '0'

SELECT COUNT (AddressLine2)
FROM Person.Address

SELECT COUNT (DISTINCT AddressLine2)
FROM Person.Address

--13--ѕодведение итогов--???
SELECT ProductID, AVG(DaysToManufacture)
AS 'AvgDaysToManufacture'
FROM Production.Product


SELECT * 
FROM Production.Product


SELECT Color, AVG(ListPrice) AS 'AvgListPrice'
FROM Production.Product
WHERE ProductNumber = 'FR-272R-58'
GROUP BY ALL Color

SELECT ProductID, AVG(OrderQty)
AS 'AverageQuantity', SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail 
GROUP BY ProductID
HAVING SUM(LineTotal) > 1000000 AND AVG(OrderQty) < 3

-- плюсом сорт  по убыванию цены --
SELECT ProductID, AVG(OrderQty)
AS 'AverageQuantity', SUM(LineTotal) AS Total
FROM Sales.SalesOrderDetail 
GROUP BY ProductID
HAVING SUM(LineTotal) > 1000000 AND AVG(OrderQty) < 3
ORDER BY Total Desc

