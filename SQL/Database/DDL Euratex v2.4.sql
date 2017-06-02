/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2014                    */
/* Created on:     30-5-2017 14:15:19                           */
/*==============================================================*/

use master

if db_id('Euratex') is not null begin
	drop database Euratex
end

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
   where r.fkeyid = object_id('ASPECT_EFFECT') and o.name = 'FK_ASPECT_E_ASPECT_AS_ASPECT')
alter table ASPECT_EFFECT
   drop constraint FK_ASPECT_E_ASPECT_AS_ASPECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ASPECT_EFFECT') and o.name = 'FK_ASPECT_E_EFFECT_AS_EFFECT')
alter table ASPECT_EFFECT
   drop constraint FK_ASPECT_E_EFFECT_AS_EFFECT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MACHINEVEILIGHEID') and o.name = 'FK_MACHINEV_IS_EEN_VI_VISUELE_')
alter table MACHINEVEILIGHEID
   drop constraint FK_MACHINEV_IS_EEN_VI_VISUELE_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PERIODIEKE_BEOORDELING') and o.name = 'FK_PERIODIE_PLAN_VAN__PLAN_VAN')
alter table PERIODIEKE_BEOORDELING
   drop constraint FK_PERIODIE_PLAN_VAN__PLAN_VAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PLAN_VAN_AANPAK') and o.name = 'FK_PLAN_VAN_RISICOREG_RISICORE')
alter table PLAN_VAN_AANPAK
   drop constraint FK_PLAN_VAN_RISICOREG_RISICORE
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
   where r.fkeyid = object_id('RAPPORT') and o.name = 'FK_RAPPORT_RAPPORT_T_RAPPORT_')
alter table RAPPORT
   drop constraint FK_RAPPORT_RAPPORT_T_RAPPORT_
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOREGEL') and o.name = 'FK_RISICORE_RAPPORT_R_RAPPORT')
alter table RISICOREGEL
   drop constraint FK_RISICORE_RAPPORT_R_RAPPORT
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('RISICOREGEL') and o.name = 'FK_RISICORE_RISICOREG_ASPECT_E')
alter table RISICOREGEL
   drop constraint FK_RISICORE_RISICOREG_ASPECT_E
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
            and   name  = 'EFFECT_ASPECT_EFFECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index ASPECT_EFFECT.EFFECT_ASPECT_EFFECT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('ASPECT_EFFECT')
            and   name  = 'ASPECT_ASPECT_EFFECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index ASPECT_EFFECT.ASPECT_ASPECT_EFFECT_FK
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
            from  sysobjects
           where  id = object_id('MACHINEVEILIGHEID')
            and   type = 'U')
   drop table MACHINEVEILIGHEID
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PERIODIEKE_BEOORDELING')
            and   name  = 'PLAN_VAN_AANPAK_PERIODIEKE_BEOORDELING_FK'
            and   indid > 0
            and   indid < 255)
   drop index PERIODIEKE_BEOORDELING.PLAN_VAN_AANPAK_PERIODIEKE_BEOORDELING_FK
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
            and   name  = 'RAPPORT_TYPE_RAPPORT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RAPPORT.RAPPORT_TYPE_RAPPORT_FK
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
           where  id = object_id('RAPPORT_TYPE')
            and   type = 'U')
   drop table RAPPORT_TYPE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('RISICOREGEL')
            and   name  = 'RISICOREGEL_ASPECT_EFFECT_FK'
            and   indid > 0
            and   indid < 255)
   drop index RISICOREGEL.RISICOREGEL_ASPECT_EFFECT_FK
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

if exists(select 1 from systypes where name='AANVULLENDE_OMSCHRIJVING')
   drop type AANVULLENDE_OMSCHRIJVING
go

if exists(select 1 from systypes where name='AFBEELDING_TYPE')
   drop type AFBEELDING_TYPE
go

if exists(select 1 from systypes where name='AFDELING')
   drop type AFDELING
