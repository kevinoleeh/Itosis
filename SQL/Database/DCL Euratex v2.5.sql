USE master
GO

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'BeheerderLogin')
DROP LOGIN BeheerderLogin

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'GebruikerLogin')
DROP LOGIN GebruikerLogin

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'StagiairLogin')
DROP LOGIN StagiairLogin


IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'EenStagiair')
DROP LOGIN EenStagiair

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'TweeStagiair')
DROP LOGIN TweeStagiair

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'StagiairLogin')
DROP LOGIN StagiairLogin





USE master
GO




/*==============================================================*/
/* LOGIN							                            */
/*==============================================================*/
CREATE LOGIN BeheerderLogin WITH PASSWORD = 'wachtwoord'
CREATE LOGIN GebruikerLogin WITH PASSWORD = 'wachtwoord'
CREATE LOGIN StagiairLogin WITH PASSWORD = 'wachtwoord'

/*==============================================================*/
/* USER								                            */
/*==============================================================*/
CREATE USER BeheerderGebruiker FOR LOGIN BeheerderLogin WITH DEFAULT_SCHEMA = EURATEX
CREATE USER GebruikerGebruiker FOR LOGIN GebruikerLogin WITH DEFAULT_SCHEMA = EURATEX
CREATE USER StagiairGebruiker FOR LOGIN StagiairLogin WITH DEFAULT_SCHEMA = EURATEX

/*==============================================================*/
/* ROLLEN							                            */
/*==============================================================*/
CREATE ROLE BEHEERDER
CREATE ROLE GEBRUIKER
CREATE ROLE STAGIAIR


/*==============================================================*/
/* TOEWIJZEN ROLLEN					                            */
/*==============================================================*/


EXEC sp_addrolemember 'BEHEERDER', 'BeheerderGebruiker'
EXEC sp_addrolemember 'GEBRUIKER', 'GebruikerGebruiker'
EXEC sp_addrolemember 'STAGIAIR', 'StagiairGebruiker'


/*==============================================================*/
/* BEHEERDER				                            		*/
/*==============================================================*/

/*================================*/
/* RECHTEN TOT ALLE SP'S BEDRIJF  */
/*================================*/
GRANT EXECUTE TO BEHEERDER

/*================================*/
/* Tabel BEDRIJF				  */
/*================================*/
GRANT SELECT ON BEDRIJF TO BEHEERDER
GRANT INSERT ON BEDRIJF TO BEHEERDER
GRANT UPDATE ON BEDRIJF TO BEHEERDER
GRANT DELETE ON BEDRIJF TO BEHEERDER

/*================================*/
/* Tabel PROJECT				  */
/*================================*/
GRANT SELECT ON PROJECT TO BEHEERDER
GRANT INSERT ON PROJECT TO BEHEERDER
GRANT UPDATE ON PROJECT TO BEHEERDER
GRANT DELETE ON PROJECT TO BEHEERDER

/*================================*/
/* Tabel RAPPORT				  */
/*================================*/
GRANT SELECT ON RAPPORT TO BEHEERDER
GRANT INSERT ON RAPPORT TO BEHEERDER
GRANT UPDATE ON RAPPORT TO BEHEERDER
GRANT DELETE ON RAPPORT TO BEHEERDER

/*================================*/
/* Tabel RISICOREGEL			  */
/*================================*/
GRANT SELECT ON RISICOREGEL TO BEHEERDER
GRANT INSERT ON RISICOREGEL TO BEHEERDER
GRANT UPDATE ON RISICOREGEL TO BEHEERDER
GRANT DELETE ON RISICOREGEL TO BEHEERDER

/*================================*/
/* Tabel ASPECT			 		  */
/*================================*/
GRANT SELECT ON ASPECT TO BEHEERDER
GRANT INSERT ON ASPECT TO BEHEERDER
GRANT UPDATE ON ASPECT TO BEHEERDER
GRANT DELETE ON ASPECT TO BEHEERDER

/*================================*/
/* Tabel EFFECT			 		  */
/*================================*/
GRANT SELECT ON EFFECT TO BEHEERDER
GRANT INSERT ON EFFECT TO BEHEERDER
GRANT UPDATE ON EFFECT TO BEHEERDER
GRANT DELETE ON EFFECT TO BEHEERDER


