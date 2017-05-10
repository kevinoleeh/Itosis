/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     10-5-2017 12:54:05                           */
/*==============================================================*/

use master

if db_id('Euratex') is not null 
	drop database Euratex

create database Euratex
use Euratex

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('AFBEELDING') and o.name = 'FK_AFBEELDI_VISUELE_B_VISUELE_')
alter table AFBEELDING
   drop constraint FK_AFBEELDI_VISUELE_B_VISUELE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ASPECT_EFFECT') and o.name = 'FK_ASPECT_E_ASPECT_EF_ASPECT')
alter table ASPECT_EFFECT
   drop constraint FK_ASPECT_E_ASPECT_EF_ASPECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ASPECT_EFFECT') and o.name = 'FK_ASPECT_E_ASPECT_EF_EFFECT')
alter table ASPECT_EFFECT
   drop constraint FK_ASPECT_E_ASPECT_EF_EFFECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('FINE_EN_KINNEY') and o.name = 'FK_FINE_EN__RISICOREG_RISICORE')
alter table FINE_EN_KINNEY
   drop constraint FK_FINE_EN__RISICOREG_RISICORE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PERIODIEKE_BEOORDELING') and o.name = 'FK_PERIODIE_PLAN_VAN__PLAN_VAN')
alter table PERIODIEKE_BEOORDELING
   drop constraint FK_PERIODIE_PLAN_VAN__PLAN_VAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PLAN_VAN_AANPAK') and o.name = 'FK_PLAN_VAN_RISICOMAA_RISICOMA')
alter table PLAN_VAN_AANPAK
   drop constraint FK_PLAN_VAN_RISICOMAA_RISICOMA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECT') and o.name = 'FK_PROJECT_BEDRIJF_P_BEDRIJF')
alter table PROJECT
   drop constraint FK_PROJECT_BEDRIJF_P_BEDRIJF
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RAPPORT') and o.name = 'FK_RAPPORT_PROJECT_R_PROJECT')
alter table RAPPORT
   drop constraint FK_RAPPORT_PROJECT_R_PROJECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOMAATREGEL') and o.name = 'FK_RISICOMA_RISICOREG_RISICORE')
alter table RISICOMAATREGEL
   drop constraint FK_RISICOMA_RISICOREG_RISICORE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOREGEL') and o.name = 'FK_RISICORE_RAPPORT_R_RAPPORT')
alter table RISICOREGEL
   drop constraint FK_RISICORE_RAPPORT_R_RAPPORT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOREGEL') and o.name = 'FK_RISICORE_RISICOREG_ASPECT')
alter table RISICOREGEL
   drop constraint FK_RISICORE_RISICOREG_ASPECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOREGEL') and o.name = 'FK_RISICORE_RISICOREG_EFFECT')
alter table RISICOREGEL
   drop constraint FK_RISICORE_RISICOREG_EFFECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VISUELE_BEOORDELING') and o.name = 'FK_VISUELE__IS_EEN_RI_RISICORE')
alter table VISUELE_BEOORDELING
   drop constraint FK_VISUELE__IS_EEN_RI_RISICORE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('AFBEELDING')
            and   name  = 'VISUELE_BEOORDELING_FK'
            and   indid > 0
            and   indid < 255)
   drop index AFBEELDING.VISUELE_BEOORDELING_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AFBEELDING')
            and   type = 'U')
   drop table AFBEELDING
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ASPECT')
            and   type = 'U')
   drop table ASPECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ASPECT_EFFECT')
            and   name  = 'ASPECT_EFFECT2_FK'
            and   indid > 0
            and   indid < 255)
   drop index ASPECT_EFFECT.ASPECT_EFFECT2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ASPECT_EFFECT')
            and   name  = 'ASPECT_EFFECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index ASPECT_EFFECT.ASPECT_EFFECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ASPECT_EFFECT')
            and   type = 'U')
   drop table ASPECT_EFFECT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BEDRIJF')
            and   type = 'U')
   drop table BEDRIJF
go