go

if exists(select 1 from systypes where name='AFSCHERMING')
   drop type AFSCHERMING
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

if exists(select 1 from systypes where name='CE_DOCUCHECK')
   drop type CE_DOCUCHECK
go

if exists(select 1 from systypes where name='CE_MARKERING')
   drop type CE_MARKERING
go

if exists(select 1 from systypes where name='CI')
   drop type CI
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

if exists(select 1 from systypes where name='ERNST_VAN_DE_GEVOLGEN')
   drop type ERNST_VAN_DE_GEVOLGEN
go

if exists(select 1 from systypes where name='FINE_EN_KINNEY_TYPE')
   drop type FINE_EN_KINNEY_TYPE
go

if exists(select 1 from systypes where name='FREQUENTIE')
   drop type FREQUENTIE
go

if exists(select 1 from systypes where name='HUIDIGE_BEHEERSMAATREGEL')
   drop type HUIDIGE_BEHEERSMAATREGEL
go

if exists(select 1 from systypes where name='INSPECTIE_IS_DE_ACTIE_UITGEVOERD')
   drop type INSPECTIE_IS_DE_ACTIE_UITGEVOERD
go

if exists(select 1 from systypes where name='INSTRUCTIE')
   drop type INSTRUCTIE
go

if exists(select 1 from systypes where name='KEUZE')
   drop type KEUZE
go

if exists(select 1 from systypes where name='LEVERANCIER')
   drop type LEVERANCIER
go

if exists(select 1 from systypes where name='LIJN')
   drop type LIJN
go

if exists(select 1 from systypes where name='LOCATIE')
   drop type LOCATIE
go

if exists(select 1 from systypes where name='MACHINE')
   drop type MACHINE
go

if exists(select 1 from systypes where name='MACHINE_CODE')
   drop type MACHINE_CODE
go

if exists(select 1 from systypes where name='MACHINE_ONDERDEEL')
   drop type MACHINE_ONDERDEEL
go

if exists(select 1 from systypes where name='MODEL___TYPE')
   drop type MODEL___TYPE
go

if exists(select 1 from systypes where name='MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS')
   drop type MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS
go

if exists(select 1 from systypes where name='MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE')
   drop type MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE
go

if exists(select 1 from systypes where name='NA_ERNST_VAN_ONGEVAL')
   drop type NA_ERNST_VAN_ONGEVAL
go

if exists(select 1 from systypes where name='NA_KANS_OP_BLOOTSTELLING')
   drop type NA_KANS_OP_BLOOTSTELLING
go

if exists(select 1 from systypes where name='NA_KANS_OP_WAARSCHIJNLIJKHEID')
   drop type NA_KANS_OP_WAARSCHIJNLIJKHEID
go

if exists(select 1 from systypes where name='NA_PRIORITEIT')
   drop type NA_PRIORITEIT
go

if exists(select 1 from systypes where name='NA_RISICO')
   drop type NA_RISICO
go

if exists(select 1 from systypes where name='ONTWERP')
   drop type ONTWERP
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

if exists(select 1 from systypes where name='PID')
   drop type PID
go

if exists(select 1 from systypes where name='PLAATS')
   drop type PLAATS
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

if exists(select 1 from systypes where name='RISICO_OMSCHRIJVING_OF_BEVINDING')
   drop type RISICO_OMSCHRIJVING_OF_BEVINDING
go

if exists(select 1 from systypes where name='SCORE')
   drop type SCORE
go

if exists(select 1 from systypes where name='SERIENUMMER')
   drop type SERIENUMMER
go

if exists(select 1 from systypes where name='STAND_VAN_ZAKEN')
   drop type STAND_VAN_ZAKEN
go

if exists(select 1 from systypes where name='TAKEN')
   drop type TAKEN
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

if exists(select 1 from systypes where name='VOOR_ERNST_VAN_ONGEVAL')
   drop type VOOR_ERNST_VAN_ONGEVAL
