USE ApressFinancial 
GO 

CREATE TRIGGER TransactionDetails.trgInsTransactions 
ON TransactionDetails.Transactions 
AFTER INSERT 
AS 
UPDATE CustomerDetails.Customers 
  SET CleareBalance = CleareBalance + 
    (SELECT CASE WHEN CreditType = 0 
           THEN i.Amount * -1 
           ELSE i.Amount 
        END 
     FROM INSERTED AS i 
      JOIN TransactionDetails.TransactionTypes AS tt 
        ON tt.TransactionTypesId = i.TransactionType 
     WHERE AffectCashBalance = 1 ) 
  FROM CustomerDetails.Customers AS c 
      JOIN INSERTED AS i 
        ON i.CustomerId = c.CustomerId; 

--select * from TransactionDetails.Transactions

SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 
 
INSERT INTO TransactionDetails.Transactions 
  (CustomerId,TransactionType,Amount,RelatedProductId,DateEntered) 
VALUES (1, 2, 200, 1, GETDATE()) 
 
SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 

SELECT * from CustomerDetails.Customers

SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 
 
INSERT INTO TransactionDetails.Transactions 
  (CustomerId,TransactionType,Amount,RelatedProductId,DateEntered) 
VALUES (1, 3, 200, 1, GETDATE()) 
 
SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 

ALTER TRIGGER TransactionDetails.trgInsTransactions 
ON TransactionDetails.Transactions 
AFTER INSERT 
AS 
UPDATE CustomerDetails.Customers 
  SET CleareBalance = CleareBalance + 
    ISNULL((SELECT CASE WHEN CreditType = 0 
           THEN i.Amount * -1            ELSE i.Amount 
        END 
      FROM INSERTED AS i 
      JOIN TransactionDetails.TransactionTypes AS tt 
        ON tt.TransactionTypesId = i.TransactionType 
      WHERE AffectCashBalance = 1 ), 0) 
  FROM CustomerDetails.Customers AS c 
      JOIN INSERTED AS i 
        ON i.CustomerId = c.CustomerId; 
GO

SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 
 
INSERT INTO TransactionDetails.Transactions 
  (CustomerId,TransactionType,Amount,RelatedProductId,DateEntered) 
VALUES (1, 3, 200, 1, GETDATE()) 
 
SELECT CleareBalance FROM CustomerDetails.Customers WHERE CustomerId=1; 


CREATE TRIGGER trgSprocs 
ON DATABASE 
FOR CREATE_PROCEDURE, ALTER_PROCEDURE, DROP_PROCEDURE 
AS 
IF DATEPART(hh, GETDATE()) > 9 AND DATEPART(hh, GETDATE()) < 17 
BEGIN 
  DECLARE @Message nvarchar(max) 
  SELECT @Message =  
      'Completing work during core hours. Trying to release -' 
      + EVENTDATA().value 
 
('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]','nvarchar(max)') 
  RAISERROR (@Message, 16, 1) 
  ROLLBACK 
EXEC msdb.dbo.sp_send_dbmail 
  @profile_name = 'SQL Server Database Mail Profile', 
  @recipients = 'exam@limtu.spb.ru', 
  @body = 'A stored procedure change', 
  @subject = 'A stored procedure change has been initiated 
        and rolled back during core hours' 
END;

--RAISERROR ('OPS', 16, 1) --??

--SELECT DATEPART(hh, GETDATE()) -- вывод целого значения текущего часа

CREATE PROCEDURE Test1 
AS 
SELECT 'Hello all'; 
go

CREATE TRIGGER trgDBDump 
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS 
  SELECT EVENTDATA(); 

CREATE PROC Test2 
AS 
SELECT 'Hello all';

DROP TRIGGER trgSprocs ON DATABASE; 
DROP TRIGGER trgDBDump ON DATABASE; 