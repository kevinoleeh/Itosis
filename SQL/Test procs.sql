-- PROCEDURES VOOR TESTEN
IF EXISTS (SELECT * FROM sysobjects WHERE name = '_begin')
	DROP PROCEDURE _begin
GO
CREATE PROCEDURE _begin AS BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS(SELECT * FROM sysobjects WHERE name = 'testData') BEGIN
		CREATE TABLE Euratex.dbo.testData(
			Id      INT IDENTITY,
			Number  INT,
			Test    VARCHAR(50),
			Success BIT DEFAULT 0,
			Reden   VARCHAR(200),
			Message VARCHAR(200),
			CONSTRAINT PK_Test PRIMARY KEY (Number, Test)
		)

		--TESTDATA
		BEGIN TRY
			DECLARE @tabel VARCHAR(255) = 'BEDRIJF'
			INSERT INTO BEDRIJF
				VALUES('HAN','Arnhem'),
				('EURATEX','Duiven');
			SET @tabel = 'PROJECT'
			INSERT INTO PROJECT
				VALUES('EURATEX','Duiven','Test')
		END TRY
		BEGIN CATCH
			DECLARE
		        @msg NVARCHAR(4000) = ERROR_MESSAGE(),
		        @line VARCHAR(3) = CONVERT(VARCHAR, ERROR_LINE())
			DECLARE @Error VARCHAR(500) = 'Fout bij invoeren van testdata in tabel %s!' +
			                              CHAR(13)+CHAR(10) +
			                              'Line '+@line+': '+@msg
			RAISERROR (@Error, 16, 1, @tabel)
		END CATCH
	END
	SET NOCOUNT OFF
END
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = '_result')
	DROP PROCEDURE _result
GO
CREATE PROCEDURE _result @name VARCHAR(50),	@success BIT, @reden VARCHAR(200), @msg VARCHAR(200)  AS BEGIN
	IF @name = ''
		RETURN
	SET NOCOUNT ON
	DECLARE @number INT = (SELECT COUNT(*)+1 FROM testData WHERE Test = @name)
	INSERT INTO testData(Number, Test, Success, Message, Reden)
		VALUES(@number, @name, @success, IIF(@msg = '', IIF(@success = 0, 'ERROR - Transactie geslaagd terwijl hij zou moeten falen!', @msg), @msg), @reden);
	SET NOCOUNT OFF
END
GO
IF EXISTS (SELECT * FROM sysobjects WHERE name = '_end')
	DROP PROCEDURE _end
GO
CREATE PROCEDURE _end @stop BIT AS BEGIN
	SET NOCOUNT ON
	IF @stop = 0
		RETURN
	--IF EXISTS(SELECT 'Error occurred' FROM testData WHERE Success = 0)
		SELECT Test + ' #'+ CONVERT(VARCHAR, Number) AS Test, IIF(success = 1, 'OK', 'ERROR') AS Status, Reden AS Reden, message AS Melding FROM testData ORDER BY Success, id, Number
	BEGIN TRY
		DECLARE @tabel VARCHAR(255) = 'PROJECT'
		DELETE FROM PROJECT
		WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven'
		SET @tabel = 'BEDRIJF'
		DELETE FROM BEDRIJF
		WHERE BEDRIJFSNAAM = 'HAN' AND LOCATIE = 'Arnhem';
		DELETE FROM BEDRIJF
		WHERE BEDRIJFSNAAM = 'EURATEX';

	END TRY
	BEGIN CATCH
		RAISERROR ('Fout bij verwijderen van testdata in tabel %s!', 16, 1, @tabel)
	END CATCH
	DROP TABLE testData
	SET NOCOUNT OFF
END
GO
