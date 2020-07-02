/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [AccountNumber]
      ,[CustomerFirstName]
      ,[CustomerOtherInitials]
      ,[TransactionDescription]
      ,[DateEntered]
      ,[Amount]
      ,[ReferenceDetails]
  FROM [ApressFinancial].[CustomerDetails].[v_CustTrans]

USE ApressFinancial 
GO 
INSERT INTO CustomerDetails.FinancialProducts (ProductID,ProductName) 
     VALUES (1, 'Regular Savings'), 
            (2, 'Bonds Account'), 
            (3, 'Share Account'), 
            (4, 'Life Insurance'); 
INSERT INTO CustomerDetails.CustomersProducts 
  (CustomerId,FinancialProductID,AmountToCollect, 
   Frequency, LastCollected, LastCollection, Renewable ) 
     VALUES (1, 1, 200, 1, '31.10.2008', '31.10.2025', 0), 
            (1, 2, 50,  1, '24.10.2010', '24.03.2012', 0), 
            (2, 4, 150, 3, '20.10.2010', '20.10.2010', 1), 
            (3, 3, 500, 0, '24.10.2010', '24.10.2010', 0); 

			USE ApressFinancial 
GO 
IF EXISTS(SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS 
      WHERE TABLE_NAME = 'v_CustFinProducts' 
        AND TABLE_SCHEMA = 'CustomerDetails') 
  DROP VIEW CustomerDetails.v_CustFinProducts 
GO 
CREATE VIEW CustomerDetails.v_CustFinProducts 
WITH SCHEMABINDING 
AS 
SELECT c.CustomerFirstName + ' ' + c.CustomerLastName AS CustomerName, 
     c.AccountNumber, fp.ProductName, cp.AmountToCollect, 
     cp.Frequency, cp.LastCollected 
FROM  CustomerDetails.Customers AS c 
  JOIN CustomerDetails.CustomersProducts AS cp 
    ON cp.CustomerId = c.CustomerId 
  JOIN CustomerDetails.FinancialProducts AS fp 
    ON fp.ProductID = cp.FinancialProductID 

	SELECT * FROM CustomerDetails.v_CustFinProducts 

	ALTER TABLE CustomerDetails.Customers  
ALTER COLUMN CustomerFirstName nvarchar(100) 

CREATE UNIQUE CLUSTERED INDEX IX_CustFinProdS 
ON CustomerDetails.v_CustFinProducts (AccountNumber, ProductName)

SET ANSI_NULLS ON 
GO 
SET ANSI_PADDING ON 
GO 
SET ANSI_WARNINGS ON 
GO 
SET CONCAT_NULL_YIELDS_NULL ON 
GO 
SET ARITHABORT ON 
GO 
SET QUOTED_IDENTIFIER ON 
GO 

SET NUMERIC_ROUNDABORT OFF 
GO 
SET ANSI_NULLS OFF 
GO 
SET QUOTED_IDENTIFIER OFF 
GO 


select *
from  CustomerDetails.v_CustFinProducts 