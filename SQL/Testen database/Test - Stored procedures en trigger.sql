  -- SP_INSERT_PERIODIEKE_BEOORDELING test (success)
  EXEC _begin
  BEGIN TRY
  DECLARE @projectnummer INT = (SELECT projectnummer
                                FROM PROJECT
                                WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
  BEGIN TRANSACTION test
  EXEC SP_INSERT_PERIODIEKE_BEOORDELING
    @PROJECTNUMMER = @projectnummer,
    @RAPPORTNUMMER = 1,
    @REGELNUMMER = 1,
    @DATUM_BEOORDELING = '2098-11-11',
    @INSPECTIE_IS_DE_ACTIE_UITGEVOERD = 1,
    @OPMERKING_STAND_VAN_ZAKEN = 'Geen opmerking',
    @STAND_VAN_ZAKEN = 'Het pva is nog niet toegepast',
    @SCORE = 10
  ROLLBACK TRANSACTION
  EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Periodieke beoordeling is toegevoegd', ''
  END TRY
  BEGIN CATCH
  ROLLBACK TRANSACTION
  DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
  EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 0, '', @msg
  END CATCH
  EXEC _end 0
  GO



-- SP_UPDATE_PERIODIEKE_BEOORDELING test (success)
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_PERIODIEKE_BEOORDELING
	@PROJECTNUMMER = @projectnummer,
	@RAPPORTNUMMER = 1,
	@REGELNUMMER = 1,
	@DATUM_BEOORDELING_OUD = '2099-11-12',
	@DATUM_BEOORDELING_NIEUW = '2099-12-13',
	@INSPECTIE_IS_DE_ACTIE_UITGEVOERD = 1,
	@OPMERKING_STAND_VAN_ZAKEN = 'Geen opmerking',
	@STAND_VAN_ZAKEN = 'Het pva is nog niet toegepast',
	@SCORE = 10
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Periodieke beoordeling is geüpdatet', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 0, '', @msg
END CATCH
EXEC _end 0
GO


  -- SP_UPDATE_PERIODIEKE_BEOORDELING test (success)
  EXEC _begin
  BEGIN TRY
    DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
    BEGIN TRANSACTION test
      EXEC SP_UPDATE_PERIODIEKE_BEOORDELING
       @PROJECTNUMMER = @projectnummer,
      @RAPPORTNUMMER = 1,
      @REGELNUMMER = 1,
      @DATUM_BEOORDELING_OUD = '2099-11-12',
      @DATUM_BEOORDELING_NIEUW = '2099-12-13',
      @INSPECTIE_IS_DE_ACTIE_UITGEVOERD = 1,
      @OPMERKING_STAND_VAN_ZAKEN = 'Geen opmerking',
      @STAND_VAN_ZAKEN = 'Het pva is nog niet toegepast',
      @SCORE = 10
    ROLLBACK TRANSACTION
    EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Periodieke beoordeling is geüpdatet', ''
  END TRY
  BEGIN CATCH    ROLLBACK TRANSACTION
    DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
    EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 0, '',@msg
  END CATCH
  EXEC _end 0
  GO

  -- SP_INSERT_PLAN_VAN_AANPAK test
EXEC _begin
BEGIN TRY
	DECLARE @projectnummer INT = (SELECT projectnummer FROM PROJECT WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
	BEGIN TRANSACTION test
		EXEC SP_INSERT_PLAN_VAN_AANPAK
		@PROJECTNUMMER = @projectnummer,
    @RAPPORTNUMMER = 2,
    @REGELNUMMER = 1,
    @UITGEVOERD_DOOR = 'Testpersoon',
    @EINDVERANTWOORDELIJKE = 'Testpersoon 2',
    @DATUM_GEREED_GEPLAND = '12-12-2017',
    @PBM ='Dit is een PBM',
    @VOORLICHTING = 'Voorlichting etc.',
    @WERKINSTRUCTIE_PROCEDURE = 'Werkinstructies',
    @TRA = 'Taak risico analyse',
    @CONTRACT_LIJST_  = 'Controlelijst e.d.'
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_PLAN_VAN_AANPAK', 1, 'Pva is toegevoegd', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_PLAN_VAN_AANPAK', 0, '',@msg
END CATCH
EXEC _end 0
GO



-- SP_UPDATE_PLAN_VAN_AANPAK test
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_PLAN_VAN_AANPAK
	@PROJECTNUMMER = @projectnummer,
	@RAPPORTNUMMER = 1,
	@REGELNUMMER = 1,
	@UITGEVOERD_DOOR = 'Testertje',
	@EINDVERANTWOORDELIJKE = 'Testertje 2',
	@DATUM_GEREED_GEPLAND = '2099-12-12',
	@PBM = 'Dit is een pbmmmm',
	@VOORLICHTING = 'Voorlichting o.i.d.',
	@WERKINSTRUCTIE_PROCEDURE = 'Workinstructions',
	@TRA = 'Task risk analysing',
	@CONTRACT_LIJST_ = 'Checklist'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Pva is geüpdatet', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 0, '', @msg
END CATCH
EXEC _end 0
GO


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
EXEC _result 'SP_INSERT_PROJECT', 0, '', @msg
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
EXEC _result 'SP_DELETE_BEDRIJF', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Testen update bedrijf
-- succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
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
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Nijmegen', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
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
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
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
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Nijmegen', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
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
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'Euratex', @uLocatie = 'Duiven'
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
EXEC SP_DELETE_PROJECT 99999999
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
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
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
-- Testen insert raport bij project
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
EXEC SP_INSERT_RAPPORT @nmr, 'Organisatie'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_RAPPORT', 1, 'Succesvol toegevoegd rapport', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_RAPPORT', 0, '', @msg
END CATCH
EXEC _end 0
GO
-- Testen update project
-- Succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
	2,
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
EXEC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
	1,
	'Test aspect',
	'Test effect',
	'Nieuw test',
	'Test',
	'Test',
	'Test',
	'Test',
	'Test',
	'',
	'',
	'',
	1,
	1,
	1,
	1,
	1,
	1
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Niet voldaan aan de visuele beoordeling br', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Niet voldaan aan de visuele beoordeling br', @msg
END CATCH
EXEC _end 0
GO
-- Insert visuele risicoregel tests
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, '', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
	'Test aspect',
	'Test effect',
	'Test',
	'Test',
	'Test',
	'Test',
	'Test',
	'Test',
	'',
	'',
	'Test',
	1,
	1,
	1,
	1,
	1,
	1
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Een van de drie moest ingevuld zijn', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	99999,
	2,
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Projectnummer bestaat niet.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Rapportnummer bestaat niet.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Aspect bestaat niet.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Effect bestaat niet.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Aspect hoort niet bij effect.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 0
GO
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@projectnummer,
	2,
	'Test aspect',
	'Test effect',
	'Test',
	'Test',
	'Test',
	'Test',
	'Test',
	'Test',
	'',
	'',
	'',
	1,
	1,
	1,
	1,
	1,
	1
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Niet aan de visuele beoordeling br voldaan.', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Niet aan de visuele beoordeling br voldaan.', @msg
END CATCH
EXEC _end 0
GO
-- Testen van delete rapport
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_DELETE_RAPPORT @RAPPORTNUMMER = 3, @PROJECTNUMMER = @projectnummer
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_RAPPORT', 1, 'Succes', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_RAPPORT', 0, 'Onverwacht', @msg
END CATCH
EXEC _end 0
GO
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_DELETE_RAPPORT @RAPPORTNUMMER = 2, @PROJECTNUMMER = @projectnummer
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_RAPPORT', 0, 'Zit een risicoregel bij', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_RAPPORT', 1, 'Zit een risicoregel bij', @msg
END CATCH
EXEC _end 0
GO

--succes insert aspect_effect
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect',
	'Test effect 1231232'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Juiste insert', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Juiste insert', @msg
END CATCH
EXEC _end 0
GO

--fail duplicate key
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect',
	'Test effect'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Effect bestaat al duplicate key', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Effect bestaat al duplicate key', @msg
END CATCH
EXEC _end 0
GO

-- fail onbestaand aspect voor effect
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect2',
	'Test effect'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Moet aan bestaand aspect toevoegen', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Moet aan bestaand aspect toevoegen', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT_EFFECT
	'Test aspect',
	'Test effect5'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT', 0, 'Moet een bestaand Effect betreffen', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT', 1, 'Moet een bestaand Effect betreffen', @msg
END CATCH
EXEC _end 0
GO

--succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT_EFFECT
	'Test aspect',--D
	'Test effect 2'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT', 1, 'Juiste insert', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT', 0, 'Juiste insert', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_DELETE_ASPECT
	'Test aspect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 1, 'Juiste delete zonder effect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 0, 'Juiste delete zonder effect', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_DELETE_ASPECT
	'Test aspect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 1, 'Juiste delete met effect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 0, 'Juiste delete met effect', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_DELETE_Aspect
	'Test aspect'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 0, 'Nog in gebruik bij risicoregel', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 1, 'Nog in gebruik bij risicoregel', @msg
END CATCH
EXEC _end 0
GO


EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
	'Test aspect2',
	'Test effect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 1, 'Juiste delete van effect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 0, 'Juiste delete van effect', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT
	'Test aspect'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSPERT_ASPECT', 0, 'Aspect bestaat al', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 1, 'Aspect bestaat al', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_INSERT_ASPECT
	'Test aspect123'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSPERT_ASPECT', 1, 'Juiste insert Aspect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 0, 'Juiste insert Aspect', @msg
END CATCH
EXEC _end 0
GO

  EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_UPDATE_ASPECT
	'Test aspect123',
	'Test test test'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_ASPECT', 1, 'Juiste insert Aspect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_ASPECT', 0, 'Juiste insert Aspect', @msg
END CATCH
EXEC _end 0
GO


  EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXEC SP_UPDATE_EFFECT
	'Test effect 3',
		'Test effect test'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSPERT_ASPECT', 1, 'Juiste insert Aspect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 0, 'Juiste insert Aspect', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL
	@projectnummer,
	3,
	3,
	4,
	'Test aspect',
	'Test effect',
	3,
	4,
	1,
	2,
	3,
	4,
	5,
	3,
	2,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	0,
	1,
	1,
	1,
	0,
	0,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Goede insert', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
EXEC SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL
	@projectnummer,
	2,
	3,
	4,
	'Test aspect',
	'Test effect',
	3,
	4,
	1,
	2,
	3,
	4,
	5,
	3,
	2,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	0,
	1,
	1,
	1,
	0,
	0,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Verkeerd rapport type', @msg
END CATCH
EXEC _end 0

/* trigger tests*/


/*PERIODIEKE_BEOORDELING*/
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 DELETE FROM PERIODIEKE_BEOORDELING WHERE rapportnummer = 1 and regelnummer = 1 AND OPMERKING_STAND_VAN_ZAKEN ='Geen opmerkingen2222'

	 IF NOT EXISTS(select * from PERIODIEKE_BEOORDELING_HISTORY where rapportnummer = 1 and regelnummer = 1 AND OPMERKING_STAND_VAN_ZAKEN ='Geen opmerkingen2222')
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_PERIODIEKE_BEOORDELING_HISTORY', 1, 'History tabel geupdate', 'on delete'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_PERIODIEKE_BEOORDELING_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 UPDATE  PERIODIEKE_BEOORDELING SET OPMERKING_STAND_VAN_ZAKEN = 'test' WHERE rapportnummer = 1 and regelnummer = 1 AND OPMERKING_STAND_VAN_ZAKEN ='Geen opmerkingen2222'

	 IF NOT EXISTS(select * from PERIODIEKE_BEOORDELING_HISTORY where rapportnummer = 1 and regelnummer = 1 AND OPMERKING_STAND_VAN_ZAKEN ='Geen opmerkingen2222')
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_PERIODIEKE_BEOORDELING_HISTORY', 1, 'History tabel geupdate', 'on update'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_PERIODIEKE_BEOORDELING_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

/*RISICOREGEL*/
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 DELETE FROM RISICOREGEL WHERE rapportnummer = 1 and regelnummer = 5 AND RESTRISICO ='novum'

	 IF NOT EXISTS(select * from RISICOREGEL_HISTORY where rapportnummer = 1 and regelnummer = 5 AND RESTRISICO = 'novum' )
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_RISICOREGEL_HISTORY', 1, 'History tabel geupdate', 'on delete'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'TRG_RISICOREGEL_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	UPDATE RISICOREGEL SET RESTRISICO = 'test' WHERE rapportnummer = 1 and regelnummer = 5 AND RESTRISICO ='novum'

	 IF NOT EXISTS(select * from RISICOREGEL_HISTORY where rapportnummer = 1 and regelnummer = 5 AND RESTRISICO = 'novum' )
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_RISICOREGEL_HISTORY', 1, 'History tabel geupdate', 'on update'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'TRG_RISICOREGEL_HISTORY', 0, '', @msg
END CATCH
EXEC _end 0
GO


/*VISUELE BEOORDELING*/

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 DELETE FROM VISUELE_BEOORDELING WHERE rapportnummer = 2 and regelnummer = 1
	 IF NOT EXISTS(select * from VISUELE_BEOORDELING_HISTORY where rapportnummer = 2 and regelnummer = 1)
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_VISUELE_BEOORDELING', 1, 'History tabel geupdate', 'on delete'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'TRG_VISUELE_BEOORDELING', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 UPDATE VISUELE_BEOORDELING SET MACHINE_ONDERDEEL_ = 'test123' WHERE rapportnummer = 2 and regelnummer = 1

	 IF NOT EXISTS(select * from VISUELE_BEOORDELING_HISTORY where rapportnummer = 2 and regelnummer = 1 )
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_VISUELE_BEOORDELING', 1, 'History tabel geupdate', 'on update'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION

EXEC _result 'TRG_VISUELE_BEOORDELING', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

/*PLAN VAN AANPAK*/

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	 DELETE FROM PLAN_VAN_AANPAK WHERE rapportnummer = 1 and regelnummer = 6 AND UITGEVOERD_DOOR = 'Testpersoon'
	 IF NOT EXISTS(select * from PLAN_VAN_AANPAK_HISTORY where rapportnummer = 1 and regelnummer = 6)
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_PLAN_VAN_AANPAK_HISTORY', 1, 'History tabel geupdate', 'on delete'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_PLAN_VAN_AANPAK_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test

	 UPDATE PLAN_VAN_AANPAK SET UITGEVOERD_DOOR = 'test123' WHERE rapportnummer = 1 and regelnummer = 6

	 IF NOT EXISTS(select * from PLAN_VAN_AANPAK_HISTORY where rapportnummer = 1 and regelnummer = 6 )
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_PLAN_VAN_AANPAK_HISTORY', 1, 'History tabel geupdate', 'on update'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_PLAN_VAN_AANPAK_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

/*MACHINE VEILIGHEID*/

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

	 EXEC SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL @projectnummer,3,	3,	4,	'Test aspect',	'Test effect',	3,	4,	1,	2,	3,	4,	5,	3,	2,	1,	1	,1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	1,	1,	1,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1
	 DELETE FROM MACHINEVEILIGHEID WHERE rapportnummer = 3 and PROJECTNUMMER = @projectnummer

	 IF NOT EXISTS(select * from MACHINEVEILIGHEID_HISTORY where rapportnummer = 3 and PROJECTNUMMER = @projectnummer)
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_MACHINEVEILIGHEID_HISTORY', 1, 'History tabel geupdate', 'on delete'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_MACHINEVEILIGHEID_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

	EXEC SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL @projectnummer,3,	3,	4,	'Test aspect',	'Test effect',	3,	4,	1,	2,	3,	4,	5,	3,	2,	1,	1	,1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	0,	1,	1,	1,	0,	0,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1


	 UPDATE MACHINEVEILIGHEID SET PID = 2 WHERE rapportnummer = 3 AND PROJECTNUMMER = @Projectnummer

	 IF NOT EXISTS(select * from MACHINEVEILIGHEID_HISTORY where rapportnummer = 3 AND PROJECTNUMMER = @projectnummer )
	 RAISERROR ('', -- Message text.
               16, -- Severity.
               1 -- State.
               );
ROLLBACK TRANSACTION
EXEC _result 'TRG_MACHINEVEILIGHEID_HISTORY', 1, 'History tabel geupdate', 'on update'
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
EXEC _result 'TRG_MACHINEVEILIGHEID_HISTORY', 0, '', 'History tabel niet geupdate'
END CATCH
EXEC _end 1
GO
