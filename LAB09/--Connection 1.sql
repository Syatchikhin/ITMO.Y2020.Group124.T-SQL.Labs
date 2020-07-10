--Connection 1
USE [test_block]
-- Connection 1 
BEGIN TRAN; 
  UPDATE dbo.[t1] 
    SET [Price] = [Price] + 1.00 
  WHERE [ID] = 2; 
SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

-- Connection 1 
ROLLBACK TRAN; 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

--READ COMMITED LEVEL--
USE [test_block]; 

-- Connection 1 
BEGIN TRAN; 
  UPDATE dbo.[t1] 
    SET [Price] = [Price] + 1.00 
  WHERE [ID] = 2; 
SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

-- Connection 1 
ROLLBACK TRAN; 

--REPEATABLE READ--
USE [test_block];

-- Connection 1 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
 
BEGIN TRAN; 
SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

-- Connection 1 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
COMMIT TRAN; 



-- Connection 1 
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED; 

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 

BEGIN TRAN; 
  SELECT [ID], [Name], [Price], [Discount] 
  FROM dbo.[t1] 
  WHERE [Discount] < 0.20; 

 -- SELECT * FROM dbo.[t1]

  
--REPEATABLE READ--
USE [test_block];

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ; 
 
BEGIN TRAN; 
SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

-- Connection 1 
SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
COMMIT TRAN; 

--SERIALIZABLE --
USE [test_block];

-- Connection 1 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE; 
BEGIN TRAN; 
  SELECT [ID], [Name], [Price], [Discount] 
  FROM dbo.[t1] 
  WHERE [Discount] < 0.20; 

  -- Connection 1 
  SELECT [ID], [Name], [Price], [Discount] 
  FROM dbo.[t1] 
  WHERE [Discount] < 0.20; 
COMMIT TRAN; 

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

--SNAPSHOT-
USE [test_block];

ALTER DATABASE [test_block] SET ALLOW_SNAPSHOT_ISOLATION ON; 

SELECT * FROM dbo.t1;

-- Connection 1 
BEGIN TRAN; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
UPDATE dbo.[t1] 
  SET [Price] = [Price] + 1.00 
WHERE [ID] = 2; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

  -- Connection 1 
COMMIT TRAN; 

-- Connection 1, Step 1 
SET TRANSACTION ISOLATION LEVEL SNAPSHOT; 
BEGIN TRAN; 
  SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

  -- Connection 1, Step 2 
  UPDATE dbo.[t1] 
    SET [Price] = 20.00 
  WHERE [ID] = 2; 
COMMIT TRAN; 

-- Connection 1, Step 1 
BEGIN TRAN; 
  SELECT [ID],[Price] FROM dbo.[t1] WHERE [ID] = 2; 

  -- Connection 1, Step 2 
  UPDATE dbo.[t1] 
    SET [Price] = 20.00 
  WHERE [ID] = 2;

--READ COMMITTED SNAPSHOT 
USE [test_block];

ALTER DATABASE [test_block] SET READ_COMMITTED_SNAPSHOT ON; 

-- Connection 1 
BEGIN TRAN; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 
UPDATE dbo.[t1] 
  SET [Price] = [Price] + 1.00 
WHERE [ID] = 2; 
  SELECT [ID], [Price] FROM dbo.[t1] WHERE [ID] = 2; 

  -- Connection 1 
COMMIT TRAN;