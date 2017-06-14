
/*=================================================================================================================================================*/
/* STAGIAIRE TESTS                    							                  							                  							                               */
/*=================================================================================================================================================*/
REVERT
/*==============================================================*/
/* --4.6.1 Use Case: Beheren bedrijven						   */
/*==============================================================*/

-- INSERT BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_INSERT_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Gelre'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_BEDRIJF', 0, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_DELETE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_BEDRIJF', 0, 'HAN Arnhem verwijdert', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_BEDRIJF', 0, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO



/*==============================================================*/
/* 4.6.2 Use Case: Beheren projecten    						            */
/*==============================================================*/
-- INSERT PROJECT tests
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han';
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_PROJECT', 0, 'Project bij HAN Arnhem toegevoegd', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE PROJECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
EXEC SP_DELETE_PROJECT @nmr
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_PROJECT', 0, 'Project verwijderd zonder rapporten', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE PROJECT
-- Succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
EXEC SP_UPDATE_PROJECT @nmr, 'nieuwe omschrijving'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_PROJECT', 0, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.3 Use Case: Beheer aspect				        		            */
/*==============================================================*/
-- INSERT ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_INSERT_ASPECT
	'Test aspect123'
ROLLBACK TRANSACTION

EXEC _result 'SP_INSPERT_ASPECT', 0, 'Juiste insert Aspect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

--DELETE ASPECT

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_DELETE_ASPECT
	'Test aspect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 0, 'Juiste delete zonder effect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.4 Use Case: Beheer effecten aspecten	  			            */
/*==============================================================*/
-- INSERT EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect',
	'Test effect 1231232'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
EXEC SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
	'Test aspect2',
	'Test effect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 0, 'Juiste delete van effect', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 1, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.5 Use Case: Beheren rapporten      	  			            */
/*==============================================================*/
-- TESTSCRIPT BESTAAT NOG NIET!


/*==============================================================*/
/* 4.6.6 Use Case: Beheren risico regel (ORAGANISATIE)          */
/*==============================================================*/
--INSERT ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--UPDATE ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--INSERT VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--UPDATE VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--INSERT MACHINEVEILIGHEID
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


  -- UPDATE PLAN VAN AANPAK test
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


/*==============================================================*/
/* 4.6.9 Use Case: Beheren periodieke beoordeling 	            */
/*==============================================================*/

  -- INSERT PERIODIEKE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 0, 'Geen rechten om deze EXEC uit te voeren als stagiair', @msg
END CATCH
REVERT
EXEC _end 0
GO

  -- UPDATE PERIODIEKE BEOORDELING test (success)
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'StagiairLogin';
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
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als stagiair', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


/*=================================================================================================================================================*/
/* GEBRUIKER TESTS                    							                  							                  							                               */
/*=================================================================================================================================================*/
REVERT
/*==============================================================*/
/* --4.6.1 Use Case: Beheren bedrijven						   */
/*==============================================================*/

-- INSERT BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_INSERT_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Gelre'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_DELETE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren als gebruiker', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO



/*==============================================================*/
/* 4.6.2 Use Case: Beheren projecten    						            */
/*==============================================================*/
-- INSERT PROJECT tests
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han';
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE PROJECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
EXEC SP_DELETE_PROJECT @nmr
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren als gebruiker', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE PROJECT
-- Succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
EXEC SP_UPDATE_PROJECT @nmr, 'nieuwe omschrijving'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.3 Use Case: Beheer aspect				        		            */
/*==============================================================*/
-- INSERT ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_INSERT_ASPECT
	'Test aspect123'
ROLLBACK TRANSACTION

EXEC _result 'SP_INSPERT_ASPECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 0, 'Rechten om deze EXEC uit te voeren als gebruiker', @msg
END CATCH
REVERT
EXEC _end 0
GO

--DELETE ASPECT

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_DELETE_ASPECT
	'Test aspect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 0, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.4 Use Case: Beheer effecten aspecten	  			            */
/*==============================================================*/
-- INSERT EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect',
	'Test effect 1231232'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Rechten om deze EXEC uit te voeren als gebruiker', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
EXEC SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
	'Test aspect2',
	'Test effect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 0, 'Rechten om deze EXEC uit te voeren als gebruiker', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.5 Use Case: Beheren rapporten      	  			            */
/*==============================================================*/
-- TESTSCRIPT BESTAAT NOG NIET!


/*==============================================================*/
/* 4.6.6 Use Case: Beheren risico regel (ORAGANISATIE)          */
/*==============================================================*/
--INSERT ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--UPDATE ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--INSERT VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--UPDATE VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--INSERT MACHINEVEILIGHEID
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--UPDATE MACHINEVEILIGHEID NOG NIET AANWEZIG
/*==============================================================*/
/* 4.6.8 Use Case: Beheren plan van aanpak					            */
/*==============================================================*/

  -- UPDATE PLAN VAN AANPAK test
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


