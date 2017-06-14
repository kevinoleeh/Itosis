-- PROCEDURES VOOR TESTEN
IF EXISTS(SELECT *
          FROM sysobjects
          WHERE name = '_begin')
	DROP PROCEDURE _begin
GO
CREATE PROCEDURE _begin AS BEGIN
	SET NOCOUNT ON
	IF NOT EXISTS(SELECT *
	              FROM sysobjects
	              WHERE name = 'testData')
		BEGIN
			CREATE TABLE Euratex.dbo.testData (
				Id      INT IDENTITY,
				Number  INT,
				Test    VARCHAR(50),
				Success BIT DEFAULT 0,
				Reden   VARCHAR(200),
				Message VARCHAR(200),
				CONSTRAINT PK_Test PRIMARY KEY (Number, Test)
			)
		END
	IF NOT EXISTS(SELECT *
	              FROM sysobjects
	              WHERE name = 'testCount')
		BEGIN
			CREATE TABLE Euratex.dbo.testCount (
				Totaal INT,
				Goed   INT,
				Fout   INT
			)
			INSERT INTO testCount (Totaal, Goed, Fout) VALUES (0, 0, 0)
		END
	SET IDENTITY_INSERT Euratex.dbo.PROJECT ON
	--bedrijf
	BEGIN TRY
	DECLARE @tabel VARCHAR(255) = 'BEDRIJF'
	INSERT INTO BEDRIJF
	VALUES ('HAN', 'Arnhem'),
		('EURATEX', 'Duiven');

	--project
	SET @tabel = 'PROJECT'
	INSERT INTO PROJECT (PROJECTNUMMER, BEDRIJFSNAAM, LOCATIE, PROJECTOMSCHRIJVING)
	VALUES (99999999, 'EURATEX', 'Duiven', 'Test'),
		(999999999, 'EURATEX', 'Duiven', 'Test2')
	DECLARE @projectnummer INT = (SELECT projectnummer
	                              FROM PROJECT
	                              WHERE
		                              BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	--rapport
	SET @tabel = 'RAPPORT'
	INSERT INTO RAPPORT (PROJECTNUMMER, RAPPORTNUMMER, RAPPORT_TYPE)
	VALUES (@projectnummer, 1, 'Organisatie'),
		(@projectnummer, 2, 'Visuele beoordeling'),
		(@projectnummer, 3, 'Machineveiligheid')

	--aspect
	SET @tabel = 'ASPECT'
	INSERT INTO ASPECT VALUES ('Test aspect 2')
	INSERT INTO ASPECT VALUES ('Test aspect')

	--effect
	SET @tabel = 'EFFECT'
	INSERT INTO EFFECT VALUES ('Test effect')
	INSERT INTO EFFECT VALUES ('Test effect 2'),
		('Test effect 3')

	--aspect_effect
	SET @tabel = 'ASPECT_EFFECT'
	INSERT INTO ASPECT_EFFECT VALUES ('Test aspect', 'Test effect')
	INSERT INTO ASPECT_EFFECT VALUES ('Test aspect 2', 'Test effect 2')

	--risicoregel
	SET @tabel = 'RISICOREGEL'
	INSERT INTO RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, ASPECTNAAM, EFFECTNAAM, ARBO_ONDERWERP, RISICO_OMSCHRIJVING_OF_BEVINDING, HUIDIGE_BEHEERSMAATREGEL, VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL, VOOR_ERNST_VAN_ONGEVAL, VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID, AFWIJKENDE_ACTIE_TER_UITVOERING, RESTRISICO, NA_ERNST_VAN_ONGEVAL, NA_KANS_OP_BLOOTSTELLING, NA_KANS_OP_WAARSCHIJNLIJKHEID)
	VALUES
		(@projectnummer, 1, 1, 'Test aspect', 'Test effect', 'Produce', 'plurissimum', '43189', 'e', 3.00, 10.00, 1.00,
		 'pars transit.', 'novum', 15.00, 1.00, 10.00),
		(@projectnummer, 2, 1, 'Test aspect', 'Test effect', 'Produce', 'plurissimum', '43189', 'e', 3.00, 10.00, 1.00,
		 'pars transit.', 'novum', 15.00, 1.00, 10.00),
		(@projectnummer, 1, 5, 'Test aspect', 'Test effect', 'Produce', 'plurissimum', '43189', 'e', 3.00, 10.00, 1.00,
		 'pars transit.', 'novum', 15.00, 1.00, 10.00),
		(@projectnummer, 1, 6, 'Test aspect', 'Test effect', 'Produce', 'plurissimum', '43189', 'e', 3.00, 10.00, 1.00,
		 'pars transit.', 'novum', 15.00, 1.00, 10.00)
	INSERT INTO VISUELE_BEOORDELING (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, PROCES, MACHINE_ONDERDEEL_, AFDELING)
	VALUES (@projectnummer, 2, 1, NULL, 'test', NULL)

	--plan van aanpak
	SET @tabel = 'PLAN_VAN_AANPAK'
	INSERT INTO PLAN_VAN_AANPAK
	VALUES (@projectnummer, 1, 1, 'Testpersoon', 'Testpersoon', '2099-12-12', 'PBMTEST', 'Voorlichting test',
	                        'Werkinstructie voorbeeld test', 'Tra testje',
	                        'de test die het testen heeft willen testen test de test die getest is om te testen of de test getest kan worden')
	INSERT INTO PLAN_VAN_AANPAK
	VALUES (@projectnummer, 1, 6, 'Testpersoon', 's', '2022-12-12', 's', 's', 's', 'd', 's')
	--periodieke beoordeling
	SET @tabel = 'PERIODIEKE_BEOORDELING'
	INSERT INTO PERIODIEKE_BEOORDELING
	VALUES (@projectnummer, 1, 1, '2099-11-11', 1, 'Geen opmerkingen', 'Probleem nog niet opgelost', 10)

	INSERT INTO PERIODIEKE_BEOORDELING
	VALUES (@projectnummer, 1, 1, '2099-11-12', 1, 'Geen opmerkingen2222', 'Probleem nog niet opgelost22222', 5)


	END TRY
	BEGIN CATCH
	DECLARE
	@msg NVARCHAR(4000) = ERROR_MESSAGE(),
	@line VARCHAR(3) = CONVERT(VARCHAR, ERROR_LINE())
	DECLARE @Error VARCHAR(500) = 'Fout bij invoeren van testdata in tabel %s!' +
	                              CHAR(13) + CHAR(10) +
	                              'Line ' + @line + ': ' + @msg
	RAISERROR (@Error, 16, 1, @tabel)
	END CATCH
	SET IDENTITY_INSERT Euratex.dbo.PROJECT OFF