/*================================*/
/* Tabel ASPECT_EFFECT	 		  */
/*================================*/
GRANT SELECT ON ASPECT_EFFECT TO BEHEERDER
GRANT INSERT ON ASPECT_EFFECT TO BEHEERDER
GRANT UPDATE ON ASPECT_EFFECT TO BEHEERDER
GRANT DELETE ON ASPECT_EFFECT TO BEHEERDER


/*================================*/
/* Tabel VISUELE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING TO BEHEERDER
GRANT INSERT ON VISUELE_BEOORDELING TO BEHEERDER
GRANT UPDATE ON VISUELE_BEOORDELING TO BEHEERDER
GRANT DELETE ON VISUELE_BEOORDELING TO BEHEERDER

/*================================*/
/* Tabel AFBEELDING				  */
/*================================*/
GRANT SELECT ON AFBEELDING TO BEHEERDER
GRANT INSERT ON AFBEELDING TO BEHEERDER
GRANT UPDATE ON AFBEELDING TO BEHEERDER
GRANT DELETE ON AFBEELDING TO BEHEERDER

/*================================*/
/* Tabel PLAN_VAN_AANPAK		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK TO BEHEERDER
GRANT INSERT ON PLAN_VAN_AANPAK TO BEHEERDER
GRANT UPDATE ON PLAN_VAN_AANPAK TO BEHEERDER
GRANT DELETE ON PLAN_VAN_AANPAK TO BEHEERDER

/*================================*/
/* Tabel PERIODIEKE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT INSERT ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT UPDATE ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT DELETE ON PERIODIEKE_BEOORDELING TO BEHEERDER



/*==============================================================*/
/* GEBRUIKER				                            		*/
/*==============================================================*/


/*================================*/
/* RECHTEN TOT ALLE SP'S		  */
/*================================*/
GRANT EXECUTE TO GEBRUIKER
REVOKE EXECUTE ON SP_DELETE_BEDRIJF TO GEBRUIKER
REVOKE EXECUTE ON SP_DELETE_PROJECT TO GEBRUIKER

/*================================*/
/* Tabel BEDRIJF				  */
/*================================*/
GRANT SELECT ON BEDRIJF TO GEBRUIKER
GRANT INSERT ON BEDRIJF TO GEBRUIKER
GRANT UPDATE ON BEDRIJF TO GEBRUIKER


/*================================*/
/* Tabel PROJECT				  */
/*================================*/
GRANT SELECT ON PROJECT TO GEBRUIKER
GRANT INSERT ON PROJECT TO GEBRUIKER
GRANT UPDATE ON PROJECT TO GEBRUIKER


/*================================*/
/* Tabel RAPPORT				  */
/*================================*/
GRANT SELECT ON RAPPORT TO GEBRUIKER
GRANT INSERT ON RAPPORT TO GEBRUIKER
GRANT UPDATE ON RAPPORT TO GEBRUIKER


/*================================*/
/* Tabel RISICOREGEL			  */
/*================================*/
GRANT SELECT ON RISICOREGEL TO GEBRUIKER
GRANT INSERT ON RISICOREGEL TO GEBRUIKER
GRANT UPDATE ON RISICOREGEL TO GEBRUIKER
GRANT DELETE ON RISICOREGEL TO GEBRUIKER

/*================================*/
/* Tabel ASPECT			 		  */
/*================================*/
GRANT SELECT ON ASPECT TO GEBRUIKER
GRANT INSERT ON ASPECT TO GEBRUIKER
GRANT UPDATE ON ASPECT TO GEBRUIKER
GRANT DELETE ON ASPECT TO GEBRUIKER

/*================================*/
/* Tabel EFFECT			 		  */
/*================================*/
GRANT SELECT ON EFFECT TO GEBRUIKER
GRANT INSERT ON EFFECT TO GEBRUIKER
GRANT UPDATE ON EFFECT TO GEBRUIKER
GRANT DELETE ON EFFECT TO GEBRUIKER


/*================================*/
/* Tabel ASPECT_EFFECT	 		  */
/*================================*/
GRANT SELECT ON ASPECT_EFFECT TO BEHEERDER
GRANT INSERT ON ASPECT_EFFECT TO BEHEERDER
GRANT UPDATE ON ASPECT_EFFECT TO BEHEERDER


/*================================*/
/* Tabel VISUELE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT INSERT ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT UPDATE ON VISUELE_BEOORDELING TO GEBRUIKER


/*================================*/
/* Tabel AFBEELDING				  */
/*================================*/
GRANT SELECT ON AFBEELDING TO GEBRUIKER
GRANT INSERT ON AFBEELDING TO GEBRUIKER
GRANT UPDATE ON AFBEELDING TO GEBRUIKER
GRANT DELETE ON AFBEELDING TO GEBRUIKER

