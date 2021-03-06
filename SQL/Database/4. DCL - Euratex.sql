USE master
GO



/*==============================================================*/
/* LOGIN							                            */
/*==============================================================*/
IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'BeheerderLogin')
DROP LOGIN BeheerderLogin

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'GebruikerLogin')
DROP LOGIN GebruikerLogin

IF EXISTS (SELECT * FROM sys.syslogins WHERE name = N'StagiairLogin')
DROP LOGIN StagiairLogin

GO

CREATE LOGIN BeheerderLogin WITH PASSWORD = 'wachtwoord1!413F'
CREATE LOGIN GebruikerLogin WITH PASSWORD = 'wachtwoord1!413F'
CREATE LOGIN StagiairLogin WITH PASSWORD = 'wachtwoord1!413F'


USE Euratex

GO
/*==============================================================*/
/* USER								                            */
/*==============================================================*/
IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'BeheerderLogin')
DROP USER BeheerderLogin

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'GebruikerLogin')
DROP USER GebruikerLogin

IF  EXISTS (SELECT * FROM sys.database_principals WHERE name = N'StagiairLogin')
DROP USER StagiairLogin



CREATE USER BeheerderLogin FOR LOGIN BeheerderLogin WITH DEFAULT_SCHEMA = EURATEX
CREATE USER GebruikerLogin FOR LOGIN GebruikerLogin WITH DEFAULT_SCHEMA = EURATEX
CREATE USER StagiairLogin FOR LOGIN StagiairLogin WITH DEFAULT_SCHEMA = EURATEX



/*==============================================================*/
/* ROLLEN							                            */
/*==============================================================*/
IF DATABASE_PRINCIPAL_ID('BEHEERDER') IS NULL
CREATE ROLE BEHEERDER
IF DATABASE_PRINCIPAL_ID('GEBRUIKER') IS NULL
CREATE ROLE GEBRUIKER
IF DATABASE_PRINCIPAL_ID('STAGIAIR') IS NULL
CREATE ROLE STAGIAIR

go
/*==============================================================*/
/* TOEWIJZEN ROLLEN					                            */
/*==============================================================*/


EXEC sp_addrolemember 'BEHEERDER', 'BeheerderLogin'
EXEC sp_addrolemember 'GEBRUIKER', 'GebruikerLogin'
EXEC sp_addrolemember 'STAGIAIR', 'StagiairLogin'


/*==============================================================*/
/* BEHEERDER				                            		*/
/*==============================================================*/

/*================================*/
/* RECHTEN TOT ALLE SP'S BEDRIJF  */
/*================================*/
GRANT EXECUTE TO BEHEERDER

/*================================*/
/* Tabel BEDRIJF		          */
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

/*================================*/
/* Tabel RAPPORT				  */
/*================================*/
GRANT SELECT ON RAPPORT TO BEHEERDER
GRANT INSERT ON RAPPORT TO BEHEERDER
GRANT UPDATE ON RAPPORT TO BEHEERDER
GRANT DELETE ON RAPPORT TO BEHEERDER

/*================================*/
/* Tabel RISICOREGEL		      */
/*================================*/
GRANT SELECT ON RISICOREGEL TO BEHEERDER
GRANT INSERT ON RISICOREGEL TO BEHEERDER
GRANT UPDATE ON RISICOREGEL TO BEHEERDER
GRANT DELETE ON RISICOREGEL TO BEHEERDER

/*================================*/
/* Tabel VISUELE_BEOORDELING      */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING TO BEHEERDER
GRANT INSERT ON VISUELE_BEOORDELING TO BEHEERDER
GRANT UPDATE ON VISUELE_BEOORDELING TO BEHEERDER
GRANT DELETE ON VISUELE_BEOORDELING TO BEHEERDER

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
GRANT SELECT ON VISUELE_BEOORDELING_HISTORY TO BEHEERDER
GRANT INSERT ON VISUELE_BEOORDELING_HISTORY TO BEHEERDER
GRANT UPDATE ON VISUELE_BEOORDELING_HISTORY TO BEHEERDER
GRANT DELETE ON VISUELE_BEOORDELING_HISTORY TO BEHEERDER


