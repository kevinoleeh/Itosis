-- SP_INSERT_PROJECT tests
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han';
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_PROJECT', 1, 'Project bij HAN Arnhem toegevoegd', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_PROJECT', 0, '',@msg
END CATCH
EXEC _end 0
GO
-- Fail op fk
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han'
		EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HANMMMMM', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_PROJECT', 0, ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_PROJECT', 1, 'Er bestaat geen bedrijf met de naam HANMMMM', @msg
END CATCH
EXEC _end 0
GO
-- insertBedrijf test
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Gelre'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Nieuw bedrijf van de HAN op andere locatie', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_BEDRIJF', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Testen delete bedrijf
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_DELETE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_DELETE_BEDRIJF', 1, 'HAN Arnhem verwijdert', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_DELETE_BEDRIJF', 0,'', @msg
END CATCH
EXEC _end 0
GO
-- Testen update bedrijf
-- succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie =  'Nijmegen'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'HAN Arnhem locatie verandert naar HAN Nijmegen', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_BEDRIJF', 0, '', @msg
END CATCH
EXEC _end 0
GO
--  update kan niet worden uitgevoerd, geeft succes geen oorspronkelijke waardes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Nijmegen', @uBedrijfsnaam = 'HAN', @uLocatie =  'Nijmegen'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Geen te updaten waarde, geeft geen error', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_BEDRIJF', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- update kan niet worden uitgevoerd, gaat over een primary key heen
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'Euratex', @uLocatie =  'Duiven'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_BEDRIJF', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Bedrijf met de naam Euratex bestaat al', @msg
END CATCH
EXEC _end 0
GO
-- Testen delete project
-- Failure want er zijn nog rapporten bij project
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_DELETE_PROJECT 1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_DELETE_PROJECT', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_DELETE_PROJECT', 1, 'Failure want er zijn nog rapporten bij project', @msg
END CATCH
EXEC _end 0
GO
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @nmr INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
		EXEC SP_DELETE_PROJECT @nmr
	ROLLBACK TRANSACTION
	EXEC _result 'SP_DELETE_PROJECT', 1, 'Project verwijderd zonder rapporten', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_DELETE_PROJECT', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Testen update project
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @nmr INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
		EXEC SP_UPDATE_PROJECT @nmr, 'nieuwe omschrijving'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_PROJECT', 1, 'Nieuwe omschrijving voor project met rapporten', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_PROJECT', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Succes op project met rapporten
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_PROJECT 1, 'nieuwe omschrijving'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_PROJECT', 1, 'Project met rapporten volgens cascading rules', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_PROJECT', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Update organisatie risicoregel
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Test effect',
			'Nieuw test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Standaard succes update van organisatie risicoregel', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			99999,
			1,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Projectnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			99999,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			99999,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Regelnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Bestaat niet',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Aspect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Bestaat niet',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Effect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Test effect 2',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Aspect hoort niet bij effect.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 0
GO
-- Insert organisatie risicoregel tests
EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			99999,
			1,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Projectnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			99999,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Bestaat niet',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Aspect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Bestaat niet',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Effect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Test effect 2',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Aspect hoort niet bij effect.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 0
GO
-- Tst visuele beoordeling
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Test effect',
			'Nieuw test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Standaard succes update van organisatie risicoregel', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			99999,
			1,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Projectnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			99999,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			1,
			99999,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Regelnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Bestaat niet',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Aspect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Bestaat niet',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Effect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
			@projectnummer,
			1,
			1,
			'Test aspect',
			'Test effect 2',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Aspect hoort niet bij effect.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 0
GO
-- Insert organisatie risicoregel tests
EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Test effect',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			99999,
			1,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Projectnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			99999,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Bestaat niet',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Aspect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Bestaat niet',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Effect bestaat niet.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			@projectnummer,
			1,
			'Test aspect',
			'Test effect 2',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Aspect hoort niet bij effect.', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 1
GO
