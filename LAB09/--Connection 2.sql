--Connection 2
-- Connection 2 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 


-- Connection 2 
-- Stop, then set the LOCK_TIMEOUT, then retry 

SET LOCK_TIMEOUT 5000; 
 
SELECT [ID], [Price] 
FROM dbo.[t1] 
WHERE [ID] = 2; 


-- Connection 2 
-- Remove timeout 
SET LOCK_TIMEOUT -1; 
 
SELECT [ID], [Price] 
FROM dbo.[t1] 
WHERE [ID] = 2; 


USE [test_block]
GO

-- Connection 2 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 
 
BEGIN TRAN; 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

--READ COMMITED LEVEL--

USE [test_block]; 

-- Connection 2 
SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 
 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

--REPEATABLE READ--
USE [test_block];

-- Connection 2 
UPDATE dbo.[t1] 
  SET [Price] = [Price] + 1.00 
WHERE [ID] = 2; 

SELECT *
FROM dbo.[t1] 
WHERE [ID] = 2



--REPEATABLE READ--
USE [test_block];

-- Connection 2 
UPDATE dbo.[t1] 
  SET [Price] = [Price] + 1.00 
WHERE [ID] = 2;

SELECT *
FROM dbo.[t1] 
WHERE [ID] = 2

--SERIALIZABLE --
USE [test_block];

-- Connection 2 
INSERT INTO dbo.[t1] 
    ( [Name], [Number], [Price], [Discount]) 
  VALUES('Product ABCDE', 1, 1.00, 0.050);
  
  SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 

--SNAPSHOT-
USE [test_block];

-- Connection 2 
SET TRANSACTION ISOLATION LEVEL SNAPSHOT; 
BEGIN TRAN; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

  -- Connection 2 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
COMMIT TRAN; 

-- Connection 2 
BEGIN TRAN; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
COMMIT TRAN; 

-- Connection 2, Step 1 
  UPDATE dbo.[t1] 
    SET [Price] = 25.00 
  WHERE [ID] = 2;
  

  --READ COMMITTED SNAPSHOT
  USE [test_block];

-- Connection 2 
BEGIN TRAN; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

   SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

   COMMIT TRAN; 
