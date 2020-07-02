USE [ApressFinancial]
GO



SET QUOTED_IDENTIFIER OFF 
GO 
INSERT INTO [ApressFinancial].[ShareDetails].[Shares] 
           ([ShareDesc] 
           ,[ShareTickerID] 
           ,[CurrentPrice]) 
     VALUES 
           ("ACME'S HOMEBAKE COOKIES INC" 
           ,'AHCI' 
           ,2.34125) 


select *
FROM ShareDetails.Shares
GO

USE ApressFinancial 
GO 

INSERT INTO CustomerDetails.Customers 
  (CustomerTitleId, CustomerLastName, CustomerFirstName, 
   CustomerOtherInitials, AddressId, AccountNumber, 
   AccountTypeId, CleareBalance, UncleareBalance) 
VALUES (3, 'Lobel', 'Leonard', NULL, 145, 53431993, 1, 437.97, -10.56) 

select * from CustomerDetails.Customers 

--считать сначала CustomerID  и заполнить сначала 

USE ApressFinancial 
GO 
DELETE FROM  CustomerDetails.Customers 
DBCC CHECKIDENT ('CustomerDetails.Customers',RESEED,0) 
INSERT INTO CustomerDetails.Customers 
  (CustomerTitleId, CustomerLastName, CustomerFirstName, 
   CustomerOtherInitials, AddressId, AccountNumber, 
   AccountTypeId, CleareBalance, UncleareBalance) 
VALUES (1, 'Brust', 'Andrew', 'J.', 133, 18176111, 1, 200.00, 2.00), 
       (3, 'Lobel', 'Leonard', NULL, 145, 53431993, 1, 437.97, -10.56) 

select * from CustomerDetails.Customers 


USE ApressFinancial 
GO

ALTER TABLE CustomerDetails.CustomersProducts 
ADD  CONSTRAINT PK_CustomersProducts 
   PRIMARY KEY CLUSTERED  
    (CustomerFinancialProductID) 
ON [PRIMARY] 
GO 

ALTER TABLE CustomerDetails.CustomersProducts 
WITH NOCHECK 
ADD  CONSTRAINT CK_CustProds_AmtCheck 
CHECK  (AmountToCollect > 0 ) 
GO 
 
ALTER TABLE CustomerDetails.CustomersProducts 
WITH NOCHECK 
ADD  CONSTRAINT DF_CustProds_Renewable 
  DEFAULT (0) 
  FOR Renewable 
GO 

--negative amount--
INSERT INTO CustomerDetails.CustomersProducts 
  (CustomerId,FinancialProductID,AmountToCollect,Frequency 
  ,LastCollected,LastCollection,Renewable) 
VALUES (1, 1, -100, 0, '24.08.2010', '24.08.2010', 0) 
 

 --old date--LastCollection >= LastCollected
INSERT INTO CustomerDetails.CustomersProducts 
  (CustomerId,FinancialProductID,AmountToCollect,Frequency 
  ,LastCollected,LastCollection,Renewable) 
VALUES (1, 1, 100, 0, '24.08.2010', '20.08.2010', 0)

select * FROM CustomerDetails.CustomersProducts
gO

INSERT INTO CustomerDetails.Customers 
  (CustomerTitleId, CustomerFirstName, CustomerOtherInitials, 
   CustomerLastName, AddressId, AccountNumber, 
   AccountTypeId, CleareBalance, UncleareBalance) 
VALUES (3, 'Bernie', 'I', 'McGee', 314, 65368765, 1, 6653.11, 0.00), 
       (2, 'Julie', 'A','Dewson', 2134, 81625422, 1, 53.32, -12.21), 
       (1, 'Kirsty', NULL,'Hull', 4312, 96565334, 1, 1266.00, 10.32); 
 INSERT INTO ShareDetails.Shares 
(ShareDesc, ShareTickerId,CurrentPrice) 
VALUES ('FAT-BELLY.COM','FBC',45.20), 
   ('NetRadio Inc','NRI',29.79), 
   ('Texas Oil Industries','TOI',0.455), 
   ('London Bridge Club','LBC',1.46); 

   select * 
   from CustomerDetails.Customers  
   go


USE ApressFinancial 
GO 
 
SELECT * FROM CustomerDetails.Customers 
 
SELECT CustomerFirstName, CustomerLastName, CleareBalance 
FROM CustomerDetails.Customers 
 
SELECT CustomerFirstName AS 'First Name',  
       CustomerLastName AS 'Last Name',  
       CleareBalance 'Balance' 
FROM CustomerDetails.Customers 

USE ApressFinancial 
GO 
 
UPDATE CustomerDetails.Customers 
SET CustomerLastName = 'Brodie' 
WHERE CustomerId = 4 

select * 
from CustomerDetails.Customers 
go

USE ApressFinancial 
GO 
DECLARE @ValueToUpdate VARCHAR(30) 
SET @ValueToUpdate = 'McGlynn' 
UPDATE CustomerDetails.Customers 
SET CustomerLastName = @ValueToUpdate, 
    CleareBalance = CleareBalance + UncleareBalance, 
    UncleareBalance = 0 
WHERE CustomerLastName = 'Brodie' 


USE ApressFinancial 
GO 
DECLARE @WrongDataType VARCHAR(20) 
SET @WrongDataType = '4311.22' 
UPDATE CustomerDetails.Customers 
SET CleareBalance = @WrongDataType 
WHERE CustomerId = 4 

--delete data--
USE tempdb 
GO 
SELECT CustomerId, CustomerFirstName, 
       CustomerOtherInitials, CustomerLastName 
INTO dbo.Customers 
FROM ApressFinancial.CustomerDetails.Customers 

select *
from dbo.Customers 


DELETE FROM dbo.Customers 
WHERE CustomerId = 4 

INSERT INTO dbo.Customers
(CustomerFirstName, CustomerOtherInitials, CustomerLastName)
values
('Вася', 'Николаевич' ,'Пупкин')

DELETE FROM dbo.Customers 
where CustomerId = 6

DELETE FROM dbo.Customers

INSERT INTO dbo.Customers
(CustomerFirstName, CustomerOtherInitials, CustomerLastName)
values
('Вася', 'Николаевич' ,'Пупкин')

TRUNCATE TABLE dbo.Customers 

INSERT INTO dbo.Customers
(CustomerFirstName, CustomerOtherInitials, CustomerLastName)
values
('Вася', 'Николаевич' ,'Пупкин')

select *
from dbo.Customers 