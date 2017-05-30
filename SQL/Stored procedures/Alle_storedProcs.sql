

   /*=========================================*/
  /*	Drop alle stored procedures			       */
 /*											                    */
/*=========================================*/

IF OBJECT_ID('SP_DELETE_ASPECT', 'P') IS NOT NULL
DROP PROC SP_DELETE_ASPECT
GO
IF OBJECT_ID('SP_DELETE_BEDRIJF', 'P') IS NOT NULL
DROP PROC SP_DELETE_BEDRIJF
GO

IF OBJECT_ID('SP_UPDATE_PERIODIEKE_BEOORDELING', 'P') IS NOT NULL
DROP PROC SP_UPDATE_PERIODIEKE_BEOORDELING
GO

IF OBJECT_ID('SP_INSERT_PERIODIEKE_BEOORDELING', 'P') IS NOT NULL
DROP PROC SP_INSERT_PERIODIEKE_BEOORDELING
GO

IF OBJECT_ID('SP_UPDATE_PLAN_VAN_AANPAK', 'P') IS NOT NULL
DROP PROC SP_UPDATE_PLAN_VAN_AANPAK
GO

IF OBJECT_ID('SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT', 'P') IS NOT NULL
DROP PROC SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
GO

IF OBJECT_ID('SP_DELETE_PROJECT', 'P') IS NOT NULL
DROP PROC SP_DELETE_PROJECT
GO

IF OBJECT_ID('SP_INSERT_ASPECT_EFFECT_EFFECT', 'P') IS NOT NULL
DROP PROC SP_INSERT_ASPECT_EFFECT_EFFECT
GO

IF OBJECT_ID('SP_INSERT_ASPECT_EFFECT', 'P') IS NOT NULL
DROP PROC SP_INSERT_ASPECT_EFFECT
GO
IF OBJECT_ID('SP_INSERT_ASPECT', 'P') IS NOT NULL
DROP PROC SP_INSERT_ASPECT
GO

IF OBJECT_ID('SP_INSERT_BEDRIJF', 'P') IS NOT NULL
DROP PROC SP_INSERT_BEDRIJF
GO
IF OBJECT_ID('SP_INSERT_EFFECT', 'P') IS NOT NULL
DROP PROC SP_INSERT_EFFECT
GO
IF OBJECT_ID('SP_INSERT_ORGANISATIE_RISICOREGEL', 'P') IS NOT NULL
DROP PROC SP_INSERT_ORGANISATIE_RISICOREGEL

IF OBJECT_ID('SP_INSERT_PROJECT', 'P') IS NOT NULL
DROP PROC SP_INSERT_PROJECT
GO
IF OBJECT_ID('SP_INSERT_RAPPORT', 'P') IS NOT NULL
DROP PROC SP_INSERT_RAPPORT
GO
IF OBJECT_ID('SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL', 'P') IS NOT NULL
DROP PROC SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
GO
IF OBJECT_ID('SP_UPDATE_ASPECT', 'P') IS NOT NULL
DROP PROC SP_UPDATE_ASPECT
GO
IF OBJECT_ID('SP_UPDATE_BEDRIJF', 'P') IS NOT NULL
DROP PROC SP_UPDATE_BEDRIJF
GO
IF OBJECT_ID('SP_UPDATE_EFFECT', 'P') IS NOT NULL
DROP PROC SP_UPDATE_EFFECT
GO
IF OBJECT_ID('SP_INSERT_PLAN_VAN_AANPAK', 'P') IS NOT NULL
DROP PROC SP_INSERT_PLAN_VAN_AANPAK
GO
IF OBJECT_ID('SP_UPDATE_ORGANISATIE_RISICOREGEL', 'P') IS NOT NULL
DROP PROC SP_UPDATE_ORGANISATIE_RISICOREGEL
GO
IF OBJECT_ID('SP_UPDATE_PROJECT', 'P') IS NOT NULL
DROP PROC SP_UPDATE_PROJECT
GO
IF OBJECT_ID('SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL', 'P') IS NOT NULL
DROP PROC SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
GO




   /*=========================================*/
  /*	Create alle stored procedures		        */
 /*											                    */
/*=========================================*/


