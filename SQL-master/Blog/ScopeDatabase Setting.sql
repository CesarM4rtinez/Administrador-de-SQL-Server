/* SCOPE DATABASE SETTING SQL 2016
   WWW.TRIGGERDB.COM
   MAXI ACCOTTO 
*/

-----------------------------------------------
-- CONFIGURACION MAXDOP A NIVEL BASE DE DATOS
-----------------------------------------------

-- REVISAMOS LA CONFIGURACION DEL SERVIDOR

SELECT C.NAME,
       C.DESCRIPTION,
	   C.VALUE_IN_USE 
	   FROM SYS.CONFIGURATIONS C
WHERE NAME IN ('MAX DEGREE OF PARALLELISM','COST THRESHOLD FOR PARALLELISM')

DBCC SETCPUWEIGHT(10000) -- PARA LA DEMO NO USAR NUNCA EN PRODUCCION
GO
-- QUERY TO TEST
use AdventureWorks2014 
go

SELECT
    COUNT_BIG(*) 
FROM PRODUCTION.PRODUCT AS P 
LEFT JOIN PRODUCTION.TRANSACTIONHISTORY AS TH ON 
    P.PRODUCTID = TH.PRODUCTID


USE [AdventureWorks2014]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 1;

SELECT
    COUNT_BIG(*) 
FROM PRODUCTION.PRODUCT AS P 
LEFT JOIN PRODUCTION.TRANSACTIONHISTORY AS TH ON 
    P.PRODUCTID = TH.PRODUCTID

USE [AdventureWorks2014]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;

----------------
--- CE LEGACY SIN CAMBIAR EL MODO DE COMPATIBILIDAD
-----------------

SELECT
    COUNT_BIG(*) 
FROM PRODUCTION.PRODUCT AS P 
LEFT JOIN PRODUCTION.TRANSACTIONHISTORY AS TH ON 
    P.PRODUCTID = TH.PRODUCTID

USE [AdventureWorks2014]
GO
ALTER DATABASE SCOPED CONFIGURATION 
SET LEGACY_CARDINALITY_ESTIMATION = ON;
GO

SELECT
    COUNT_BIG(*) 
FROM PRODUCTION.PRODUCT AS P 
LEFT JOIN PRODUCTION.TRANSACTIONHISTORY AS TH ON 
    P.PRODUCTID = TH.PRODUCTID

USE [AdventureWorks2014]
GO
ALTER DATABASE SCOPED CONFIGURATION 
SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

---------------------------------------
-- COMO DETERMINAR LA CONFIGURACION DE LA BASE
---------------------------------------
USE AdventureWorks2014
GO

SELECT * FROM SYS.DATABASE_SCOPED_CONFIGURATIONS

-------------------------------------------------
-- LIMPIAR CACHE SOLO DE LA BASE DE DATOS
-------------------------------------------------
USE AdventureWorks2014
GO
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;