go

if exists(select 1 from systypes where name='VOOR_KANS_OP_BLOOTSTELLING')
   drop type VOOR_KANS_OP_BLOOTSTELLING
go

if exists(select 1 from systypes where name='VOOR_KANS_OP_WAARSCHIJNLIJKHEID')
   drop type VOOR_KANS_OP_WAARSCHIJNLIJKHEID
go

if exists(select 1 from systypes where name='VOOR_PRIORITEIT')
   drop type VOOR_PRIORITEIT
go

if exists(select 1 from systypes where name='VOOR_RISICO')
   drop type VOOR_RISICO
go

if exists(select 1 from systypes where name='WERKINSTRUCTIE_PROCEDURE')
   drop type WERKINSTRUCTIE_PROCEDURE
go

/*==============================================================*/
/* Domain: AANVULLENDE_OMSCHRIJVING                             */
/*==============================================================*/
create type AANVULLENDE_OMSCHRIJVING
   from varchar(8000)
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
/* Domain: AFSCHERMING                                          */
/*==============================================================*/
create type AFSCHERMING
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
/* Domain: CE_DOCUCHECK                                         */
/*==============================================================*/
create type CE_DOCUCHECK
   from varchar(255)
go

/*==============================================================*/
/* Domain: CE_MARKERING                                         */
/*==============================================================*/
create type CE_MARKERING
   from varchar(255)
go

/*==============================================================*/
/* Domain: CI                                                   */
/*==============================================================*/
create type CI
   from numeric(9,2)
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
   from datetime
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
/* Domain: ERNST_VAN_DE_GEVOLGEN                                */
/*==============================================================*/
create type ERNST_VAN_DE_GEVOLGEN
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: FINE_EN_KINNEY_TYPE                                  */
/*==============================================================*/
create type FINE_EN_KINNEY_TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: FREQUENTIE                                           */
/*==============================================================*/
create type FREQUENTIE
   from numeric(9,2)
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
/* Domain: INSTRUCTIE                                           */
/*==============================================================*/
create type INSTRUCTIE
   from varchar(8000)
go

/*==============================================================*/
/* Domain: KEUZE                                                */
/*==============================================================*/
create type KEUZE
   from bit
go

/*==============================================================*/
/* Domain: LEVERANCIER                                          */
/*==============================================================*/
create type LEVERANCIER
   from varchar(255)
go

/*==============================================================*/
/* Domain: LIJN                                                 */
/*==============================================================*/
create type LIJN
   from varchar(255)
go

/*==============================================================*/
/* Domain: LOCATIE                                              */
/*==============================================================*/
create type LOCATIE
   from varchar(255)
go

/*==============================================================*/
/* Domain: MACHINE                                              */
/*==============================================================*/
create type MACHINE
   from varchar(255)
go

/*==============================================================*/
/* Domain: MACHINE_CODE                                         */
/*==============================================================*/
create type MACHINE_CODE
   from varchar(255)
go

/*==============================================================*/
/* Domain: MACHINE_ONDERDEEL                                    */
/*==============================================================*/
create type MACHINE_ONDERDEEL
   from varchar(255)
go

/*==============================================================*/
/* Domain: MODEL___TYPE                                         */
/*==============================================================*/
create type MODEL___TYPE
   from varchar(255)
go

/*==============================================================*/
/* Domain: MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS        */
/*==============================================================*/
create type MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE            */
/*==============================================================*/
create type MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: NA_ERNST_VAN_ONGEVAL                                 */
/*==============================================================*/
create type NA_ERNST_VAN_ONGEVAL
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: NA_KANS_OP_BLOOTSTELLING                             */
/*==============================================================*/
create type NA_KANS_OP_BLOOTSTELLING
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: NA_KANS_OP_WAARSCHIJNLIJKHEID                        */
/*==============================================================*/
create type NA_KANS_OP_WAARSCHIJNLIJKHEID
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: NA_PRIORITEIT                                        */
/*==============================================================*/
create type NA_PRIORITEIT
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: NA_RISICO                                            */
/*==============================================================*/
create type NA_RISICO
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: ONTWERP                                              */
/*==============================================================*/
create type ONTWERP
   from varchar(255)