CREATE PROCEDURE SP_INSERT_EFFECT
	@Effect       VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		INSERT INTO EFFECT(EFFECTNAAM)
		VALUES (@effect)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_DELETE_ASPECT
		@ASPECTNAAM as VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		BEGIN
		DELETE FROM ASPECT_EFFECT
		WHERE ASPECTNAAM = @ASPECTNAAM
		END

		BEGIN
		DELETE from ASPECT
		WHERE ASPECTNAAM = @ASPECTNAAM
		END
		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_DELETE_BEDRIJF
		@Bedrijfsnaam        VARCHAR(255),
		@Locatie             VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		DELETE FROM BEDRIJF
			WHERE LOCATIE = @Locatie AND BEDRIJFSNAAM = @Bedrijfsnaam
		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
		@ASPECTNAAM as Varchar(255),
		@EFFECTNAAM as varchar(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY

		--1. Delete project
		DELETE from ASPECT_EFFECT
		WHERE ASPECTNAAM = @ASPECTNAAM AND EFFECTNAAM = @EFFECTNAAM

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_DELETE_PROJECT
		@PROJECTNUMMER as INT
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY

		--1. Delete project
		DELETE from PROJECT
		WHERE PROJECTNUMMER = @PROJECTNUMMER

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_ASPECT_EFFECT_EFFECT
	@Aspect		  VARCHAR(255),
	@Effect       VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY

		BEGIN
		execute SP_INSERT_EFFECT @Effect
		END
		BEGIN
		INSERT INTO ASPECT_EFFECT(ASPECTNAAM,EFFECTNAAM)
		VALUES (@Aspect, @effect)
		END


		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_ASPECT_EFFECT
	@Aspect		  VARCHAR(255),
	@Effect       VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		INSERT INTO ASPECT_EFFECT(ASPECTNAAM,EFFECTNAAM)
		VALUES (@Aspect, @effect)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_ASPECT
	@Aspect       VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		INSERT INTO ASPECT(ASPECTNAAM)
		VALUES (@Aspect)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_BEDRIJF
		@Bedrijfsnaam        VARCHAR(255),
		@Locatie             VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		INSERT INTO BEDRIJF (BEDRIJFSNAAM, LOCATIE)
		VALUES (@Bedrijfsnaam, @Locatie)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO

/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_ORGANISATIE_RISICOREGEL
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT,
	@ASPECTNAAM VARCHAR(255),
	@EFFECTNAAM VARCHAR(255),
	@ARBO_ONDERWERP VARCHAR(255),
	@RISICO_OMSCHRIJVING_OF_BEVINDING VARCHAR(255),
	@HUIDIGE_BEHEERSMAATREGEL VARCHAR(255),
	@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VARCHAR(255),
	@AFWIJKENDE_ACTIE_TER_UITVOERING VARCHAR(255),
	@RESTRISICO VARCHAR(255),
	@VOOR_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@VOOR_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@VOOR_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@NA_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@NA_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@NA_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			AND RAPPORTNUMMER = @RAPPORTNUMMER
		) BEGIN
			IF EXISTS (
				SELECT 1
				FROM RAPPORT
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND RAPPORT_TYPE = 'Organisatie'
			) BEGIN
				DECLARE @REGELNUMMER INT = (
					SELECT ISNULL(MAX(REGELNUMMER), 0) + 1
					FROM RISICOREGEL
					WHERE PROJECTNUMMER = @PROJECTNUMMER
					AND RAPPORTNUMMER = @RAPPORTNUMMER
				)

				INSERT RISICOREGEL
				VALUES (
					@PROJECTNUMMER,
					@RAPPORTNUMMER,
					@REGELNUMMER,
					@ASPECTNAAM,
					@EFFECTNAAM,
					@ARBO_ONDERWERP,
					@RISICO_OMSCHRIJVING_OF_BEVINDING,
					@HUIDIGE_BEHEERSMAATREGEL,
					@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
					@VOOR_ERNST_VAN_ONGEVAL,
					@VOOR_KANS_OP_BLOOTSTELLING,
					@VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
					@AFWIJKENDE_ACTIE_TER_UITVOERING,
					@RESTRISICO,
					@NA_ERNST_VAN_ONGEVAL,
					@NA_KANS_OP_BLOOTSTELLING,
					@NA_KANS_OP_WAARSCHIJNLIJKHEID
				)
			END ELSE BEGIN
				RAISERROR('Om deze SP te gebruiken moet RAPPORT.RAPPORT_TYPE "Organisatie" zijn.', 16, 1)
			END
		END ELSE BEGIN
			RAISERROR('Projectnummer en/of rapportnummer bestaat niet.', 16, 1)
		END

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
	END CATCH
