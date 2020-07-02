USE ApressFinancial 
GO 
INSERT INTO ShareDetails.SharePrices (ShareID,Price,PriceDate) 
     VALUES (1, 2.155, '1.08.2010 10:10AM'), 
            (1, 2.2125, '1.08.2010 10:12AM'), 
            (1, 2.4175, '1.08.2010 10:16AM'), 
            (1, 2.21, '1.08.2010 11:22AM'), 
            (1, 2.17, '1.08.2010 14:54'), 
            (1, 2.34125, '1.08.2010 16:10'), 
            (2, 41.10, '1.08.2010 10:10AM'), 
            (2, 43.22, '2.08.2010 10:10AM'), 
            (2, 45.20, '3.08.2010 10:10AM') 
INSERT INTO ShareDetails.Shares (ShareDesc,ShareTickerID,CurrentPrice) 
     VALUES ( 'FAT-BELLY.COM', 'FBC', 45.20000) 