if exists (select 1
            from  sysobjects
           where  id = object_id('EFFECT')
            and   type = 'U')
   drop table EFFECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('FINE_EN_KINNEY')
            and   name  = 'RISICOREGEL_FINEY_EN_KENNY_FK'
            and   indid > 0
            and   indid < 255)
   drop index FINE_EN_KINNEY.RISICOREGEL_FINEY_EN_KENNY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('FINE_EN_KINNEY')
            and   type = 'U')
   drop table FINE_EN_KINNEY
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PERIODIEKE_BEOORDELING')
            and   type = 'U')
   drop table PERIODIEKE_BEOORDELING
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PLAN_VAN_AANPAK')
            and   type = 'U')
   drop table PLAN_VAN_AANPAK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PROJECT')
            and   name  = 'BEDRIJF_PROJECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index PROJECT.BEDRIJF_PROJECT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PROJECT')
            and   type = 'U')
   drop table PROJECT
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RAPPORT')
            and   name  = 'PROJECT_RAPPORT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RAPPORT.PROJECT_RAPPORT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RAPPORT')
            and   type = 'U')
   drop table RAPPORT
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RISICOMAATREGEL')
            and   type = 'U')
   drop table RISICOMAATREGEL
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RISICOREGEL')
            and   name  = 'RISICOREGEL_EFFECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RISICOREGEL.RISICOREGEL_EFFECT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RISICOREGEL')
            and   name  = 'RISICOREGEL_ASPECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RISICOREGEL.RISICOREGEL_ASPECT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RISICOREGEL')
            and   name  = 'RAPPORT_RISICOREGEL_FK'
            and   indid > 0
            and   indid < 255)
   drop index RISICOREGEL.RAPPORT_RISICOREGEL_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('RISICOREGEL')
            and   type = 'U')
   drop table RISICOREGEL
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VISUELE_BEOORDELING')
            and   type = 'U')
   drop table VISUELE_BEOORDELING
go

if exists(select 1 from systypes where name='AFBEELDING_TYPE')
   drop type AFBEELDING_TYPE
go

if exists(select 1 from systypes where name='AFDELING')
   drop type AFDELING
go

if exists(select 1 from systypes where name='AFWIJKENDE_ACTIE_TER_UITVOER')
   drop type AFWIJKENDE_ACTIE_TER_UITVOER
go

if exists(select 1 from systypes where name='ARBO_ONDERWERP')
   drop type ARBO_ONDERWERP
go

if exists(select 1 from systypes where name='ASPECTNAAM')
   drop type ASPECTNAAM
go

if exists(select 1 from systypes where name='BEDRIJFSNAAM')
   drop type BEDRIJFSNAAM
go

if exists(select 1 from systypes where name='CONTROLELIJST')
   drop type CONTROLELIJST
go

if exists(select 1 from systypes where name='DATUM')
   drop type DATUM
go

if exists(select 1 from systypes where name='EFFECTNAAM')
   drop type EFFECTNAAM
go

if exists(select 1 from systypes where name='EINDVERANTWOORDELIJKE')
   drop type EINDVERANTWOORDELIJKE
go

if exists(select 1 from systypes where name='ERNST_VAN_ONGEVAL')
   drop type ERNST_VAN_ONGEVAL
go

if exists(select 1 from systypes where name='FINE_EN_KINNEY_TYPE')
   drop type FINE_EN_KINNEY_TYPE
go

if exists(select 1 from systypes where name='HUIDIGE_BEHEERSMAATREGEL')
   drop type HUIDIGE_BEHEERSMAATREGEL
go

if exists(select 1 from systypes where name='INSPECTIE_IS_DE_ACTIE_UITGEVOERD')
   drop type INSPECTIE_IS_DE_ACTIE_UITGEVOERD
go

if exists(select 1 from systypes where name='KANS_OP_BLOOTSTELLING')
   drop type KANS_OP_BLOOTSTELLING
go

if exists(select 1 from systypes where name='KANS_OP_WAARSCHIJNLIJKHEID')
   drop type KANS_OP_WAARSCHIJNLIJKHEID
go

if exists(select 1 from systypes where name='LOCATIE')
   drop type LOCATIE
go

if exists(select 1 from systypes where name='MACHINE_ONDERDEEL')
   drop type MACHINE_ONDERDEEL