END
GO

/*=================================================================================================*/

CREATE PROCEDURE SP_INSERT_PLAN_VAN_AANPAK
@PROJECTNUMMER int,
@RAPPORTNUMMER int,
@REGELNUMMER int,
@UITGEVOERD_DOOR varchar(255),
@EINDVERANTWOORDELIJKE varchar(255),
@DATUM_GEREED_GEPLAND date,
@PBM varchar(255),
@VOORLICHTING varchar(255),
@WERKINSTRUCTIE_PROCEDURE varchar(255),
@TRA varchar(255),
@CONTRACT_LIJST_ varchar(255)
AS
BEGIN
  SET NOCOUNT, XACT_ABORT ON

  DECLARE @TranCounter int;

  SET @TranCounter = @@TRANCOUNT;

  IF @TranCounter > 0
    SAVE TRANSACTION proceduresave;
  ELSE
    BEGIN TRANSACTION;

    BEGIN TRY
      IF EXISTS (SELECT
          1
        FROM RISICOREGEL
        WHERE projectnummer = @PROJECTNUMMER
        AND rapportnummer = @RAPPORTNUMMER
        AND regelnummer = @REGELNUMMER)
      BEGIN
        INSERT plan_van_aanpak
        VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @UITGEVOERD_DOOR, @EINDVERANTWOORDELIJKE, @DATUM_GEREED_GEPLAND, @PBM, @VOORLICHTING, @WERKINSTRUCTIE_PROCEDURE, @TRA, @CONTRACT_LIJST_)
      END
      ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient de combinatie projectnummer+rapportnummer+regelnummer te bestaan.', 16, 1)
      END

      IF @TranCounter = 0
        AND XACT_STATE() = 1
      COMMIT TRANSACTION;
  END TRY

  BEGIN CATCH
    IF @TranCounter = 0
    BEGIN
      IF XACT_STATE() = 1
        ROLLBACK TRANSACTION;
    END;
    ELSE
    BEGIN
      IF XACT_STATE() <> -1
        ROLLBACK TRANSACTION proceduresave;
    END;

    THROW
  END CATCH
END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_PROJECT
		@Bedrijfsnaam        VARCHAR(255),
		@Locatie             VARCHAR(255),
		@ProjectOmschrijving VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project insert
		INSERT INTO PROJECT (BEDRIJFSNAAM, LOCATIE, PROJECTOMSCHRIJVING)
		VALUES (@Bedrijfsnaam, @Locatie, @ProjectOmschrijving)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_RAPPORT
		@PROJECTNUMMER      INT,
		@RAPPORT_TYPE		VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--Ophoging rapportnummer
				DECLARE @RAPPORTNUMMER INT = (
			SELECT ISNULL(MAX(RAPPORTNUMMER), 0) + 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER)


		--1. Project insert
		INSERT INTO RAPPORT(RAPPORTNUMMER,PROJECTNUMMER,RAPPORT_TYPE)
		VALUES (@RAPPORTNUMMER, @PROJECTNUMMER, @RAPPORT_TYPE)

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO

/*=================================================================================================*/
CREATE PROCEDURE SP_INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT,
	@ASPECTNAAM VARCHAR(255),
	@EFFECTNAAM VARCHAR(255),
	@ARBO_ONDERWERP VARCHAR(255),
	@RISICO_OMSCHRIJVING_OF_BEVINDING VARCHAR(255),
	@HUIDIGE_BEHEERSMAATREGEL VARCHAR(255),
	@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VARCHAR(255),
	@AFWIJKENDE_ACTIE_TER_UITVOERING VARCHAR(255),
	@RESTRISICO VARCHAR(255),
	@PROCES VARCHAR(255),
	@MACHINE_ONDERDEEL VARCHAR(255),
	@AFDELING VARCHAR(255),
	@VOOR_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@VOOR_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@VOOR_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@NA_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@NA_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@NA_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			AND RAPPORTNUMMER = @RAPPORTNUMMER
		) BEGIN
			IF EXISTS (
				SELECT 1
				FROM RAPPORT
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND RAPPORT_TYPE = 'Visuele beoordeling'
			) BEGIN
				DECLARE @REGELNUMMER INT = (
					SELECT ISNULL(MAX(REGELNUMMER), 0) + 1
					FROM RISICOREGEL
					WHERE PROJECTNUMMER = @PROJECTNUMMER
					AND RAPPORTNUMMER = @RAPPORTNUMMER
				)

				INSERT RISICOREGEL
				VALUES (
					@PROJECTNUMMER,
					@RAPPORTNUMMER,
					@REGELNUMMER,
					@ASPECTNAAM,
					@EFFECTNAAM,
					@ARBO_ONDERWERP,
					@RISICO_OMSCHRIJVING_OF_BEVINDING,
					@HUIDIGE_BEHEERSMAATREGEL,
					@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
					@VOOR_ERNST_VAN_ONGEVAL,
					@VOOR_KANS_OP_BLOOTSTELLING,
					@VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
					@AFWIJKENDE_ACTIE_TER_UITVOERING,
					@RESTRISICO,
					@NA_ERNST_VAN_ONGEVAL,
					@NA_KANS_OP_BLOOTSTELLING,
					@NA_KANS_OP_WAARSCHIJNLIJKHEID
				)

				INSERT VISUELE_BEOORDELING
				VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @PROCES, @MACHINE_ONDERDEEL, @AFDELING)
			END ELSE BEGIN
				RAISERROR('Om deze SP te gebruiken moet RAPPORT.RAPPORT_TYPE "Visuele beoordeling" zijn.', 16, 1)
			END
		END ELSE BEGIN
			RAISERROR('Projectnummer en/of rapportnummer bestaat niet.', 16, 1)
		END

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
	END CATCH
END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_UPDATE_ASPECT
		@ASPECTNAAMOLD        VARCHAR(255),
		@ASPECTNAAMNEW		 VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY


		UPDATE ASPECT
		SET ASPECTNAAM = @ASPECTNAAMNEW
		WHERE ASPECTNAAM = @ASPECTNAAMOLD

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_UPDATE_BEDRIJF
		@Bedrijfsnaam        VARCHAR(255),
		@Locatie             VARCHAR(255),
		@uBedrijfsnaam       VARCHAR(255),
		@uLocatie            VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY
		--1. Project Update
		UPDATE BEDRIJF SET BEDRIJFSNAAM = @uBedrijfsnaam, LOCATIE = @uLocatie
		WHERE BEDRIJFSNAAM = @Bedrijfsnaam AND LOCATIE = @Locatie
		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_UPDATE_EFFECT
		@EFFECTNAAMOLD        VARCHAR(255),
		@EFFECTNAAMNEW		 VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY


		UPDATE EFFECT
		SET EFFECTNAAM = @EFFECTNAAMNEW
		WHERE EFFECTNAAM = @EFFECTNAAMOLD

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO
/*=================================================================================================*/

