USE ApressFinancial 
GO 
CREATE VIEW CustomerDetails.v_CustTrans 
AS 
SELECT TOP (100) PERCENT 
c.AccountNumber, c.CustomerFirstName, c.CustomerOtherInitials, 
tt.TransactionDescription, t.DateEntered, t.Amount, t.ReferenceDetails 
FROM  CustomerDetails.Customers AS c 
  JOIN TransactionDetails.Transactions AS t 
    ON t.CustomerId = c.CustomerId 
  JOIN TransactionDetails.TransactionTypes AS tt 
    ON tt.TransactionTypesId = t.TransactionType 
ORDER BY c.AccountNumber ASC, t.DateEntered DESC 