/*==============================================================*/
/* 4.6.9 Use Case: Beheren periodieke beoordeling 	            */
/*==============================================================*/

  -- INSERT PERIODIEKE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

  -- UPDATE PERIODIEKE BEOORDELING test (success)
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'GebruikerLogin';
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
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*=================================================================================================================================================*/
/* BEHEERDER TESTS                    							                  							                  							                               */
/*=================================================================================================================================================*/
REVERT
/*==============================================================*/
/* --4.6.1 Use Case: Beheren bedrijven						   */
/*==============================================================*/

-- INSERT BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_INSERT_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Gelre'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_DELETE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE BEDRIJF (success)
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_UPDATE_BEDRIJF @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @uBedrijfsnaam = 'HAN', @uLocatie = 'Nijmegen'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_BEDRIJF', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO



/*==============================================================*/
/* 4.6.2 Use Case: Beheren projecten    						            */
/*==============================================================*/
-- INSERT PROJECT tests
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_INSERT_PROJECT @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han';
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE PROJECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'TEST2')
EXEC SP_DELETE_PROJECT @nmr
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- UPDATE PROJECT
-- Succes
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
DECLARE @nmr INT = (SELECT projectnummer
                    FROM PROJECT
                    WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
EXEC SP_UPDATE_PROJECT @nmr, 'nieuwe omschrijving'
ROLLBACK TRANSACTION
EXEC _result 'SP_UPDATE_PROJECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PROJECT', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.3 Use Case: Beheer aspect				        		            */
/*==============================================================*/
-- INSERT ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_INSERT_ASPECT
	'Test aspect123'
ROLLBACK TRANSACTION

EXEC _result 'SP_INSPERT_ASPECT', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSPERT_ASPECT', 0, 'Rechten om deze EXEC uit te voeren als beheerder', @msg
END CATCH
REVERT
EXEC _end 0
GO

--DELETE ASPECT

EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_DELETE_ASPECT
	'Test aspect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_ASPECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_ASPECT', 0, 'Rechten om deze EXEC uit te voeren als beheerder', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.4 Use Case: Beheer effecten aspecten	  			            */
/*==============================================================*/
-- INSERT EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_INSERT_ASPECT_EFFECT_EFFECT
	'Test aspect',
	'Test effect 1231232'
ROLLBACK TRANSACTION
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ASPECT_EFFECT_EFFECT', 0, 'Rechten om deze EXEC uit te voeren als beheerder', @msg
END CATCH
REVERT
EXEC _end 0
GO

-- DELETE EFFECT BIJ ASPECT
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
EXEC SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
	'Test aspect2',
	'Test effect2'
ROLLBACK TRANSACTION
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 0, 'Rechten om deze EXEC uit te voeren als beheerder', @msg
END CATCH
REVERT
EXEC _end 0
GO

/*==============================================================*/
/* 4.6.5 Use Case: Beheren rapporten      	  			            */
/*==============================================================*/
-- TESTSCRIPT BESTAAT NOG NIET!


/*==============================================================*/
/* 4.6.6 Use Case: Beheren risico regel (ORAGANISATIE)          */
/*==============================================================*/
--INSERT ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--UPDATE ORGANISATIEREGEL
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_ORGANISATIE_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--INSERT VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--UPDATE VISUELE BEOORDELING
EXEC _begin
BEGIN TRY
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als gebruiker', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


--INSERT MACHINEVEILIGHEID
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test
	EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

--UPDATE MACHINEVEILIGHEID NOG NIET AANWEZIG
/*==============================================================*/
/* 4.6.8 Use Case: Beheren plan van aanpak					            */
/*==============================================================*/


  -- UPDATE PLAN VAN AANPAK test
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PLAN_VAN_AANPAK', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO


/*==============================================================*/
/* 4.6.9 Use Case: Beheren periodieke beoordeling 	            */
/*==============================================================*/

  -- INSERT PERIODIEKE BEOORDELING
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_INSERT_PERIODIEKE_BEOORDELING', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 0
GO

  -- UPDATE PERIODIEKE BEOORDELING test (success)
EXEC _begin
BEGIN TRY
DECLARE @projectnummer INT = (SELECT projectnummer
                              FROM PROJECT
                              WHERE BEDRIJFSNAAM = 'EURATEX' AND LOCATIE = 'Duiven' AND PROJECTOMSCHRIJVING = 'Test')
BEGIN TRANSACTION test

EXECUTE AS LOGIN = N'BeheerderLogin';
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
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Rechten om deze EXEC uit te voeren als beheerder', ''
END TRY
BEGIN CATCH
ROLLBACK TRANSACTION
DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
EXEC _result 'SP_UPDATE_PERIODIEKE_BEOORDELING', 1, 'Geen rechten om deze EXEC uit te voeren', @msg
END CATCH
REVERT
EXEC _end 1
GO
