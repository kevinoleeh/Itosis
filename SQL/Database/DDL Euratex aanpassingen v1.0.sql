use Euratex

/*==============================================================*/
/* FUNCTIES							                            */
/*==============================================================*/
-- Geeft het risico terug op basis van ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING en KANS_OP_WAARSCHIJNLIJKHEID.
GO
CREATE FUNCTION dbo.FN_GET_RISICO (
	@ERNST_VAN_HET_ONGEVAL NUMERIC(9, 2),
	@KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2)
) RETURNS NUMERIC(9, 2) AS BEGIN
	RETURN (@ERNST_VAN_HET_ONGEVAL * @KANS_OP_BLOOTSTELLING * @KANS_OP_WAARSCHIJNLIJKHEID)
END
GO

-- Geeft de prioriteit van een risico terug.
GO
CREATE FUNCTION dbo.FN_GET_PRIORITEIT (
	@RISICO NUMERIC(9, 2)
) RETURNS VARCHAR(255) AS BEGIN
	DECLARE @PRIORITEIT VARCHAR(255)

	IF(@RISICO <= 20) BEGIN
		SET @PRIORITEIT = 'P 5'
	END ELSE IF(@RISICO >= 21 AND @RISICO <= 75) BEGIN
		SET @PRIORITEIT = 'P 4'
	END ELSE IF(@RISICO >= 76 AND @RISICO <= 200) BEGIN
		SET @PRIORITEIT = 'P 3'
	END ELSE IF(@RISICO >= 201 AND @RISICO <= 400) BEGIN
		SET @PRIORITEIT = 'P 2'
	END ELSE BEGIN
		SET @PRIORITEIT = 'P 1'
	END

	RETURN @PRIORITEIT
END
GO

-- Geeft maximaal rapportnummer + 1 terug
GO
CREATE FUNCTION dbo.FN_GET_NEW_RAPPORTNUMMER (
	@PROJECTNUMMER INT
) RETURNS INT AS BEGIN
	RETURN (
		SELECT ISNULL(MAX(RAPPORTNUMMER), 0) + 1
		FROM RAPPORT
		WHERE PROJECTNUMMER = @PROJECTNUMMER
	)
END
GO

-- Geeft maximaal regelnummer + 1 terug
GO
CREATE FUNCTION dbo.FN_GET_NEW_REGELNUMMER (
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT
) RETURNS INT AS BEGIN
	RETURN (
		SELECT ISNULL(MAX(REGELNUMMER), 0) + 1
		FROM RISICOREGEL
		WHERE PROJECTNUMMER = @PROJECTNUMMER
		AND RAPPORTNUMMER = @RAPPORTNUMMER
	)
END
GO

/*==============================================================*/
/* KOLOMMEN							                            */
/*==============================================================*/
-- Voor

alter table RISICOREGEL
drop column VOOR_RISICO

alter table RISICOREGEL
add VOOR_RISICO AS dbo.FN_GET_RISICO(VOOR_ERNST_VAN_HET_ONGEVAL, VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID)

alter table RISICOREGEL
drop column VOOR_PRIORITEIT

alter table RISICOREGEL
add VOOR_PRIORITEIT AS dbo.FN_GET_PRIORITEIT(dbo.FN_GET_RISICO(VOOR_ERNST_VAN_HET_ONGEVAL, VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID))

-- Na

alter table RISICOREGEL
drop column NA_RISICO

alter table RISICOREGEL
add NA_RISICO AS dbo.FN_GET_RISICO(VOOR_ERNST_VAN_HET_ONGEVAL, VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID)

alter table RISICOREGEL
drop column NA_PRIORITEIT

alter table RISICOREGEL
add NA_PRIORITEIT AS dbo.FN_GET_PRIORITEIT(dbo.FN_GET_RISICO(VOOR_ERNST_VAN_HET_ONGEVAL, VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID))

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PROJECT') and o.name = 'FK_PROJECT_BEDRIJF_P_BEDRIJF')
alter table PROJECT
   drop constraint FK_PROJECT_BEDRIJF_P_BEDRIJF
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

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_ASPECT_EF_ASPECT foreign key (ASPECTNAAM)
      references ASPECT (ASPECTNAAM)
         on update cascade on delete cascade
go

alter table ASPECT_EFFECT
   add constraint FK_ASPECT_E_ASPECT_EF_EFFECT foreign key (EFFECTNAAM)
      references EFFECT (EFFECTNAAM)
         on update cascade on delete cascade
go

alter table PROJECT
   add constraint FK_PROJECT_BEDRIJF_P_BEDRIJF foreign key (BEDRIJFSNAAM, LOCATIE)
      references BEDRIJF (BEDRIJFSNAAM, LOCATIE)
         on update cascade
go

use master
