--1.	Crear un disparador para la tabla Nacional y otro para la tabla internacional
--para garantizar las reglas del negocio(un envió solo puede ser de un solo tipo)
CREATE OR ALTER TRIGGER verificarUnicidadNal
ON P_Nacional
FOR INSERT
AS
	Declare @CodigoI NUMERIC(5)
	SET @CodigoI = (SELECT Codigo FROM inserted)
	IF (@CodigoI in (Select Codigo FROM P_Internacional	))
BEGIN
	RAISERROR ('EL Codigo indicado ya esxiste para un paquete internacional',16,1)
	ROLLBACK TRANSACTION
END
GO
	INSERT INTO P_Internacional(Codigo) VALUES (1)
	SELECT * FROM P_Internacional
	SELECT * FROM P_Nacional
	INSERT INTO P_Nacional(Codigo) Values(1)
	SELECT * FROM P_Nacional
GO
CREATE OR ALTER TRIGGER verificarUnicidadInt
ON P_Internacional
FOR INSERT
AS
	Declare @CodigoI NUMERIC(5)
	SET @CodigoI = (SELECT Codigo FROM inserted)
	IF (@CodigoI in (Select Codigo FROM P_Nacional	))
BEGIN
	RAISERROR ('EL Codigo indicado ya esxiste para un paquete nacional',16,1)
	ROLLBACK TRANSACTION
END
GO
	INSERT INTO P_Nacional(Codigo) Values(2)
	SELECT * FROM P_Nacional
	SELECT * FROM P_Internacional
	INSERT INTO P_Internacional(Codigo) VALUES (2)
	SELECT * FROM P_Internacional