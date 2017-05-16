-- SP_INSERT_PROJECT tests
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han';
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_PROJECT', 1, '', ''
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
	EXEC _result 'SP_INSERT_BEDRIJF', 1, '', ''
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
	EXEC _result 'SP_DELETE_BEDRIJF', 1, '', ''
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
	EXEC _result 'SP_UPDATE_BEDRIJF', 1, '', ''
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
		EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'Hai', @uLocatie =  'Hai'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_BEDRIJF', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Bedrijf met de naam Hai bestond al', @msg
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
		DECLARE @nmr INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven')
		EXEC SP_DELETE_PROJECT @nmr
	ROLLBACK TRANSACTION
	EXEC _result 'SP_DELETE_PROJECT', 1, '', ''
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
		DECLARE @nmr INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven')
		EXEC SP_UPDATE_PROJECT @nmr, 'nieuwe omschrijving'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_UPDATE_PROJECT', 1, '', ''
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
EXEC _end 1
GO