go

/*==============================================================*/
/* Domain: OPMERKING_STAND_VAN_ZAKEN                            */
/*==============================================================*/
create type OPMERKING_STAND_VAN_ZAKEN
   from varchar(8000)
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
/* Domain: PID                                                  */
/*==============================================================*/
create type PID
   from varchar(255)
go

/*==============================================================*/
/* Domain: PLAATS                                               */
/*==============================================================*/
create type PLAATS
   from varchar(255)
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
   from varchar(8000)
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
   from varchar(8000)
go

/*==============================================================*/
/* Domain: RISICO_OMSCHRIJVING_OF_BEVINDING                     */
/*==============================================================*/
create type RISICO_OMSCHRIJVING_OF_BEVINDING
   from varchar(8000)
go

/*==============================================================*/
/* Domain: SCORE                                                */
/*==============================================================*/
create type SCORE
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: SERIENUMMER                                          */
/*==============================================================*/
create type SERIENUMMER
   from varchar(255)
go

/*==============================================================*/
/* Domain: STAND_VAN_ZAKEN                                      */
/*==============================================================*/
create type STAND_VAN_ZAKEN
   from varchar(255)
go

/*==============================================================*/
/* Domain: TAKEN                                                */
/*==============================================================*/
create type TAKEN
   from varchar(8000)
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
   from varchar(8000)
go

/*==============================================================*/
/* Domain: VOORLICHTING                                         */
/*==============================================================*/
create type VOORLICHTING
   from varchar(255)
go

/*==============================================================*/
/* Domain: VOOR_ERNST_VAN_ONGEVAL                               */
/*==============================================================*/
create type VOOR_ERNST_VAN_ONGEVAL
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: VOOR_KANS_OP_BLOOTSTELLING                           */
/*==============================================================*/
create type VOOR_KANS_OP_BLOOTSTELLING
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: VOOR_KANS_OP_WAARSCHIJNLIJKHEID                      */
/*==============================================================*/
create type VOOR_KANS_OP_WAARSCHIJNLIJKHEID
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: VOOR_PRIORITEIT                                      */
/*==============================================================*/
create type VOOR_PRIORITEIT
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: VOOR_RISICO                                          */
/*==============================================================*/
create type VOOR_RISICO
   from numeric(9,2)
go

/*==============================================================*/
/* Domain: WERKINSTRUCTIE_PROCEDURE                             */
/*==============================================================*/
create type WERKINSTRUCTIE_PROCEDURE
   from varchar(8000)
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
   constraint PK_ASPECT primary key (ASPECTNAAM),
    constraint CK_ASPECTNAAM check (ASPECTNAAM > '')
)
go

/*==============================================================*/
/* Table: ASPECT_EFFECT                                         */
/*==============================================================*/
create table ASPECT_EFFECT (
   ASPECTNAAM           ASPECTNAAM           not null,
   EFFECTNAAM           EFFECTNAAM           not null,
   constraint PK_ASPECT_EFFECT primary key (ASPECTNAAM, EFFECTNAAM),
    constraint CK_EFFECTNAAM check (EFFECTNAAM > '')
)
go

/*==============================================================*/
/* Index: ASPECT_ASPECT_EFFECT_FK                               */
/*==============================================================*/




create nonclustered index ASPECT_ASPECT_EFFECT_FK on ASPECT_EFFECT (ASPECTNAAM ASC)
go

/*==============================================================*/
/* Index: EFFECT_ASPECT_EFFECT_FK                               */
/*==============================================================*/




create nonclustered index EFFECT_ASPECT_EFFECT_FK on ASPECT_EFFECT (EFFECTNAAM ASC)
go

