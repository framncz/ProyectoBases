USE [PROYECTO_FINAL];
GO
CREATE OR ALTER TRIGGER INSERT_NACIONAL
ON P_Nacional
FOR INSERT
AS
	DECLARE @CODIGO INT;
	SET @CODIGO = (SELECT Codigo FROM INSERTED)
	IF @CODIGO IN (SELECT Codigo FROM P_Internacional)
BEGIN
	RAISERROR('El Codigo insertado ya existe para un envio Internacional, favor de usar otro.',16,1)
	ROLLBACK TRANSACTION
END
GO
CREATE OR ALTER TRIGGER INSERT_INTERNACIONAL
ON P_Internacional
FOR INSERT
AS
	DECLARE @CODIGO INT;
	SET @CODIGO = (SELECT Codigo FROM INSERTED)
	IF @CODIGO IN (SELECT Codigo FROM P_Nacional)
BEGIN
	RAISERROR('El Codigo insertado ya existe para un envio Nacional, favor de usar otro.',16,1)
	ROLLBACK TRANSACTION
END