/*================================*/
/* Tabel PLAN_VAN_AANPAK		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK TO GEBRUIKER
GRANT INSERT ON PLAN_VAN_AANPAK TO GEBRUIKER
GRANT UPDATE ON PLAN_VAN_AANPAK TO GEBRUIKER
GRANT DELETE ON PLAN_VAN_AANPAK TO GEBRUIKER


/*================================*/
/* Tabel PERIODIEKE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT INSERT ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT UPDATE ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT DELETE ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT SELECT ON PERIODIEKE_BEOORDELING TO GEBRUIKER






/*==============================================================*/
/* STAGIAIR				                            		    */
/*==============================================================*/


/*================================*/
/* RECHTEN TOT ALLE SP'S		  */
/*================================*/
/*=============*/
/* GRANT       */
/*=============*/
GRANT EXECUTE TO STAGIAIR

/*=============*/
/* REVOKE      */
/*=============*/
REVOKE EXECUTE ON SP_DELETE_BEDRIJF TO STAGIAIR
REVOKE EXECUTE ON SP_UPDATE_BEDRIJF TO STAGIAIR
REVOKE EXECUTE ON SP_INSERT_BEDRIJF TO STAGIAIR


REVOKE EXECUTE ON SP_INSERT_PROJECT TO STAGIAIR
REVOKE EXECUTE ON SP_UPDATE_PROJECT TO STAGIAIR
REVOKE EXECUTE ON SP_DELETE_PROJECT TO STAGIAIR


REVOKE EXECUTE ON SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT TO STAGIAIR
REVOKE EXECUTE ON SP_INSERT_EFFECT TO STAGIAIR
REVOKE EXECUTE ON SP_UPDATE_EFFECT TO STAGIAIR



REVOKE EXECUTE ON SP_INSERT_RAPPORT TO STAGIAIR


REVOKE EXECUTE ON SP_DELETE_ASPECT TO STAGIAIR
REVOKE EXECUTE ON SP_INSERT_ASPECT TO STAGIAIR
REVOKE EXECUTE ON SP_UPDATE_ASPECT TO STAGIAIR







/*================================*/
/* Tabel BEDRIJF				  */
/*================================*/
GRANT SELECT ON BEDRIJF TO STAGIAIR


/*================================*/
/* Tabel PROJECT				  */
/*================================*/
GRANT SELECT ON PROJECT TO STAGIAIR


/*================================*/
/* Tabel RAPPORT				  */
/*================================*/
GRANT SELECT ON RAPPORT TO STAGIAIR


/*================================*/
/* Tabel RISICOREGEL			  */
/*================================*/
GRANT SELECT ON RISICOREGEL TO STAGIAIR
GRANT INSERT ON RISICOREGEL TO STAGIAIR
GRANT UPDATE ON RISICOREGEL TO STAGIAIR


/*================================*/
/* Tabel ASPECT			 		  */
/*================================*/
GRANT SELECT ON ASPECT TO STAGIAIR

/*================================*/
/* Tabel EFFECT			 		  */
/*================================*/
GRANT SELECT ON EFFECT TO STAGIAIR


/*================================*/
/* Tabel ASPECT_EFFECT	 		  */
/*================================*/
GRANT SELECT ON ASPECT_EFFECT TO BEHEERDER


/*================================*/
/* Tabel VISUELE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING TO STAGIAIR
GRANT INSERT ON VISUELE_BEOORDELING TO STAGIAIR
GRANT UPDATE ON VISUELE_BEOORDELING TO STAGIAIR


/*================================*/
/* Tabel AFBEELDING				  */
/*================================*/
GRANT SELECT ON AFBEELDING TO STAGIAIR
GRANT INSERT ON AFBEELDING TO STAGIAIR
GRANT UPDATE ON AFBEELDING TO STAGIAIR


/*================================*/
/* Tabel PLAN_VAN_AANPAK		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK TO STAGIAIR
GRANT INSERT ON PLAN_VAN_AANPAK TO STAGIAIR
GRANT UPDATE ON PLAN_VAN_AANPAK TO STAGIAIR


/*================================*/
/* Tabel PERIODIEKE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING TO STAGIAIR
GRANT INSERT ON PERIODIEKE_BEOORDELING TO STAGIAIR
GRANT UPDATE ON PERIODIEKE_BEOORDELING TO STAGIAIR
