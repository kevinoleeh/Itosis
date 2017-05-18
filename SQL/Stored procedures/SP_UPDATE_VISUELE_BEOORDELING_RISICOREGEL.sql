GO
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
					VOOR_ERNST_VAN_HET_ONGEVAL = @VOOR_ERNST_VAN_ONGEVAL,
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