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
			Message VARCHAR(200)
			CONSTRAINT PK_Test PRIMARY KEY (Number, Test)
		)

		--TESTDATA
		BEGIN TRY
			DECLARE @tabel VARCHAR(10)
			SET @tabel = 'Passagier'
			/*INSERT INTO Passagier
				VALUES(1200, 'Kevin', 'M', '1998-04-06'),
					  (1300, 'Harm',  'M', '1993-06-06'),
					  (1400, 'Sjaak', 'M', '1984-09-17');

			SET @tabel = 'Vliegtuig'
			INSERT INTO Vliegtuig VALUES('Zweefvliegtuig');

			SET @tabel = 'Vlucht'
			INSERT Vlucht(vluchtnummer,luchthavencode,vliegtuigtype,gatecode,max_aantal_psgrs,max_totaalgewicht,max_ppgewicht,vertrektijdstip, aankomsttijdstip, maatschappijcode)
			  VALUES ( 9997,  'NZA', 'Zweefvliegtuig',  'F',   2, 300,  150, '2004-02-09 11:23', '2004-02-09 21:23', 'NZ'),
				     ( 9998,  'NZA', 'Zweefvliegtuig',  'F',   2, 300,  150, '2005-02-09 11:23', '2004-02-09 21:23', 'NZ'),
				     ( 9999, 'DUB', 'Boeing 747',  'C',  120, 2500,  20, '2004-01-30 11:30', '2004-01-30 23:30',  'KL');

			SET @tabel = 'PassagierVoorVlucht'
			INSERT INTO PassagierVoorVlucht(passagiernummer, vluchtnummer, balienummer)
				VALUES(1400, 9997, 3)
			*/
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
CREATE PROCEDURE _result @name VARCHAR(50),	@success BIT, @msg VARCHAR(200) AS BEGIN
	IF @name = ''
		RETURN
	SET NOCOUNT ON
	DECLARE @number INT = (SELECT COUNT(*)+1 FROM testData WHERE Test = @name)
	INSERT INTO testData(Number, Test, Success, Message)
		VALUES(@number, @name, @success, IIF(@msg = '', IIF(@success = 0, 'ERROR - Transactie geslaagd terwijl hij zou moeten falen!', @msg), @msg));
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
		SELECT Test + ' #'+ CONVERT(VARCHAR, Number) AS Test, IIF(success = 1, 'OK', 'ERROR') AS Status, message AS Melding FROM testData ORDER BY Success, id, Number

	BEGIN TRY
		DECLARE @tabel VARCHAR(10)
		SET @tabel = 'PassagierVoorVlucht'
		/*
		DELETE FROM PassagierVoorVlucht WHERE vluchtnummer = 9999 OR vluchtnummer = 9997 OR vluchtnummer = 9998

		SET @tabel = 'Vlucht'
		DELETE FROM Vlucht  WHERE vluchtnummer = 9999 OR vluchtnummer = 9997 OR vluchtnummer = 9998

		DELETE FROM Vliegtuig WHERE vliegtuigtype = 'zweefvliegtuig'

		SET @tabel = 'Passagier'
		DELETE FROM Passagier WHERE passagiernummer = 1200 OR passagiernummer = 1300 OR Passagier.passagiernummer = 1400
		*/
	END TRY
	BEGIN CATCH
		RAISERROR ('Fout bij verwijderen van testdata in tabel %s!', 16, 1, @tabel)
	END CATCH
	DROP TABLE testData
	SET NOCOUNT OFF
END
GO
