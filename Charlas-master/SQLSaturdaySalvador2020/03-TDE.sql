---------------------------
-- TDE
---------------------------

DROP DATABASE IF EXISTS DEMOTDE

CREATE DATABASE DEMOTDE
GO

USE DEMOTDE
GO

CREATE TABLE DBO.TABLA1 (ID INT IDENTITY, NOMBRE VARCHAR(255))
GO

INSERT INTO DBO.TABLA1 (NOMBRE)
SELECT NAME FROM SYS.COLUMNS 
GO

-----------------------------------
--- BACKUP DB1

BACKUP DATABASE [DEMOTDE] TO  DISK = N'C:\Tmp\demoTDE_sinTDE.bak' 
WITH NOFORMAT, INIT,  NAME = N'DEMOTDE-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--- PREPARACION TDE

USE master 
GO 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'mY_P@$$w0rd'


CREATE CERTIFICATE TDE_CERT1 
WITH SUBJECT = 'My Certificate '

USE master 
GO 
BACKUP CERTIFICATE TDE_CERT1  
TO FILE = 'C:\tmp\certificado_File.cer' 
WITH PRIVATE KEY (FILE = 'C:\tmp\certificado_Key.pvk' , 
ENCRYPTION BY PASSWORD = 'mY_P@$$w0rd' ) 
GO 


/*
 CREATE CERTIFICATE TDE_CERT1 
 FROM FILE = 'C:\certificado_File.cer'  
 WITH PRIVATE KEY (FILE = 'C:\Certificado_Key.pvk',  
 DECRYPTION BY PASSWORD = 'mY_P@$$w0rd'); 
 GO  
*/

USE DEMOTDE 
GO 
CREATE DATABASE ENCRYPTION KEY 
WITH ALGORITHM = AES_128 
ENCRYPTION BY SERVER CERTIFICATE TDE_CERT1
GO


ALTER DATABASE  DEMOTDE
SET ENCRYPTION ON

BACKUP DATABASE [DEMOTDE] TO  DISK = N'C:\Tmp\demoTDE_conTDE.bak' 
WITH NOFORMAT, INIT,  NAME = N'DEMOTDE-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

----- server restore
USE master 
GO 
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'mY_P@$$w0rd'


 CREATE CERTIFICATE TDE_CERT1 
 FROM FILE = 'C:\tmp\certificado_File.cer'
 WITH PRIVATE KEY (FILE = 'C:\Certificado_Key.pvk',  
 DECRYPTION BY PASSWORD = 'mY_P@$$w0rd'); 
 GO  

-- limpiar

drop dataBASE DEMOTDE
DROP CERTIFICATE TDE_CERT1