/*==============================================================*/
/* Table: BEDRIJF                                               */
/*==============================================================*/
create table BEDRIJF (
   BEDRIJFSNAAM         BEDRIJFSNAAM         not null,
   LOCATIE              LOCATIE              not null,
   constraint PK_BEDRIJF primary key (BEDRIJFSNAAM, LOCATIE),
    constraint CK_BEDRIJFNAAM check (BEDRIJFSNAAM > '')
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
/* Table: MACHINEVEILIGHEID                                     */
/*==============================================================*/
create table MACHINEVEILIGHEID (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   PID                  PID                  not null,
   LIJN                 LIJN                 not null,
   MACHINE_CODE         MACHINE_CODE         not null,
   MACHINE              MACHINE              not null,
   MODEL_TYPE           MODEL___TYPE         not null,
   SERIENUMMER          SERIENUMMER          not null,
   LEVERANCIER          LEVERANCIER          not null,
   CE_MARKERING         CE_MARKERING         not null,
   CE_DOCUCHECK         CE_DOCUCHECK         not null,
   AANVULLENDE_OMSCHRIJVING AANVULLENDE_OMSCHRIJVING null,
   TAKEN                TAKEN                null,
   TRANSPORT            KEUZE                not null,
   MONTAGE              KEUZE                not null,
   IN_BEDRIJFSNAME      KEUZE                not null,
   TIJDENS_PRODUCTIE    KEUZE                not null,
   TIJDENS_ONDERHOUD    KEUZE                not null,
   TIJDENS_STORING      KEUZE                not null,
   TIJDENS_REINIGEN     KEUZE                not null,
   TIJDENS_AFSTELLEN    KEUZE                not null,
   DEMONTAGE            KEUZE                not null,
   ONTWERP              ONTWERP              null,
   AFSCHERMING          AFSCHERMING          null,
   INSTRUCTIE           INSTRUCTIE           null,
   FREQUENTIE           FREQUENTIE           not null 
      constraint CKC_FREQUENTIE_MACHINEV check (FREQUENTIE in (1,2,3,4,5)),
   MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS not null 
      constraint CKC_MOGELIJKHEID_OPTR_MACHINEV check (MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS in (1,2,3,4,5)),
   MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE not null 
      constraint CKC_MOGELIJKHEID_VOOR_MACHINEV check (MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE in (1,3,5)),
   CI                   CI                   not null,
   ERNST_VAN_DE_GEVOLGEN ERNST_VAN_DE_GEVOLGEN not null 
      constraint CKC_ERNST_VAN_DE_GEVO_MACHINEV check (ERNST_VAN_DE_GEVOLGEN in (1,2,3,4)),
   constraint PK_MACHINEVEILIGHEID primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Table: PERIODIEKE_BEOORDELING                                */
/*==============================================================*/
create table PERIODIEKE_BEOORDELING (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   DATUM_BEOORDELING    DATUM                not null,
   INSPECTIE_IS_DE_ACTIE_UITGEVOERD INSPECTIE_IS_DE_ACTIE_UITGEVOERD not null,
   OPMERKING_STAND_VAN_ZAKEN OPMERKING_STAND_VAN_ZAKEN null,
   STAND_VAN_ZAKEN      STAND_VAN_ZAKEN      null,
   SCORE                SCORE                null,
   constraint PK_PERIODIEKE_BEOORDELING primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, DATUM_BEOORDELING)
)
go

/*==============================================================*/
/* Index: PLAN_VAN_AANPAK_PERIODIEKE_BEOORDELING_FK             */
/*==============================================================*/




create nonclustered index PLAN_VAN_AANPAK_PERIODIEKE_BEOORDELING_FK on PERIODIEKE_BEOORDELING (PROJECTNUMMER ASC,
  RAPPORTNUMMER ASC,
  REGELNUMMER ASC)
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
   constraint PK_PLAN_VAN_AANPAK primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

/*==============================================================*/
/* Table: PROJECT                                               */
/*==============================================================*/
create table PROJECT (
   PROJECTNUMMER        PROJECTNUMMER      IDENTITY(1,1) not null,
   BEDRIJFSNAAM         BEDRIJFSNAAM         not null,
   LOCATIE              LOCATIE              not null,
   PROJECTOMSCHRIJVING  PROJECTOMSCHRIJVING  not null,
   constraint PK_PROJECT primary key (PROJECTNUMMER),
    constraint CK_PROJECTOMSCHRIJVING check (PROJECTOMSCHRIJVING > '')
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
   RAPPORT_TYPE         RAPPORT_TYPE         not null,
   constraint PK_RAPPORT primary key (PROJECTNUMMER, RAPPORTNUMMER)
)
go

/*==============================================================*/
/* Index: PROJECT_RAPPORT_FK                                    */
/*==============================================================*/




create nonclustered index PROJECT_RAPPORT_FK on RAPPORT (PROJECTNUMMER ASC)
go

/*==============================================================*/
/* Index: RAPPORT_TYPE_RAPPORT_FK                               */
/*==============================================================*/




create nonclustered index RAPPORT_TYPE_RAPPORT_FK on RAPPORT (RAPPORT_TYPE ASC)
go

/*==============================================================*/
/* Table: RAPPORT_TYPE                                          */
/*==============================================================*/
create table RAPPORT_TYPE (
   RAPPORT_TYPE         RAPPORT_TYPE         not null,
   constraint PK_RAPPORT_TYPE primary key (RAPPORT_TYPE)
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
   RISICO_OMSCHRIJVING_OF_BEVINDING RISICO_OMSCHRIJVING_OF_BEVINDING not null,
   HUIDIGE_BEHEERSMAATREGEL HUIDIGE_BEHEERSMAATREGEL null,
   VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL not null,
   VOOR_ERNST_VAN_ONGEVAL VOOR_ERNST_VAN_ONGEVAL not null 
      constraint CKC_VOOR_ERNST_VAN_ON_RISICORE check (VOOR_ERNST_VAN_ONGEVAL in (100,40,15,7,3,1)),
   VOOR_KANS_OP_BLOOTSTELLING VOOR_KANS_OP_BLOOTSTELLING not null 
      constraint CKC_VOOR_KANS_OP_BLOO_RISICORE check (VOOR_KANS_OP_BLOOTSTELLING in (10,6,3,2,1,0.5)),
   VOOR_KANS_OP_WAARSCHIJNLIJKHEID VOOR_KANS_OP_WAARSCHIJNLIJKHEID not null 
      constraint CKC_VOOR_KANS_OP_WAAR_RISICORE check (VOOR_KANS_OP_WAARSCHIJNLIJKHEID in (10,6,3,1,0.5,0.2)),
   VOOR_RISICO          VOOR_RISICO          not null,
   VOOR_PRIORITEIT      VOOR_PRIORITEIT      not null,
   AFWIJKENDE_ACTIE_TER_UITVOERING AFWIJKENDE_ACTIE_TER_UITVOER null,
   RESTRISICO           RESTRISICO           null,
   NA_ERNST_VAN_ONGEVAL VOOR_ERNST_VAN_ONGEVAL not null 
      constraint CKC_NA_ERNST_VAN_ONGE_RISICORE check (NA_ERNST_VAN_ONGEVAL in (100,40,15,7,3,1)),
   NA_KANS_OP_BLOOTSTELLING NA_KANS_OP_BLOOTSTELLING not null 
      constraint CKC_NA_KANS_OP_BLOOTS_RISICORE check (NA_KANS_OP_BLOOTSTELLING in (10,6,3,2,1,0.5)),
   NA_KANS_OP_WAARSCHIJNLIJKHEID NA_KANS_OP_WAARSCHIJNLIJKHEID not null 
      constraint CKC_NA_KANS_OP_WAARSC_RISICORE check (NA_KANS_OP_WAARSCHIJNLIJKHEID in (10,6,3,1,0.5,0.2)),
   NA_RISICO            NA_RISICO            not null,
   NA_PRIORITEIT        NA_PRIORITEIT        not null,
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
/* Index: RISICOREGEL_ASPECT_EFFECT_FK                          */
/*==============================================================*/




create nonclustered index RISICOREGEL_ASPECT_EFFECT_FK on RISICOREGEL (ASPECTNAAM ASC,
  EFFECTNAAM ASC)
go

/*==============================================================*/
/* Table: VISUELE_BEOORDELING                                   */
/*==============================================================*/
create table VISUELE_BEOORDELING (
   PROJECTNUMMER        PROJECTNUMMER        not null,
   RAPPORTNUMMER        RAPPORTNUMMER        not null,
   REGELNUMMER          REGELNUMMER          not null,
   PROCES               PROCES               null 
      constraint CKC_PROCES_VISUELE_ check (PROCES is null or (PROCES >= '1')),
   MACHINE_ONDERDEEL_   MACHINE_ONDERDEEL    null 
      constraint CKC_MACHINE_ONDERDEEL_VISUELE_ check (MACHINE_ONDERDEEL_ is null or (MACHINE_ONDERDEEL_ >= '1')),
   AFDELING             AFDELING             null 
      constraint CKC_AFDELING_VISUELE_ check (AFDELING is null or (AFDELING >= '1')),
   constraint PK_VISUELE_BEOORDELING primary key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
)
go

alter table AFBEELDING
   add constraint FK_AFBEELDI_VISUELE_B_VISUELE_ foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references VISUELE_BEOORDELING (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_ASPECT_AS_ASPECT foreign key (ASPECTNAAM)
      references ASPECT (ASPECTNAAM)
go

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_EFFECT_AS_EFFECT foreign key (EFFECTNAAM)
      references EFFECT (EFFECTNAAM)
go


alter table MACHINEVEILIGHEID
   add constraint FK_MACHINEV_IS_EEN_VI_VISUELE_ foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references VISUELE_BEOORDELING (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
         on update cascade on delete cascade
go

alter table PERIODIEKE_BEOORDELING
   add constraint FK_PERIODIE_PLAN_VAN__PLAN_VAN foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references PLAN_VAN_AANPAK (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table PLAN_VAN_AANPAK
   add constraint FK_PLAN_VAN_RISICOREG_RISICORE foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
go

alter table PROJECT
   add constraint FK_PROJECT_BEDRIJF_P_BEDRIJF foreign key (BEDRIJFSNAAM, LOCATIE)
      references BEDRIJF (BEDRIJFSNAAM, LOCATIE)
go

alter table RAPPORT
   add constraint FK_RAPPORT_PROJECT_R_PROJECT foreign key (PROJECTNUMMER)
      references PROJECT (PROJECTNUMMER)
go

alter table RAPPORT
   add constraint FK_RAPPORT_RAPPORT_T_RAPPORT_ foreign key (RAPPORT_TYPE)
      references RAPPORT_TYPE (RAPPORT_TYPE)
go

alter table RISICOREGEL
   add constraint FK_RISICORE_RAPPORT_R_RAPPORT foreign key (PROJECTNUMMER, RAPPORTNUMMER)
      references RAPPORT (PROJECTNUMMER, RAPPORTNUMMER)
go

alter table RISICOREGEL
   add constraint FK_RISICORE_RISICOREG_ASPECT_E foreign key (ASPECTNAAM, EFFECTNAAM)
      references ASPECT_EFFECT (ASPECTNAAM, EFFECTNAAM)
go

alter table VISUELE_BEOORDELING
   add constraint FK_VISUELE__IS_EEN_RI_RISICORE foreign key (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
      references RISICOREGEL (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER)
         on update cascade on delete cascade
go