/*================================*/
/* Tabel MACHINEVEILIGHEID	      */
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID TO BEHEERDER
GRANT INSERT ON MACHINEVEILIGHEID TO BEHEERDER
GRANT UPDATE ON MACHINEVEILIGHEID TO BEHEERDER
GRANT DELETE ON MACHINEVEILIGHEID TO BEHEERDER

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


/*================================*/
/* Tabel PERIODIEKE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT INSERT ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT UPDATE ON PERIODIEKE_BEOORDELING TO BEHEERDER
GRANT DELETE ON PERIODIEKE_BEOORDELING TO BEHEERDER

/*================================*/
/* Tabel PERIODIEKE_BEOORDELING_HISTORY	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING_HISTORY TO BEHEERDER

/*================================*/
/* Tabel RISICOREGEL_HISTORY	  */
/*================================*/
GRANT SELECT ON RISICOREGEL_HISTORY TO BEHEERDER

/*================================*/
/* Tabel VISUELE_BEOORDELING_HISTORY*/
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING_HISTORY TO BEHEERDER

/*================================*/
/* Tabel PLAN_VAN_AANPAK_HISTORY		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK_HISTORY TO BEHEERDER

/*================================*/
/* Tabel MACHINEVEILIGHEID_HISTORY*/
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID_HISTORY TO BEHEERDER
GRANT INSERT ON MACHINEVEILIGHEID_HISTORY TO BEHEERDER
GRANT UPDATE ON MACHINEVEILIGHEID_HISTORY TO BEHEERDER
GRANT DELETE ON MACHINEVEILIGHEID_HISTORY TO BEHEERDER


/*================================*/
/* Tabel RAPPORT_TYPE     	  */
/*================================*/
GRANT SELECT ON RAPPORT_TYPE TO BEHEERDER


/*==============================================================*/
/* GEBRUIKER				                            		            */
/*==============================================================*/


/*================================*/
/* RECHTEN TOT ALLE SP'S		  */
/*================================*/
GRANT EXECUTE TO GEBRUIKER
DENY EXECUTE ON SP_DELETE_BEDRIJF TO GEBRUIKER
DENY EXECUTE ON SP_DELETE_PROJECT TO GEBRUIKER

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

/*================================*/
/* Tabel EFFECT			 		  */
/*================================*/
GRANT SELECT ON EFFECT TO GEBRUIKER
GRANT INSERT ON EFFECT TO GEBRUIKER
GRANT UPDATE ON EFFECT TO GEBRUIKER

/*================================*/
/* Tabel ASPECT_EFFECT	 		  */
/*================================*/
GRANT SELECT ON ASPECT_EFFECT TO GEBRUIKER
GRANT INSERT ON ASPECT_EFFECT TO GEBRUIKER
GRANT UPDATE ON ASPECT_EFFECT TO GEBRUIKER

/*================================*/
/* Tabel VISUELE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT INSERT ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT UPDATE ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT DELETE ON VISUELE_BEOORDELING TO GEBRUIKER

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

/*================================*/
/* Tabel PERIODIEKE_BEOORDELING	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT INSERT ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT UPDATE ON PERIODIEKE_BEOORDELING TO GEBRUIKER
GRANT DELETE ON PERIODIEKE_BEOORDELING TO GEBRUIKER


/*================================*/
/* Tabel MACHINEVEILIGHEID	  */
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID TO GEBRUIKER
GRANT INSERT ON MACHINEVEILIGHEID TO GEBRUIKER
GRANT UPDATE ON MACHINEVEILIGHEID TO GEBRUIKER