go

if exists(select 1 from systypes where name='OPMERKING_STAND_VAN_ZAKEN')
   drop type OPMERKING_STAND_VAN_ZAKEN
go

if exists(select 1 from systypes where name='PBM')
   drop type PBM
go

if exists(select 1 from systypes where name='PERIODIEKE_BEOORDELING')
   drop type PERIODIEKE_BEOORDELING
go

if exists(select 1 from systypes where name='PLAATS')
   drop type PLAATS
go

if exists(select 1 from systypes where name='PRIORITEIT')
   drop type PRIORITEIT
go

if exists(select 1 from systypes where name='PROCES')
   drop type PROCES
go

if exists(select 1 from systypes where name='PROJECTNUMMER')
   drop type PROJECTNUMMER
go

if exists(select 1 from systypes where name='PROJECTOMSCHRIJVING')
   drop type PROJECTOMSCHRIJVING
go

if exists(select 1 from systypes where name='RAPPORTNUMMER')
   drop type RAPPORTNUMMER
go

if exists(select 1 from systypes where name='RAPPORT_TYPE')
   drop type RAPPORT_TYPE
go

if exists(select 1 from systypes where name='REGELNUMMER')
   drop type REGELNUMMER
go

if exists(select 1 from systypes where name='RESTRISICO')
   drop type RESTRISICO
go

if exists(select 1 from systypes where name='RISICO')
   drop type RISICO
go

if exists(select 1 from systypes where name='SCORE')
   drop type SCORE
go

if exists(select 1 from systypes where name='STAND_VAN_ZAKEN')
   drop type STAND_VAN_ZAKEN
go

if exists(select 1 from systypes where name='TRA')
   drop type TRA
go

if exists(select 1 from systypes where name='UITGEVOERD_DOOR')
   drop type UITGEVOERD_DOOR
go

if exists(select 1 from systypes where name='URL')
   drop type URL
go

if exists(select 1 from systypes where name='VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL')
   drop type VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL
go

if exists(select 1 from systypes where name='VOORLICHTING')
   drop type VOORLICHTING
go

if exists(select 1 from systypes where name='WERKINSTRUCTIE_PROCEDURE')
   drop type WERKINSTRUCTIE_PROCEDURE
go

/*==============================================================*/
/* Domain: AFBEELDING_TYPE                                      */
/*==============================================================*/
create type AFBEELDING_TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: AFDELING                                             */
/*==============================================================*/
create type AFDELING
   from varchar(255)
go

/*==============================================================*/
/* Domain: AFWIJKENDE_ACTIE_TER_UITVOER                         */
/*==============================================================*/
create type AFWIJKENDE_ACTIE_TER_UITVOER
   from varchar(255)
go

/*==============================================================*/
/* Domain: ARBO_ONDERWERP                                       */
/*==============================================================*/
create type ARBO_ONDERWERP
   from varchar(255)
go

/*==============================================================*/
/* Domain: ASPECTNAAM                                           */
/*==============================================================*/
create type ASPECTNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: BEDRIJFSNAAM                                         */
/*==============================================================*/
create type BEDRIJFSNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: CONTROLELIJST                                        */
/*==============================================================*/
create type CONTROLELIJST
   from varchar(255)
go

/*==============================================================*/
/* Domain: DATUM                                                */
/*==============================================================*/
create type DATUM
   from varchar(255)
go

/*==============================================================*/
/* Domain: EFFECTNAAM                                           */
/*==============================================================*/
create type EFFECTNAAM
   from varchar(255)
go

/*==============================================================*/
/* Domain: EINDVERANTWOORDELIJKE                                */
/*==============================================================*/
create type EINDVERANTWOORDELIJKE
   from varchar(255)
go

/*==============================================================*/
/* Domain: ERNST_VAN_ONGEVAL                                    */
/*==============================================================*/
create type ERNST_VAN_ONGEVAL
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: FINE_EN_KINNEY_TYPE                                  */
/*==============================================================*/
create type FINE_EN_KINNEY_TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: HUIDIGE_BEHEERSMAATREGEL                             */
/*==============================================================*/
create type HUIDIGE_BEHEERSMAATREGEL
   from varchar(255)