CREATE PROCEDURE SP_UPDATE_ORGANISATIE_RISICOREGEL
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT,
	@REGELNUMMER INT,
	@ASPECTNAAM VARCHAR(255),
	@EFFECTNAAM VARCHAR(255),
	@ARBO_ONDERWERP VARCHAR(255),
	@RISICO_OMSCHRIJVING_OF_BEVINDING VARCHAR(255),
	@HUIDIGE_BEHEERSMAATREGEL VARCHAR(255),
	@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VARCHAR(255),
	@AFWIJKENDE_ACTIE_TER_UITVOERING VARCHAR(255),
	@RESTRISICO VARCHAR(255),
	@VOOR_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@VOOR_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@VOOR_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@NA_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@NA_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@NA_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM RISICOREGEL
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			AND RAPPORTNUMMER = @RAPPORTNUMMER
			AND REGELNUMMER = @REGELNUMMER
		) BEGIN
			IF EXISTS (
				SELECT 1
				FROM RAPPORT
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND RAPPORT_TYPE = 'Organisatie'
			) BEGIN
				UPDATE RISICOREGEL
				SET ASPECTNAAM = @ASPECTNAAM,
					EFFECTNAAM = @EFFECTNAAM,
					ARBO_ONDERWERP = @ARBO_ONDERWERP,
					RISICO_OMSCHRIJVING_OF_BEVINDING = @RISICO_OMSCHRIJVING_OF_BEVINDING,
					HUIDIGE_BEHEERSMAATREGEL = @HUIDIGE_BEHEERSMAATREGEL,
					VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL = @VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
					VOOR_ERNST_VAN_ONGEVAL = @VOOR_ERNST_VAN_ONGEVAL,
					VOOR_KANS_OP_BLOOTSTELLING = @VOOR_KANS_OP_BLOOTSTELLING,
					VOOR_KANS_OP_WAARSCHIJNLIJKHEID = @VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
					AFWIJKENDE_ACTIE_TER_UITVOERING = @AFWIJKENDE_ACTIE_TER_UITVOERING,
					RESTRISICO = @RESTRISICO,
					NA_ERNST_VAN_ONGEVAL = @NA_ERNST_VAN_ONGEVAL,
					NA_KANS_OP_BLOOTSTELLING = @NA_KANS_OP_BLOOTSTELLING,
					NA_KANS_OP_WAARSCHIJNLIJKHEID = @NA_KANS_OP_WAARSCHIJNLIJKHEID
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND REGELNUMMER = @REGELNUMMER
			END ELSE BEGIN
				RAISERROR('Om deze SP te gebruiken moet RAPPORT.RAPPORT_TYPE "Organisatie" zijn.', 16, 1)
			END
		END ELSE BEGIN
			RAISERROR('Projectnummer en/of rapportnummer en/of regelnummer bestaat niet.', 16, 1)
		END

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
	END CATCH
END
GO
/*=================================================================================================*/
CREATE PROCEDURE SP_UPDATE_PROJECT
		@Projectnummer        VARCHAR(255),
		@ProjectOmschrijving VARCHAR(255)
AS
	BEGIN
		SET NOCOUNT, XACT_ABORT ON
		DECLARE @TranCounter INT;
		SET @TranCounter = @@TRANCOUNT;

		IF @TranCounter > 0
			SAVE TRANSACTION ProcedureSave;
		ELSE
			BEGIN TRANSACTION;

		BEGIN TRY

		--1. Project update
		UPDATE PROJECT
		SET PROJECTOMSCHRIJVING = @ProjectOmschrijving
		WHERE PROJECTNUMMER = @Projectnummer

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
		END TRY
		BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
		END CATCH
	END
GO

/*=================================================================================================*/

CREATE PROCEDURE SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT,
	@REGELNUMMER INT,
	@ASPECTNAAM VARCHAR(255),
	@EFFECTNAAM VARCHAR(255),
	@ARBO_ONDERWERP VARCHAR(255),
	@RISICO_OMSCHRIJVING_OF_BEVINDING VARCHAR(255),
	@HUIDIGE_BEHEERSMAATREGEL VARCHAR(255),
	@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VARCHAR(255),
	@AFWIJKENDE_ACTIE_TER_UITVOERING VARCHAR(255),
	@RESTRISICO VARCHAR(255),
	@PROCES VARCHAR(255),
	@MACHINE_ONDERDEEL VARCHAR(255),
	@AFDELING VARCHAR(255),
	@VOOR_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@VOOR_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@VOOR_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@NA_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@NA_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@NA_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		IF EXISTS (
			SELECT 1
			FROM RISICOREGEL
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			AND RAPPORTNUMMER = @RAPPORTNUMMER
			AND REGELNUMMER = @REGELNUMMER
		) BEGIN
			IF EXISTS (
				SELECT 1
				FROM RAPPORT
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND RAPPORT_TYPE = 'Visuele beoordeling'
			) BEGIN
				UPDATE RISICOREGEL
				SET ASPECTNAAM = @ASPECTNAAM,
					EFFECTNAAM = @EFFECTNAAM,
					ARBO_ONDERWERP = @ARBO_ONDERWERP,
					RISICO_OMSCHRIJVING_OF_BEVINDING = @RISICO_OMSCHRIJVING_OF_BEVINDING,
					HUIDIGE_BEHEERSMAATREGEL = @HUIDIGE_BEHEERSMAATREGEL,
					VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL = @VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
					VOOR_ERNST_VAN_ONGEVAL = @VOOR_ERNST_VAN_ONGEVAL,
					VOOR_KANS_OP_BLOOTSTELLING = @VOOR_KANS_OP_BLOOTSTELLING,
					VOOR_KANS_OP_WAARSCHIJNLIJKHEID = @VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
					AFWIJKENDE_ACTIE_TER_UITVOERING = @AFWIJKENDE_ACTIE_TER_UITVOERING,
					RESTRISICO = @RESTRISICO,
					NA_ERNST_VAN_ONGEVAL = @NA_ERNST_VAN_ONGEVAL,
					NA_KANS_OP_BLOOTSTELLING = @NA_KANS_OP_BLOOTSTELLING,
					NA_KANS_OP_WAARSCHIJNLIJKHEID = @NA_KANS_OP_WAARSCHIJNLIJKHEID
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND REGELNUMMER = @REGELNUMMER

				UPDATE VISUELE_BEOORDELING
				SET PROCES = @PROCES,
					MACHINE_ONDERDEEL_ = @MACHINE_ONDERDEEL,
					AFDELING = @AFDELING
				WHERE PROJECTNUMMER = @PROJECTNUMMER
				AND RAPPORTNUMMER = @RAPPORTNUMMER
				AND REGELNUMMER = REGELNUMMER
			END ELSE BEGIN
				RAISERROR('Om deze SP te gebruiken moet RAPPORT.RAPPORT_TYPE "Visuele beoordeling" zijn.', 16, 1)
			END
		END ELSE BEGIN
			RAISERROR('Projectnummer en/of rapportnummer en/of regelnummer bestaat niet.', 16, 1)
		END

		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
	END TRY
	BEGIN CATCH
		IF @TranCounter = 0
			BEGIN
				IF XACT_STATE() = 1
					ROLLBACK TRANSACTION;
			END;
		ELSE
			BEGIN
				IF XACT_STATE() <> -1
					ROLLBACK TRANSACTION ProcedureSave;
			END;
		THROW
	END CATCH
