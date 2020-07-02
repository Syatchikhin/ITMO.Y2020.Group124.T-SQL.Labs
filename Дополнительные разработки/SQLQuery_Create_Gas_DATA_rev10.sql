--Программа расчета свойств газовой смеси----
--Автор Сятчихин М.Ю.   Все права сохранены--
--ИТМО 2020 гр.124/4  Т-SQL------------------

--DROP DATABASE GasDatabase1
--if db_id('[GasDatabase2]') is null
--BEGIN
	CREATE DATABASE GasDatabase
	ON
	PRIMARY
	 (NAME = myGas,
	 FILENAME = 'C:\Temp\myGas.mdf',
	 SIZE = 8MB,
	 MAXSIZE = 16MB,
	 FILEGROWTH = 8MB)

	 LOG ON 
	 (NAME = myGasLog,
	 FILENAME = 'C:\Temp\myGas.idf',
	 SIZE = 1MB,
	 MAXSIZE = 8MB,
	 FILEGROWTH = 4MB)
GO
--END

USE GasDatabase
GO

--CREATE SCHEMA Media;
--GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Media')
BEGIN
	EXEC('CREATE SCHEMA Media')
END

IF  OBJECT_ID (N'Media.Elements') IS NOT NULL 
	BEGIN
			DROP TABLE Media.Elements
	END
GO


CREATE TABLE Media.Elements 
(elementName Char(2) PRIMARY KEY NOT NULL,
elementAtomicWeight Decimal(9,6) NOT NULL)
GO

INSERT INTO Media.Elements
VALUES 
('C', 12.0108),
('H', 1.00797),
('N', 14.0067),
('O', 15.9994),
('S', 32.064),
('Ar', 39.948),
('Ne', 20.1797),
('He', 4.002602),
('Kr', 83.8),
('Xe', 131.29)
GO

SELECT *
FROM Media.Elements ORDER BY elementAtomicWeight
GO

IF  OBJECT_ID (N'Media.Components') IS NOT NULL 
	BEGIN
			DROP TABLE Media.Components
	END
GO

CREATE TABLE Media.Components
(componentNumber SmallInt NOT NULL,
componentName Char(25) PRIMARY KEY NOT NULL,
componentNameRu Char(25) NOT NULL,
componentFormula Char(10) NOT NULL,
componentMolarWeignt Decimal(9,6) NOT NULL)
GO

 --FILL GASES--
INSERT INTO Media.Components
VALUES 
(01, 'Methane','Метан',					'CH4', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')+ 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*4),

(02,'Ethane','Этан',					'C2H6', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*2 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*6 ),

(03, 'Propane',	'Пропан',				'C3H8', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*3 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*8 ),

(04, 'Butane','Бутан',					'C4H10_1', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*4 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*10 ),

(05, 'iso-Butane','изо-Бутан',			'C4H10_2', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*4 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*10 ),

(06, 'Pentane',	'Пентан',				'C5H12_1', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*5 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*12 ),

(07, 'iso-Pentane','изо-Пентан',		'C5H12_2', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*5 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*12 ),

(08, 'neo-Pentane','нео-Пентан',		'C5H12_3', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*5 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*12 ),

(09, 'Hexane','Гексан',					'C6H14', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*6 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*14 ),

(10, 'Heptane',	'Гептан',				'C7H16', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')*7 + 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*16 ),

(11, 'Nitrogen','Азот',					'N2', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'N')*2 ),

(12, 'Oxygen','Кислород',				'O2', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'O')*2 ),

(13, 'CarbonDioxide','Диоксид_углерода','CO2', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')+
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'O')*2 ),

(14, 'CarbonMonoxide','Оксид_углерода',	'CO', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')+
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'O')),

(15, 'Methanol','Метанол',				'CH3OH', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'C')+
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*4 +
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'O')),

(16, 'HydrogenSulfide','Сероводород',	'H2S', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*2 +
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'S')),

(17, 'Water','Вода',					'H2O', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'H')*2 +
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'O')),

(18, 'Argone','Аргон',					'Ar', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'Ar')),