go

/*==============================================================*/
/* Domain: INSPECTIE_IS_DE_ACTIE_UITGEVOERD                     */
/*==============================================================*/
create type INSPECTIE_IS_DE_ACTIE_UITGEVOERD
   from bit
go

/*==============================================================*/
/* Domain: KANS_OP_BLOOTSTELLING                                */
/*==============================================================*/
create type KANS_OP_BLOOTSTELLING
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: KANS_OP_WAARSCHIJNLIJKHEID                           */
/*==============================================================*/
create type KANS_OP_WAARSCHIJNLIJKHEID
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: LOCATIE                                              */
/*==============================================================*/
create type LOCATIE
   from varchar(255)
go

/*==============================================================*/
/* Domain: MACHINE_ONDERDEEL                                    */
/*==============================================================*/
create type MACHINE_ONDERDEEL
   from varchar(255)
go

/*==============================================================*/
/* Domain: OPMERKING_STAND_VAN_ZAKEN                            */
/*==============================================================*/
create type OPMERKING_STAND_VAN_ZAKEN
   from varchar(255)
go

/*==============================================================*/
/* Domain: PBM                                                  */
/*==============================================================*/
create type PBM
   from varchar(255)
go

/*==============================================================*/
/* Domain: PERIODIEKE_BEOORDELING                               */
/*==============================================================*/
create type PERIODIEKE_BEOORDELING
   from varchar(255)
go

/*==============================================================*/
/* Domain: PLAATS                                               */
/*==============================================================*/
create type PLAATS
   from varchar(255)
go

/*==============================================================*/
/* Domain: PRIORITEIT                                           */
/*==============================================================*/
create type PRIORITEIT
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: PROCES                                               */
/*==============================================================*/
create type PROCES
   from varchar(255)
go

/*==============================================================*/
/* Domain: PROJECTNUMMER                                        */
/*==============================================================*/
create type PROJECTNUMMER
   from int
go

/*==============================================================*/
/* Domain: PROJECTOMSCHRIJVING                                  */
/*==============================================================*/
create type PROJECTOMSCHRIJVING
   from varchar(255)
go

/*==============================================================*/
/* Domain: RAPPORTNUMMER                                        */
/*==============================================================*/
create type RAPPORTNUMMER
   from int
go

/*==============================================================*/
/* Domain: RAPPORT_TYPE                                         */
/*==============================================================*/
create type RAPPORT_TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: REGELNUMMER                                          */
/*==============================================================*/
create type REGELNUMMER
   from int
go

/*==============================================================*/
/* Domain: RESTRISICO                                           */
/*==============================================================*/
create type RESTRISICO
   from varchar(255)
go

/*==============================================================*/
/* Domain: RISICO                                               */
/*==============================================================*/
create type RISICO
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: SCORE                                                */
/*==============================================================*/
create type SCORE
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: STAND_VAN_ZAKEN                                      */
/*==============================================================*/
create type STAND_VAN_ZAKEN
   from varchar(255)
go

/*==============================================================*/
/* Domain: TRA                                                  */
/*==============================================================*/
create type TRA
   from varchar(255)
go

/*==============================================================*/
/* Domain: UITGEVOERD_DOOR                                      */
/*==============================================================*/
create type UITGEVOERD_DOOR
   from varchar(255)
go

/*==============================================================*/
/* Domain: URL                                                  */
/*==============================================================*/
create type URL
   from varchar(255)
go

/*==============================================================*/
/* Domain: VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL          */
/*==============================================================*/
create type VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL
   from varchar(255)
go

/*==============================================================*/
/* Domain: VOORLICHTING                                         */
/*==============================================================*/
create type VOORLICHTING
   from varchar(255)
go

/*==============================================================*/
/* Domain: WERKINSTRUCTIE_PROCEDURE                             */
/*==============================================================*/
create type WERKINSTRUCTIE_PROCEDURE
   from varchar(255)
go

