CREATE OR ALTER PROCEDURE SP_InformacionEnvio(@CODIGO INT) AS
	--DECLARE
BEGIN
	IF @CODIGO IN (SELECT Codigo FROM P_Nacional)
		SELECT N.Codigo, Tipo='Nacional', N.Direccion, N.Peso_gramos AS Peso, C.Nombre AS Conductor, R.Descripcion AS Ruta, CC.Placa AS [Placa del Camion],CC.Fecha AS Fecha FROM P_Nacional N
		JOIN R_Conductor RC ON RC.R_C_id=N.R_C_id
		JOIN Conductor C ON RC.RFC=C.RFC
		JOIN Ruta R ON R.Ruta_id=RC.Ruta_id
		JOIN Conductor_Camion CC ON CC.id_CC=N.id_CC
		WHERE N.Codigo=@CODIGO;
	ELSE
		BEGIN
			IF @CODIGO IN (SELECT Codigo FROM P_Internacional)
				SELECT I.Codigo, I.LineaAerea, I.Codigo_local FROM P_Internacional I;
			ELSE
				PRINT('El codigo no esta registrada para envio nacional o internacional, favor de ingresar un codigo valido.');
		END
END