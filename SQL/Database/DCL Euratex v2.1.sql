USE Euratex
GO

/*==============================================================*/
/* LOGIN							                            */
/*==============================================================*/
CREATE LOGIN BeheerderLogin WITH PASSWORD = 'BeheerderLogin'
CREATE LOGIN GebruikerLogin WITH PASSWORD = 'GebruikerLogin'
CREATE LOGIN StagiairLogin WITH PASSWORD = 'StagiairLogin'

/*==============================================================*/
/* USER								                            */
/*==============================================================*/
CREATE USER BeheerderUser FOR LOGIN BeheerderLogin
CREATE USER GebruikerUser FOR LOGIN GebruikerLogin
CREATE USER StagiairUser FOR LOGIN StagiairLogin

/*==============================================================*/
/* ROLLEN							                            */
/*==============================================================*/
CREATE ROLE BEHEERDER
CREATE ROLE GEBRUIKER
CREATE ROLE STAGIAIR

EXEC sp_addrolemember 'BEHEERDER', 'BeheerderUser'
EXEC sp_addrolemember 'GEBRUIKER', 'GebruikerUser'
EXEC sp_addrolemember 'STAGIAIR', 'StagiairUser'

/*==============================================================*/
/* TOEWIJZEN ROLLEN					                            */
/*==============================================================*/
-- Beheerder
-- ...

-- Gebruiker
GRANT READ ON BEDRIJF TO GEBRUIKER
GRANT READ ON PROJECT TO GEBRUIKER
GRANT READ ON RAPPORT TO GEBRUIKER
GRANT READ ON RAPPORT_TYPE TO GEBRUIKER
GRANT READ ON RISICOREGEL TO GEBRUIKER
GRANT READ ON VISUELE_BEOORDELING TO GEBRUIKER
GRANT READ ON MACHINE_VEILIGHEID TO GEBRUIKER
GRANT READ ON AFBEELDING TO GEBRUIKER
GRANT READ ON ASPECT TO GEBRUIKER
GRANT READ ON EFFECT TO GEBRUIKER
GRANT READ ON ASPECT_EFFECT TO GEBRUIKER
GRANT READ ON PLAN_VAN_AANPAK TO GEBRUIKER
GRANT READ ON PERIODIEKE_BEOORDELING TO GEBRUIKER

GRANT EXECUTE ON SP_INSERT_ORGANISATIE_RISICOREGEL TO GEBRUIKER
GRANT EXECUTE ON SP_UPDATE_ORGANISATIE_RISICOREGEL TO GEBRUIKER
GRANT EXECUTE ON SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL TO GEBRUIKER
GRANT EXECUTE ON SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL TO GEBRUIKER

-- Stagiair
-- ...