/*==============================================================*/
/* Table: AFBEELDING                                            */
/*==============================================================*/
create table AFBEELDING (
   URL                  URL                  not null,
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   AFBEELDING_TYPE      AFBEELDING_TYPE      null,
   THUMBNAIL_URL        URL                  null,
   constraint PK_AFBEELDING primary key (URL)
)
go

/*==============================================================*/
/* Index: VISUELE_BEOORDELING_FK                                */
/*==============================================================*/




create nonclustered index VISUELE_BEOORDELING_FK on AFBEELDING (PROJECTNUMMER ASC,
  RAPPORTNUMMER ASC,
  REGELNUMMER ASC)
go

/*==============================================================*/
/* Table: ASPECT                                                */
/*==============================================================*/
create table ASPECT (
   ASPECTNAAM           ASPECTNAAM           not null,
   constraint PK_ASPECT primary key (ASPECTNAAM)
)
go

/*==============================================================*/
/* Table: ASPECT_EFFECT                                         */
/*==============================================================*/
create table ASPECT_EFFECT (
   ASPECTNAAM           ASPECTNAAM           not null,
   EFFECTNAAM           EFFECTNAAM           not null,
   constraint PK_ASPECT_EFFECT primary key (ASPECTNAAM, EFFECTNAAM)
)
go

/*==============================================================*/
/* Index: ASPECT_EFFECT_FK                                      */
/*==============================================================*/




create nonclustered index ASPECT_EFFECT_FK on ASPECT_EFFECT (ASPECTNAAM ASC)
go

/*==============================================================*/
/* Index: ASPECT_EFFECT2_FK                                     */
/*==============================================================*/




create nonclustered index ASPECT_EFFECT2_FK on ASPECT_EFFECT (EFFECTNAAM ASC)
go

/*==============================================================*/
/* Table: BEDRIJF                                               */
/*==============================================================*/
create table BEDRIJF (
   BEDRIJFSNAAM         BEDRIJFSNAAM         not null,
   LOCATIE              LOCATIE              not null,
   constraint PK_BEDRIJF primary key (BEDRIJFSNAAM, LOCATIE)
)
go

/*==============================================================*/
/* Table: EFFECT                                                */
/*==============================================================*/
create table EFFECT (
   EFFECTNAAM           EFFECTNAAM           not null,
   constraint PK_EFFECT primary key (EFFECTNAAM)
)
go

/*==============================================================*/
/* Table: FINE_EN_KINNEY                                        */
/*==============================================================*/
-- Geeft het risico terug op basis van ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING en KANS_OP_WAARSCHIJNLIJKHEID.
GO
CREATE FUNCTION dbo.fnGetRisico(@ERNST_VAN_HET_ONGEVAL NUMERIC(9, 2), @KANS_OP_BLOOTSTELLING NUMERIC(9, 2), @KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2))
RETURNS NUMERIC(9, 2)
AS
BEGIN
	RETURN (@ERNST_VAN_HET_ONGEVAL * @KANS_OP_BLOOTSTELLING * @KANS_OP_WAARSCHIJNLIJKHEID)
END
GO

-- Geeft de prioriteit van een risico terug.
GO
CREATE FUNCTION dbo.fnGetPrioriteit(@Risico NUMERIC(9, 2))
RETURNS VARCHAR(255)
AS
BEGIN
	DECLARE @Prioriteit VARCHAR(255)

	IF(@Risico <= 20) BEGIN
		SET @Prioriteit = 'P 5'
	END ELSE IF(@Risico >= 21 AND @Risico <= 75) BEGIN
		SET @Prioriteit = 'P 4'
	END ELSE IF(@Risico >= 76 AND @Risico <= 200) BEGIN
		SET @Prioriteit = 'P 3'
	END ELSE IF(@Risico >= 201 AND @Risico <= 400) BEGIN
		SET @Prioriteit = 'P 2'
	END ELSE BEGIN
		SET @Prioriteit = 'P 1'
	END

	RETURN @Prioriteit
END
GO