END
SET NOCOUNT OFF
GO

IF EXISTS(SELECT *
          FROM sysobjects
          WHERE name = '_result')
	DROP PROCEDURE _result
GO
CREATE PROCEDURE _result @name VARCHAR(50), @success BIT, @reden VARCHAR(200), @msg VARCHAR(200) AS BEGIN
	IF @name = ''
		RETURN
	SET NOCOUNT ON
	DECLARE @number INT = (SELECT COUNT(*) + 1
	                       FROM testData
	                       WHERE Test = @name)
	INSERT INTO testData (Number, Test, Success, Message, Reden)
	VALUES (@number, @name, @success,
	        IIF(@msg = '', IIF(@success = 0, 'ERROR - Transactie geslaagd terwijl hij zou moeten falen!', @msg), @msg),
	        @reden);
	IF (@success = 1)
		BEGIN
			INSERT testCount (TOTAAL, GOED, FOUT) VALUES ((SELECT TOP 1 Totaal + 1
			                                               FROM testCount ORDER BY Totaal DESC), (SELECT TOP 1 Goed + 1
			                                                                 FROM testCount ORDER BY Totaal DESC), (SELECT TOP 1 Fout
			                                                                                   FROM testCount ORDER BY Totaal DESC))
		END
	IF (@success = 0)
		BEGIN
			INSERT testCount (TOTAAL, GOED, FOUT) VALUES ((SELECT TOP 1 Totaal + 1
			                                               FROM testCount ORDER BY Totaal DESC), (SELECT TOP 1 Goed
			                                                                 FROM testCount ORDER BY Totaal DESC), (SELECT TOP 1 FOUT + 1
			                                                                                   FROM testCount ORDER BY Totaal DESC))
		END
	SET NOCOUNT OFF