(19, 'Helium','Гелий',					'He', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'He')),

(20, 'Krypton',	'Криптон',				'Kr', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'Kr')),

(21, 'Xenon','Ксенон',					'Xe', 
(SELECT elementAtomicWeight FROM Media.Elements WHERE elementName = 'Xe'))

GO

SELECT * 
FROM Media.Components ORDER BY componentNumber
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'Gas')
BEGIN
	EXEC('CREATE SCHEMA Gas')
END

IF  OBJECT_ID (N'Gas.Composition') IS NOT NULL 
	BEGIN
			DROP TABLE Gas.Composition
	END
GO

CREATE TABLE Gas.Composition
(compositionName Char(25) NOT NULL,
componentFormula Char(10)  NOT NULL,
componentVolume Decimal(9,6) NOT NULL,
PRIMARY KEY (compositionName, componentFormula))
GO

INSERT INTO Gas.Composition
VALUES 
('Air', 'N2', 78.09),
('Air', 'O2', 20.95),
('Air', 'Ar', 0.93),
('Air', 'CO2', 0.03),
('Kazatchya.Gas', 'CH4', 97.5275),
('Kazatchya.Gas', 'C2H6', 0.8797),
('Kazatchya.Gas', 'C3H8', 0.1397),
('Kazatchya.Gas', 'C4H10_1', 0.0248),
('Kazatchya.Gas', 'C4H10_2', 0.0149),
('Kazatchya.Gas', 'C5H12_2', 0.018),
('Kazatchya.Gas', 'C5H12_3', 0.0203),
('Kazatchya.Gas', 'C6H14', 0.0222),
('Kazatchya.Gas', 'C7H16', 0.0126),
('Kazatchya.Gas', 'N2', 0.9303),
('Kazatchya.Gas', 'CO2', 0.41)
GO

SELECT * FROM Gas.Composition ORDER BY compositionName , componentVolume DESC


IF  OBJECT_ID (N'Gas.Properties') IS NOT NULL 
	BEGIN
			DROP TABLE Gas.Properties
	END
GO


--drop TABLE Gas.Details

CREATE TABLE Gas.Properties
(gasName Char(25) PRIMARY KEY NOT NULL,
gasSize Smallint  NULL,
gasDencity Decimal(6,3) NULL,
gasConstant Decimal(6,3) NULL)
GO

INSERT INTO Gas.Properties
VALUES 
('Air', 0, 0, 0),
('Kazatchya.Gas', 0, 0, 0)
GO

SELECT * FROM Gas.Properties


IF  OBJECT_ID (N'Gas.AirComposition') IS NOT NULL 
	BEGIN
			DROP VIEW Gas.AirComposition
	END
GO

--создаю VIEW с объединением двух таблиц Gas.Composition и Media.Components
--при этом у них есть общий столбец componentFormula, GC и MC = псевдонимы таблиц
CREATE VIEW Gas.AirComposition AS
SELECT GC.compositionName, MC.componentNameRu, MC.componentName, MC.componentFormula, 
MC.componentMolarWeignt , GC.componentVolume 
FROM  Gas.Composition AS GC
JOIN  Media.Components AS MC
ON (GC.componentFormula = MC.componentFormula)
WHERE compositionName = 'Air'
GO

--SELECT * FROM Gas.AirComposition ORDER BY componentVolume DESC
--GO

--drop view Gas.AirComposition

IF  OBJECT_ID (N'Gas.KazatchyaGasComposition') IS NOT NULL 
	BEGIN
			DROP VIEW Gas.KazatchyaGasComposition
	END
GO

CREATE VIEW Gas.KazatchyaGasComposition AS
SELECT GC.compositionName, MC.componentNameRu, MC.componentName, MC.componentFormula, 
MC.componentMolarWeignt , GC.componentVolume 
FROM  Gas.Composition AS GC
JOIN  Media.Components AS MC
ON (GC.componentFormula = MC.componentFormula)
WHERE compositionName = 'Kazatchya.Gas'
GO

