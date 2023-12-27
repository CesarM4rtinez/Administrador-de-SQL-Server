DROP DATABASE IF EXISTS DEMOOSTRESS

CREATE DATABASE DEMOOSTRESS

ALTER DATABASE [DEMOOSTRESS] SET RECOVERY SIMPLE WITH NO_WAIT

USE DEMOOSTRESS
GO

-- creamos dos tablas para probar inserts
CREATE TABLE DBO.T1 
(ID UNIQUEIDENTIFIER DEFAULT NEWSEQUENTIALID() ,
 F DATETIMEOFFSET,
 C1 CHAR(20),
 C2 CHAR(20),
 C3 CHAR(20),
 C4 CHAR(20),
 C5 CHAR(20),
 C6 CHAR(20),
 C7 CHAR(20),
 C8 CHAR(20),
 C9 CHAR(20)
 )
 CREATE CLUSTERED INDEX PK1 ON DBO.T1 (ID,F)

CREATE TABLE DBO.T2 
(ID INT IDENTITY PRIMARY KEY ,
 F DATETIMEOFFSET,
 C1 CHAR(20),
 C2 CHAR(20),
 C3 CHAR(20),
 C4 CHAR(20),
 C5 CHAR(20),
 C6 CHAR(20),
 C7 CHAR(20),
 C8 CHAR(20),
 C9 CHAR(20)
 )
 

