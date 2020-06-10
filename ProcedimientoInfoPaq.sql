CREATE OR ALTER PROCEDURE SP_InformacionEnvio(@CODIGO INT) AS
	--DECLARE
BEGIN
	IF @CODIGO IN (SELECT Codigo FROM P_Nacional)
		SELECT N.Codigo, Tipo='Nacional', P.Direccion, P.Peso_gramos AS Peso, C.Nombre AS Conductor, R.Descripcion AS Ruta, RCC.Placa AS [Placa del Camion],RCC.Fecha AS Fecha FROM P_Nacional N
		JOIN Ruta_Conductor_Camion RCC ON RCC.id_RCC=N.id_RCC
		JOIN Conductor C ON RCC.RFC=C.RFC
		JOIN Ruta R ON R.Ruta_id=RCC.Ruta_id
		JOIN Paquete P ON P.Codigo=N.Codigo
		WHERE N.Codigo=@CODIGO;
	ELSE
		BEGIN
			IF @CODIGO IN (SELECT Codigo FROM P_Internacional)
				SELECT I.Codigo, Tipo='Internacional', I.LineaAerea, I.Codigo_local FROM P_Internacional I;
			ELSE
				PRINT('El codigo no esta registrada para envio nacional o internacional, favor de ingresar un codigo valido.');
		END
END