END
GO

/*=================================================================================================*/
GO

CREATE PROCEDURE SP_UPDATE_PLAN_VAN_AANPAK
@PROJECTNUMMER int,
@RAPPORTNUMMER int,
@REGELNUMMER int,
@UITGEVOERD_DOOR varchar(255),
@EINDVERANTWOORDELIJKE varchar(255),
@DATUM_GEREED_GEPLAND date,
@PBM varchar(255),
@VOORLICHTING varchar(255),
@WERKINSTRUCTIE_PROCEDURE varchar(255),
@TRA varchar(255),
@CONTRACT_LIJST_ varchar(255)
AS
BEGIN
  SET NOCOUNT, XACT_ABORT ON

  DECLARE @TranCounter int;

  SET @TranCounter = @@TRANCOUNT;

  IF @TranCounter > 0
    SAVE TRANSACTION proceduresave;
  ELSE
    BEGIN TRANSACTION;

    BEGIN TRY
      IF EXISTS (SELECT
          1
        FROM PLAN_VAN_AANPAK
        WHERE projectnummer = @PROJECTNUMMER
        AND rapportnummer = @RAPPORTNUMMER
        AND regelnummer = @REGELNUMMER)
      BEGIN
        UPDATE PLAN_VAN_AANPAK
        SET projectnummer = @PROJECTNUMMER, rapportnummer = @RAPPORTNUMMER, regelnummer = @REGELNUMMER, uitgevoerd_door = @UITGEVOERD_DOOR, eindverantwoordelijke = @EINDVERANTWOORDELIJKE, datum_gereed_gepland = @DATUM_GEREED_GEPLAND,PBM = @PBM, voorlichting = @VOORLICHTING, werkinstructie_procedure = @WERKINSTRUCTIE_PROCEDURE, TRA = @TRA, contract_lijst_ = @CONTRACT_LIJST_
        WHERE projectnummer = @PROJECTNUMMER AND rapportnummer = @RAPPORTNUMMER AND regelnummer = @REGELNUMMER
      END
      ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient de combinatie projectnummer+rapportnummer+regelnummer te bestaan.', 16, 1)
      END

      IF @TranCounter = 0
        AND XACT_STATE() = 1
      COMMIT TRANSACTION;
  END TRY

  BEGIN CATCH
    IF @TranCounter = 0
    BEGIN
      IF XACT_STATE() = 1
        ROLLBACK TRANSACTION;
    END;
    ELSE
    BEGIN
      IF XACT_STATE() <> -1
        ROLLBACK TRANSACTION proceduresave;
    END;

    THROW
  END CATCH
