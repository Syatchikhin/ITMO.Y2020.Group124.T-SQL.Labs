-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Maksim
-- Create date: 06.07.2020
-- Description:	This is to insert a customer
-- =============================================
CREATE PROCEDURE CustomerDetails.apf_insCustomer 
	-- Add the parameters for the stored procedure here
	@FirstName varchar(50) , 
	@LastName varchar(50), 
	@CustTitle int,
	@CustInitials varchar(10),
	@AddressId int,
	@AccountNumber nvarchar(15),
	@AccountTypeId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 INSERT INTO CustomerDetails.Customers  
    (CustomerTitleId, CustomerFirstName, CustomerOtherInitials, 
     CustomerLastName, AddressId, AccountNumber, AccountTypeId, 
     CleareBalance, UncleareBalance) 
  VALUES (@CustTitle,@FirstName,@CustInitials,@LastName, 
      @AddressId,@AccountNumber,@AccountTypeId, 0, 0) 
END
GO


CustomerDetails.apf_insCustomer 'Henry','Williams',1,NULL,431,'22067531',1; 


EXEC CustomerDetails.apf_insCustomer @CustTitle=1, @FirstName='Julie', 
  @CustInitials='A', @LastName='Dewson',  @AddressId=643, 
  @AccountNumber='SS865', @AccountTypeId=7; 
GO


SELECT * FROM CustomerDetails.Customers


CREATE PROCEDURE CustomerDetails.apf_CusMovement  
  @CustID bigint, @FromDate datetime, @ToDate datetime 
AS 
BEGIN 
/* нам нужны три внутренние переменные:  
   идентификатор транзакции из таблицы будем сохранять в @LastTran 
   @StillCalc используется для проверки цикла WHILE */ 
  DECLARE @RunningBal money, @StillCalc bit, @LastTran bigint 
  SELECT @StillCalc = 1, @LastTran = 0, @RunningBal = 0 
-- выполнение цикла WHILE продолжается, пока инструкция возвращает строку 
-- если строка не получена, значит в диапазоне дат больше нет транзакций 
  WHILE @StillCalc = 1 
  BEGIN 
-- инструкция SELECT возвращает одну строку, в которой ( WHERE ): 
-- идентификатор TransactionId больше предыдущего возвращенного идентификатора, 
-- транзакция оказывает влияние на баланс клиента  и  
-- транзакция находится в переданном диапазоне дат 
    SELECT TOP 1  @RunningBal = @RunningBal + CASE 
          WHEN tt.CreditType = 1 THEN t.Amount 
          ELSE t.Amount* -1 END, 
        @LastTran = t.TransactionId 
    FROM  CustomerDetails.Customers AS c 
      JOIN TransactionDetails.Transactions AS t 
        ON t.CustomerId = c.CustomerId 
      JOIN TransactionDetails.TransactionTypes AS tt 
        ON tt.TransactionTypesId = t.TransactionType 
    WHERE t.TransactionId > @LastTran AND 
        tt.AffectCashBalance = 1  AND 
        DateEntered BETWEEN @FromDate AND @ToDate 
    ORDER BY DateEntered 
-- если строка возвращена, то выполнение цикла продолжается 
    IF @@ROWCOUNT > 0 
      -- здесь следует выполнить расчет процента 
      CONTINUE 
    ELSE 
      BREAK 
  END 
  SELECT @RunningBal AS 'End Balance' 
END; 

INSERT INTO TransactionDetails.Transactions  
    (CustomerId, TransactionType, DateEntered, Amount, 
     RelatedProductId) 
VALUES    (1, 1, '1.08.2008', 100.00, 1), 
    (1, 1, '3.08.2008', 75.67, 1), 
    (1, 2, '5.08.2008', 35.20, 1), 
    (1, 2, '6.08.2008', 20.00, 1); 
INSERT INTO TransactionDetails.TransactionTypes 
    (TransactionDescription, CreditType, AffectCashBalance) 
VALUES    ( 'proc+', 1, 1), 
    ( 'proc-', 0, 1); 

SELECT * FROM TransactionDetails.Transactions  

SELECT * FROM TransactionDetails.TransactionTypes  

EXECUTE CustomerDetails.apf_CusMovement 1,'1.08.2008','31.08.2008'; 

CREATE FUNCTION TransactionDetails.ufn_ReturnTransactions (@CustID bigint) 
RETURNS @Trans TABLE   (TransactionId bigint, 
            CustomerId bigint, 
            TransactionDescription nvarchar(30), 
            DateEntered datetime, 
            Amount money) 
AS 
BEGIN 
  INSERT INTO @Trans 
  SELECT TransactionId, CustomerId,TransactionDescription, 
      DateEntered, Amount 
  FROM TransactionDetails.Transactions AS t 
    JOIN TransactionDetails.TransactionTypes AS tt 
  ON tt.TransactionTypesId = t.TransactionType 
  WHERE CustomerId = @CustID 
  RETURN 
END; 

SELECT  c.CustomerFirstName, c.CustomerLastName, 
    Trans.TransactionId, TransactionDescription, 
    DateEntered, Amount 
FROM CustomerDetails.Customers AS c 
  CROSS APPLY 
  TransactionDetails.ufn_ReturnTransactions (c.CustomerId) AS Trans;
  
SELECT  c.CustomerFirstName, c.CustomerLastName, 
    Trans.TransactionId, TransactionDescription, 
    DateEntered, Amount 
FROM CustomerDetails.Customers AS c 
  OUTER APPLY 
  TransactionDetails.ufn_ReturnTransactions (c.CustomerId) AS Trans; 