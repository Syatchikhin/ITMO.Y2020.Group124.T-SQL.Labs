-- =============================================
-- Create index basic template
-- =============================================
USE ApressFinancial
GO

CREATE INDEX IX_CustomersProducts
ON CustomerDetails.CustomersProducts 
(
	CustomerId
)
GO

-- создаем уникальный кластеризованный индекс    для таблицы TransactionDetails.TransactionTypes -- 
USE ApressFinancial 
GO 
CREATE UNIQUE CLUSTERED INDEX IX_TransactionTypes 
ON TransactionDetails.TransactionTypes  
(TransactionTypesId ASC) 
WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, 
    DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF)  
ON [PRIMARY] 
GO 

--создадим некластеризованный индекс 
--для таблицы TransactionDetails.Transactions 
-- на основе столбца TransactionType
 
CREATE NONCLUSTERED INDEX IX_TransactionTypes 
ON TransactionDetails.Transactions  
(TransactionType ASC) 
WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, 
    DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF)  
ON [PRIMARY] 
GO 

--USE ApressFinancial
--GO
--DROP INDEX IX_TransactionTypes ON Transactiondetails.TransactionTypes
--GO

--USE ApressFinancial
--GO
--DROP INDEX IX_TransactionTypes ON TransactionDetails.Transactions
--GO

USE ApressFinancial 
GO 
CREATE UNIQUE CLUSTERED INDEX IX_SharePrices 
ON ShareDetails.SharePrices 
(ShareID ASC, PriceDate ASC) 
WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, 
    DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF)  
ON [PRIMARY] 

USE ApressFinancial 
GO 
CREATE UNIQUE CLUSTERED INDEX IX_SharePrices 
ON ShareDetails.SharePrices 
(ShareID ASC, PriceDate DESC, Price) 
WITH (STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, 
    DROP_EXISTING = ON, IGNORE_DUP_KEY = OFF, ONLINE = OFF, 
    ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF)  
ON [PRIMARY] 