END
GO
/*=================================================================================================*/

GO

CREATE PROCEDURE SP_INSERT_PERIODIEKE_BEOORDELING
    @PROJECTNUMMER int,
    @RAPPORTNUMMER int,
    @REGELNUMMER int,
    @DATUM_BEOORDELING date,
    @INSPECTIE_IS_DE_ACTIE_UITGEVOERD bit,
    @OPMERKING_STAND_VAN_ZAKEN text,
    @STAND_VAN_ZAKEN varchar(255),
    @SCORE numeric
AS
  BEGIN
    SET NOCOUNT, XACT_ABORT ON

    DECLARE @TranCounter int;

    SET @TranCounter = @@TRANCOUNT;

    IF @TranCounter > 0
      SAVE TRANSACTION proceduresave;
    ELSE
      BEGIN TRANSACTION;

    BEGIN TRY
    IF EXISTS (SELECT
                 1
               FROM PLAN_VAN_AANPAK
               WHERE projectnummer = @PROJECTNUMMER
                     AND rapportnummer = @RAPPORTNUMMER
                     AND regelnummer = @REGELNUMMER)
      BEGIN
        INSERT PERIODIEKE_BEOORDELING
        VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @DATUM_BEOORDELING, @INSPECTIE_IS_DE_ACTIE_UITGEVOERD, @OPMERKING_STAND_VAN_ZAKEN, @STAND_VAN_ZAKEN, @SCORE)
	  END
    ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient het plan van aanpak te bestaan.', 16, 1)
      END

    IF @TranCounter = 0
       AND XACT_STATE() = 1
      COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
    IF @TranCounter = 0
      BEGIN
        IF XACT_STATE() = 1
          ROLLBACK TRANSACTION;
      END;
    ELSE
      BEGIN
        IF XACT_STATE() <> -1
          ROLLBACK TRANSACTION proceduresave;
      END;

    THROW
    END CATCH
  END
GO

/*=================================================================================================*/

GO

CREATE PROCEDURE SP_UPDATE_PERIODIEKE_BEOORDELING
    @PROJECTNUMMER int,
    @RAPPORTNUMMER int,
    @REGELNUMMER int,
    @DATUM_BEOORDELING date,
    @INSPECTIE_IS_DE_ACTIE_UITGEVOERD bit,
    @OPMERKING_STAND_VAN_ZAKEN text,
    @STAND_VAN_ZAKEN varchar(255),
    @SCORE numeric
AS
  BEGIN
    SET NOCOUNT, XACT_ABORT ON

    DECLARE @TranCounter int;

    SET @TranCounter = @@TRANCOUNT;

    IF @TranCounter > 0
      SAVE TRANSACTION proceduresave;
    ELSE
      BEGIN TRANSACTION;

    BEGIN TRY
    IF EXISTS (SELECT
                 1
               FROM PERIODIEKE_BEOORDELING
               WHERE projectnummer = @PROJECTNUMMER
                     AND rapportnummer = @RAPPORTNUMMER
                     AND regelnummer = @REGELNUMMER
					 AND datum_beoordeling = @DATUM_BEOORDELING)
      BEGIN
        UPDATE PERIODIEKE_BEOORDELING
        SET inspectie_is_de_actie_uitgevoerd = @INSPECTIE_IS_DE_ACTIE_UITGEVOERD, opmerking_stand_van_zaken = @OPMERKING_STAND_VAN_ZAKEN, stand_van_zaken = @STAND_VAN_ZAKEN, score = @SCORE
		WHERE projectnummer = @PROJECTNUMMER
                     AND rapportnummer = @RAPPORTNUMMER
                     AND regelnummer = @REGELNUMMER
					 AND datum_beoordeling = @DATUM_BEOORDELING
	  END
    ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient het desbetreffende periodieke beoordeling te bestaan.', 16, 1)
      END

    IF @TranCounter = 0
       AND XACT_STATE() = 1
      COMMIT TRANSACTION;
    END TRY

    BEGIN CATCH
    IF @TranCounter = 0
      BEGIN
        IF XACT_STATE() = 1
          ROLLBACK TRANSACTION;
      END;
    ELSE
      BEGIN
        IF XACT_STATE() <> -1
          ROLLBACK TRANSACTION proceduresave;
      END;

    THROW
    END CATCH
  END
GO