create table FINE_EN_KINNEY (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   FINE_EN_KINNEY_TYPE  FINE_EN_KINNEY_TYPE  not null,
   ERNST_VAN_HET_ONGEVAL ERNST_VAN_ONGEVAL    not null 
      constraint CKC_ERNST_VAN_HET_ONG_FINE_EN_ check (ERNST_VAN_HET_ONGEVAL in (100,40,15,7,3,1)),
   KANS_OP_BLOOTSTELLING KANS_OP_BLOOTSTELLING not null 
      constraint CKC_KANS_OP_BLOOTSTEL_FINE_EN_ check (KANS_OP_BLOOTSTELLING in (10,6,3,2,1,0,5)),
   KANS_OP_WAARSCHIJNLIJKHEID KANS_OP_WAARSCHIJNLIJKHEID not null 
      constraint CKC_KANS_OP_WAARSCHIJ_FINE_EN_ check (KANS_OP_WAARSCHIJNLIJKHEID in (10,6,3,1,0,5,0,2)),
   RISICO               AS dbo.fnGetRisico(ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID),
   PRIORITEIT           AS dbo.fnGetPrioriteit(dbo.fnGetRisico(ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID)),
   constraint PK_FINE_EN_KINNEY primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, FINE_EN_KINNEY_TYPE)
)
go

/*==============================================================*/
/* Index: RISICOREGEL_FINEY_EN_KENNY_FK                         */
/*==============================================================*/




create nonclustered index RISICOREGEL_FINEY_EN_KENNY_FK on FINE_EN_KINNEY (PROJECTNUMMER ASC,
  RAPPORTNUMMER ASC,
  REGELNUMMER ASC)
go

