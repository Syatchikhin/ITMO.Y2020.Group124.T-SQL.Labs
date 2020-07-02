-- =========================================
-- Create table template
-- =========================================
USE ApressFinancial
GO

IF OBJECT_ID('TransactionDetails.TransactionTypes', 'U') IS NOT NULL
  DROP TABLE TransactionDetails.TransactionTypes
GO

CREATE TABLE TransactionDetails.TransactionTypes
(
	TransactionTypesId int IDENTITY (1,1) NOT NULL, 
	TransactionDescription nvarchar(30) NULL, 
	CreditType bit NOT NULL, 
    
)
GO

USE ApressFinancial
GO

ALTER TABLE TransactionDetails.TransactionTypes
ADD AffectCashBalance bit NULL
GO

SELECT * FROM TransactionDetails.TransactionTypes
GO

USE ApressFinancial
GO

ALTER TABLE TransactionDetails.TransactionTypes
ALTER COLUMN AffectCashBalance bit NOT NULL
GO

SELECT * FROM TransactionDetails.TransactionTypes
GO

USE ApressFinancial 
GO 
 
ALTER TABLE TransactionDetails.TransactionTypes 
ADD CONSTRAINT 
  PK_TransactionTypes PRIMARY KEY NONCLUSTERED (TransactionTypesId) 
  WITH (STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)  
ON [PRIMARY] 
GO 

USE ApressFinancial 
GO 
 
CREATE TABLE CustomerDetails.CustomersProducts 
( 
  CustomerFinancialProductID bigint IDENTITY (1,1) NOT NULL, 
  CustomerId bigint NOT NULL, 
  FinancialProductID bigint NOT NULL, 
  AmountToCollect money NOT NULL, 
  Frequency smallint NOT NULL, 
  LastCollected datetime NOT NULL, 
  LastCollection datetime NOT NULL, 
  Renewable bit NOT NULL, 
) ON [PRIMARY] 
GO 
 
CREATE TABLE CustomerDetails.FinancialProducts 
( 
  ProductID bigint NOT NULL, 
  ProductName nvarchar(50) NOT NULL 
) ON [PRIMARY] 
GO 

CREATE SCHEMA ShareDetails AUTHORIZATION dbo 
  CREATE TABLE SharePrices (SharePriceID bigint IDENTITY (1,1) NOT 
NULL, 
            ShareID bigint NOT NULL, 
            Price numeric(18,5) NOT NULL,             PriceDate datetime NOT NULL 
            )  
GO 
 
CREATE TABLE ShareDetails.Shares 
( 
  ShareID bigint IDENTITY (1,1) NOT NULL, 
  ShareDesc nvarchar(50) NOT NULL, 
  ShareTickerID nvarchar(50) NULL, 
  CurrentPrice numeric(18,5) NOT NULL 
) ON [PRIMARY] 
GO 

USE ApressFinancial 
GO 
 
ALTER TABLE TransactionDetails.Transactions 
WITH NOCHECK 
ADD CONSTRAINT FK_Transactions_Shares FOREIGN KEY (RelatedShareId) 
  REFERENCES ShareDetails.Shares(ShareID) 
GO 

SELECT * 
FROM ShareDetails.Shares
GO