--SELECT * FROM Gas.KazatchyaGasComposition  ORDER BY componentVolume DESC
--GO

--drop view Gas.KazatchyaGasComposition 

--PROCEDURES--

--описание процедуры--
USE GasDatabase;
GO

CREATE PROCEDURE gas.mixtureCalculation 
		 @mixtureName varchar(20)
AS
     --начало процедуры

		IF  OBJECT_ID (N'Gas.#Calculation') IS NOT NULL 
			BEGIN
					DROP TABLE Gas.#Calculation
			END;
		

		CREATE TABLE Gas.#Calculation
		(compositionName Char(25) NOT NULL,
		componentFormula Char(10)  NOT NULL,
		componentMolarWeight Decimal(6,3) NULL,
		componentVolume Decimal(6,4) NOT NULL,
		componentVolumeIn1000 As componentVolume *10,
		--componentMoles  AS componentVolume * 10/22.41396954,
		componentMoles  Decimal(6,3) NULL,
		componentWeight Decimal(6,3) NULL,
		componentPercentWeight Decimal(6,3) NULL,
		componentR Decimal(6,3) NULL,
		componentMiRi Decimal(9,3) NULL,
		PRIMARY KEY (compositionName, componentFormula))
		
		--GO

		INSERT into Gas.#Calculation (compositionName, componentFormula, componentMolarWeight, componentVolume)
		SELECT compositionName, GC.componentFormula,  MC.componentMolarWeignt, componentVolume
		FROM Gas.Composition As Gc
		INNER JOIN 
		 Media.Components AS MC
		ON (GC.componentFormula = MC.componentFormula)
		WHERE compositionName = @mixtureName

		UPDATE Gas.#Calculation
		SET componentMoles = componentVolumeIn1000 / 22.41396954;

		UPDATE gas.Properties 
		SET gasSize=(SELECT COUNT(*) FROM Gas.#Calculation)
		WHERE gasName = @mixtureName

		UPDATE Gas.#Calculation
		SET componentWeight = componentMoles * componentMolarWeight;
		
		DECLARE @fullWeight decimal (8,3);
		SELECT  @fullWeight = SUM(ComponentWeight) 
		FROM Gas.#Calculation 
		
		--print @fullWeight;
		--GO

		UPDATE gas.Properties 
		SET gasDencity=@fullWeight/1000
		WHERE gasName = @mixtureName

		UPDATE Gas.#Calculation
		SET componentPercentWeight = (ComponentWeight / @fullWeight ) * 100;

		UPDATE Gas.#Calculation
		SET componentR =   8314.462618 / componentMolarWeight;

		UPDATE Gas.#Calculation
		SET componentMiRi = componentPercentWeight * componentR;
		

		DECLARE @mixtureR decimal (9,3);
		SELECT  @mixtureR = SUM(ComponentMiRi) 
		FROM Gas.#Calculation 

		UPDATE gas.Properties 
		SET gasConstant=@mixtureR/100
		WHERE gasName = @mixtureName

		DROP TABLE Gas.#Calculation
	 --конец процедуры

GO

--выполнение процедур--
USE GasDatabase;
GO
--выполнение процедуры для природного газа--
EXEC Gas.mixtureCalculation  @mixtureName = 'Kazatchya.Gas' ;
GO

--выполнение процедуры для воздуха--
EXEC Gas.mixtureCalculation  @mixtureName = 'Air' ;
GO

--просмотр временной таблицы--(если не удалена)--
SELECT* FROM Gas.#Calculation ORDER BY componentVolume DESC
GO

--просмотр результатов расчета--
SELECT * FROM gas.Properties 

--DROP TABLE Gas.#Calculation

--SET 0 --
UPDATE gas.Properties 
SET gasSize =0,
	gasDencity = 0,
    gasConstant = 0
WHERE gasName = 'Kazatchya.Gas'
GO


UPDATE gas.Properties 
SET gasSize =0,
	gasDencity = 0,
    gasConstant = 0
WHERE gasName = 'Air'
GO

--DROP PROCEDURE gas.mixtureCalculation