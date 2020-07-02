CREATE DATABASE ApressFinancial 
ON 
PRIMARY 
  ( NAME = N'ApressFinancial', 
  FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ApressFinancial.mdf' , 
  SIZE = 3072KB , 
  MAXSIZE = UNLIMITED , 
  FILEGROWTH = 1024KB ),  
FILEGROUP SECONDARY 
  ( NAME = N'ApressFinancial_act', 
  FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ApressFinancial_act.ndf' , 
  SIZE = 3072KB , 
  MAXSIZE = UNLIMITED , 
  FILEGROWTH = 1024KB ) 
 LOG ON  
  ( NAME = N'ApressFinancial_log', 
  FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\ApressFinancial_log.ldf' , 
  SIZE = 1024KB , 
  MAXSIZE = 2048GB , 
  FILEGROWTH = 10%) 
COLLATE SQL_Latin1_General_CP1_CI_AS 
GO 