END
GO
IF EXISTS(SELECT *
          FROM sysobjects
          WHERE name = '_end')
	DROP PROCEDURE _end
GO
CREATE PROCEDURE _end @stop BIT AS BEGIN
	SET NOCOUNT ON
	BEGIN TRY
	DECLARE @tabel VARCHAR(255) = 'VISUELE BEOORDELING'

	DELETE FROM VISUELE_BEOORDELING
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'PERIODIEKE_BEOORDELING'
	DELETE FROM PERIODIEKE_BEOORDELING
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'PLAN_VAN_AANPAK'
	DELETE FROM PLAN_VAN_AANPAK
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'RISICOREGEL'
	DELETE FROM RISICOREGEL
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'RAPPORT'
	DELETE FROM RAPPORT
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'PROJECT'
	DELETE FROM PROJECT
	WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven'

	SET @tabel = 'BEDRIJF'
	DELETE FROM BEDRIJF
	WHERE BEDRIJFSNAAM = 'HAN' AND LOCATIE = 'Arnhem';
	DELETE FROM BEDRIJF
	WHERE BEDRIJFSNAAM = 'EURATEX';

	SET @tabel = 'ASPECT_EFFECT'
	DELETE FROM ASPECT_EFFECT
	WHERE ASPECTNAAM = 'Test aspect' AND EFFECTNAAM = 'Test effect';
	DELETE FROM ASPECT_EFFECT
	WHERE ASPECTNAAM = 'Test aspect 2' AND EFFECTNAAM = 'Test effect 2';

	SET @tabel = 'EFFECT'
	DELETE FROM EFFECT
	WHERE EFFECTNAAM = 'Test effect';
	DELETE FROM EFFECT
	WHERE EFFECTNAAM = 'Test effect 2';
	DELETE FROM EFFECT
	WHERE EFFECTNAAM = 'Test effect 3';

	SET @tabel = 'ASPECT'
	DELETE FROM ASPECT
	WHERE ASPECTNAAM = 'Test aspect';
	DELETE FROM ASPECT
	WHERE ASPECTNAAM = 'Test aspect 2';

	SET @tabel = 'PERIODIEKE_BEOORDELING_HISTORY'
	DELETE FROM PERIODIEKE_BEOORDELING_HISTORY
	WHERE RAPPORTNUMMER = 1

	SET @tabel = 'PERIODIEKE_BEOORDELING_HISTORY'
	DELETE FROM RISICOREGEL_HISTORY
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'PLAN_VAN_AANPAK_HISTORY'
	DELETE FROM PLAN_VAN_AANPAK_HISTORY
	WHERE PROJECTNUMMER = 99999999

	SET @tabel = 'MACHINEVEILIGHEID'
	DELETE FROM MACHINEVEILIGHEID
	WHERE PROJECTNUMMER = 99999999

	END TRY
	BEGIN CATCH
	RAISERROR ('Fout bij verwijderen van testdata in tabel %s!', 16, 1, @tabel)
	END CATCH
	IF @stop = 0
		RETURN
	--IF EXISTS(SELECT 'Error occurred' FROM testData WHERE Success = 0)
	SELECT
		Test + ' #' + CONVERT(VARCHAR, Number) AS Test,
		IIF(success = 1, 'OK', 'ERROR')        AS Status,
		Reden                                  AS Reden,
		message                                AS Melding
	FROM testData
	ORDER BY Success, id, Number
	SELECT
		Totaal                AS Totaal_aantal_tests,
		Goed                  AS Geslaagde_tests,
		Fout                  AS Gefaalde_tests,
		(CONVERT(FLOAT,Goed) / CONVERT(FLOAT,Totaal)) * 100 AS Percentage_geslaagde_tests,
		GETDATE()             AS Datum_getest
	FROM testCount
	WHERE Totaal = (SELECT max(totaal)
	                FROM testCount)
	DROP TABLE testData
	DROP TABLE testCount
	SET NOCOUNT OFF
END
GO
