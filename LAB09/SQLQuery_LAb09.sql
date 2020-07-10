USE ApressFinancial 
GO 

SELECT * 
  FROM ShareDetails.Shares

SELECT 'Before',ShareId,ShareDesc,CurrentPrice 
  FROM ShareDetails.Shares 
  WHERE ShareId = 3 

BEGIN TRAN ShareUpd 
  UPDATE ShareDetails.Shares 
  SET CurrentPrice = CurrentPrice * 1.1 
  WHERE ShareId = 3 
COMMIT TRAN 

SELECT 'After',ShareId,ShareDesc,CurrentPrice 
  FROM ShareDetails.Shares 
  WHERE ShareId = 3 
  GO


  SELECT 'Before',ShareId,ShareDesc,CurrentPrice 
  FROM ShareDetails.Shares 
  WHERE ShareId <= 3 
BEGIN TRAN ShareUpd 
  UPDATE ShareDetails.Shares 
    SET CurrentPrice = CurrentPrice * 2.0 
    WHERE ShareId <= 3 
  SELECT 'Within the transaction',ShareId,ShareDesc,CurrentPrice 
    FROM ShareDetails.Shares WHERE ShareId <= 3 
ROLLBACK TRAN 
  SELECT 'After',ShareId,ShareDesc,CurrentPrice 
  FROM ShareDetails.Shares 
  WHERE ShareId <= 3 
  gO



  BEGIN TRAN ShareUpd 
  SELECT '1st TranCount',@@TRANCOUNT 
BEGIN TRAN ShareUpd2 
  SELECT '2nd TranCount',@@TRANCOUNT 
COMMIT TRAN ShareUpd2 
  SELECT '3rd TranCount',@@TRANCOUNT 
COMMIT TRAN -- It is at this point that data modifications will be committed 
  SELECT 'Last TranCount',@@TRANCOUNT 