/*================================*/
/* Tabel RAPPORT_TYPE     	  */
/*================================*/
GRANT SELECT ON RAPPORT_TYPE TO GEBRUIKER


/*================================*/
/* Tabel MACHINEVEILIGHEID_HISTORY	  */
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID_HISTORY TO GEBRUIKER

/*================================*/
/* Tabel RISICOREGEL_HISTORY			  */
/*================================*/
GRANT SELECT ON RISICOREGEL_HISTORY TO GEBRUIKER

/*================================*/
/* Tabel PLAN_VAN_AANPAK_HISTORY		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK_HISTORY TO GEBRUIKER

/*================================*/
/* Tabel VISUELE_BEOORDELING_HISTORY	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING_HISTORY TO GEBRUIKER

/*================================*/
/* Tabel PERIODIEKE_BEOORDELING_HISTORY	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING_HISTORY TO GEBRUIKER





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
/* DENY      */
/*=============*/
DENY EXECUTE ON SP_DELETE_BEDRIJF TO STAGIAIR
DENY EXECUTE ON SP_UPDATE_BEDRIJF TO STAGIAIR
DENY EXECUTE ON SP_INSERT_BEDRIJF TO STAGIAIR


DENY EXECUTE ON SP_INSERT_PROJECT TO STAGIAIR
DENY EXECUTE ON SP_UPDATE_PROJECT TO STAGIAIR
DENY EXECUTE ON SP_DELETE_PROJECT TO STAGIAIR


DENY EXECUTE ON SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT TO STAGIAIR
DENY EXECUTE ON SP_INSERT_EFFECT TO STAGIAIR
DENY EXECUTE ON SP_UPDATE_EFFECT TO STAGIAIR



DENY EXECUTE ON SP_INSERT_RAPPORT TO STAGIAIR
DENY EXECUTE ON SP_DELETE_RAPPORT TO STAGIAIR

DENY EXECUTE ON SP_DELETE_ASPECT TO STAGIAIR
DENY EXECUTE ON SP_INSERT_ASPECT TO STAGIAIR
DENY EXECUTE ON SP_UPDATE_ASPECT TO STAGIAIR

DENY EXECUTE ON SP_INSERT_ASPECT_EFFECT TO STAGIAIR
DENY EXECUTE ON SP_INSERT_ASPECT_EFFECT_EFFECT TO STAGIAIR





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
GRANT SELECT ON ASPECT_EFFECT TO STAGIAIR


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

/*================================*/
/* Tabel MACHINEVEILIGHEID			  */
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID TO STAGIAIR
GRANT INSERT ON MACHINEVEILIGHEID TO STAGIAIR
GRANT UPDATE ON MACHINEVEILIGHEID TO STAGIAIR

/*================================*/
/* Tabel PERIODIEKE_BEOORDELING_HISTORY	  */
/*================================*/
GRANT SELECT ON PERIODIEKE_BEOORDELING_HISTORY TO STAGIAIR


/*================================*/
/* Tabel RISICOREGEL_HISTORY			  */
/*================================*/
GRANT SELECT ON RISICOREGEL_HISTORY TO STAGIAIR


/*================================*/
/* Tabel PLAN_VAN_AANPAK_HISTORY		  */
/*================================*/
GRANT SELECT ON PLAN_VAN_AANPAK_HISTORY TO STAGIAIR

/*================================*/
/* Tabel VISUELE_BEOORDELING_HISTORY	  */
/*================================*/
GRANT SELECT ON VISUELE_BEOORDELING_HISTORY TO STAGIAIR


/*================================*/
/* Tabel MACHINEVEILIGHEID_HISTORY			  */
/*================================*/
GRANT SELECT ON MACHINEVEILIGHEID_HISTORY TO STAGIAIR


/*================================*/
/* Tabel RAPPORT_TYPE     	  */
/*================================*/
GRANT SELECT ON RAPPORT_TYPE TO STAGIAIR