/*==============================================================*/
/* Table: PERIODIEKE_BEOORDELING                                */
/*==============================================================*/
create table PERIODIEKE_BEOORDELING (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   DATUM_LAATSTE_BEOORDELING DATUM                not null,
   INSPECTIE_IS_DE_ACTIE_UITGEVOERD INSPECTIE_IS_DE_ACTIE_UITGEVOERD not null,
   OPMERKING_STAND_VAN_ZAKEN OPMERKING_STAND_VAN_ZAKEN null,
   STAND_VAN_ZAKEN      STAND_VAN_ZAKEN      null,
   SCORE                SCORE                null,
   constraint PK_PERIODIEKE_BEOORDELING primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Table: PLAN_VAN_AANPAK                                       */
/*==============================================================*/
create table PLAN_VAN_AANPAK (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   UITGEVOERD_DOOR      UITGEVOERD_DOOR      not null,
   EINDVERANTWOORDELIJKE EINDVERANTWOORDELIJKE not null,
   DATUM_GEREED_GEPLAND DATUM                not null,
   PBM                  PBM                  null,
   VOORLICHTING         VOORLICHTING         null,
   WERKINSTRUCTIE_PROCEDURE WERKINSTRUCTIE_PROCEDURE null,
   TRA                  TRA                  null,
   CONTRACT_LIJST_      CONTROLELIJST        null,
   PERIODIEKE_BEOORDELING PERIODIEKE_BEOORDELING null,
   constraint PK_PLAN_VAN_AANPAK primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PROJECTNUMMER        PROJECTNUMMER   IDENTITY (1,1)    not null,
   BEDRIJFSNAAM         BEDRIJFSNAAM         not null,
   LOCATIE              LOCATIE              not null,
   PROJECTOMSCHRIJVING  PROJECTOMSCHRIJVING  not null,
   constraint PK_PROJECT primary key (PROJECTNUMMER)
)
go

/*==============================================================*/
/* Index: BEDRIJF_PROJECT_FK                                    */
/*==============================================================*/




create nonclustered index BEDRIJF_PROJECT_FK on PROJECT (BEDRIJFSNAAM ASC,
  LOCATIE ASC)
go

/*==============================================================*/
/* Table: RAPPORT                                               */
/*==============================================================*/
create table RAPPORT (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   RAPPORT_TYPE         RAPPORT_TYPE         null,
   constraint PK_RAPPORT primary key (PROJECTNUMMER, RAPPORTNUMMER)
)
go

/*==============================================================*/
/* Index: PROJECT_RAPPORT_FK                                    */
/*==============================================================*/




create nonclustered index PROJECT_RAPPORT_FK on RAPPORT (PROJECTNUMMER ASC)
go

/*==============================================================*/
/* Table: RISICOMAATREGEL                                       */
/*==============================================================*/
create table RISICOMAATREGEL (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL not null,
   AFWIJKENDE_ACTIE_TER_UITVOERING AFWIJKENDE_ACTIE_TER_UITVOER null,
   RESTRISICO           RESTRISICO           null,
   constraint PK_RISICOMAATREGEL primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Table: RISICOREGEL                                           */
/*==============================================================*/
create table RISICOREGEL (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   ASPECTNAAM           ASPECTNAAM           not null,
   EFFECTNAAM           EFFECTNAAM           not null,
   ARBO_ONDERWERP       ARBO_ONDERWERP       not null,
   HUIDIGE_BEHEERSMAATREGEL HUIDIGE_BEHEERSMAATREGEL null,
   constraint PK_RISICOREGEL primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Index: RAPPORT_RISICOREGEL_FK                                */
/*==============================================================*/




create nonclustered index RAPPORT_RISICOREGEL_FK on RISICOREGEL (PROJECTNUMMER ASC,
  RAPPORTNUMMER ASC)
go

/*==============================================================*/
/* Index: RISICOREGEL_ASPECT_FK                                 */
/*==============================================================*/




create nonclustered index RISICOREGEL_ASPECT_FK on RISICOREGEL (ASPECTNAAM ASC)
go

/*==============================================================*/
/* Index: RISICOREGEL_EFFECT_FK                                 */
/*==============================================================*/




create nonclustered index RISICOREGEL_EFFECT_FK on RISICOREGEL (EFFECTNAAM ASC)
go

/*==============================================================*/
/* Table: VISUELE_BEOORDELING                                   */
/*==============================================================*/
create table VISUELE_BEOORDELING (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   PROCES               PROCES               null,
   MACHINE_ONDERDEEL_   MACHINE_ONDERDEEL    null,
   AFDELING             AFDELING             null,
   constraint PK_VISUELE_BEOORDELING primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

alter table AFBEELDING
   add constraint FK_AFBEELDI_VISUELE_B_VISUELE_ foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references VISUELE_BEOORDELING (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_ASPECT_EF_ASPECT foreign key (ASPECTNAAM)
      references ASPECT (ASPECTNAAM)
go

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_ASPECT_EF_EFFECT foreign key (EFFECTNAAM)
      references EFFECT (EFFECTNAAM)
go

alter table FINE_EN_KINNEY
   add constraint FK_FINE_EN__RISICOREG_RISICORE foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table PERIODIEKE_BEOORDELING
   add constraint FK_PERIODIE_PLAN_VAN__PLAN_VAN foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references PLAN_VAN_AANPAK (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table PLAN_VAN_AANPAK
   add constraint FK_PLAN_VAN_RISICOMAA_RISICOMA foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOMAATREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table PROJECT
   add constraint FK_PROJECT_BEDRIJF_P_BEDRIJF foreign key (BEDRIJFSNAAM, LOCATIE)
      references BEDRIJF (BEDRIJFSNAAM, LOCATIE)
go

alter table RAPPORT
   add constraint FK_RAPPORT_PROJECT_R_PROJECT foreign key (PROJECTNUMMER)
      references PROJECT (PROJECTNUMMER)
go

alter table RISICOMAATREGEL
   add constraint FK_RISICOMA_RISICOREG_RISICORE foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table RISICOREGEL
   add constraint FK_RISICORE_RAPPORT_R_RAPPORT foreign key (PROJECTNUMMER, RAPPORTNUMMER)
      references RAPPORT (PROJECTNUMMER, RAPPORTNUMMER)
go

alter table RISICOREGEL
   add constraint FK_RISICORE_RISICOREG_ASPECT foreign key (ASPECTNAAM)
      references ASPECT (ASPECTNAAM)
go

alter table RISICOREGEL
   add constraint FK_RISICORE_RISICOREG_EFFECT foreign key (EFFECTNAAM)
      references EFFECT (EFFECTNAAM)
go

alter table VISUELE_BEOORDELING
   add constraint FK_VISUELE__IS_EEN_RI_RISICORE foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

use master
