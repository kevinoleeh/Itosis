GO
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
	@MACHINE VARCHAR(255),
	@MODEL___TYPE VARCHAR(255),
	@SERIENUMMER VARCHAR(255),
	@LEVERANCIER VARCHAR(255),
	@CE_MARKERING VARCHAR(255),
	@CE_DOCUCHECK VARCHAR(255),
	@TRANSPORT BIT,
	@MONTAGE BIT,
	@IN_BEDRIJFSNAME BIT,
	@TIJDENS_PRODUCTIE BIT,
	@TIJDENS_ONDERHOUD BIT,
	@TIJDENS_STORING BIT,
	@TIJDENS_REINIGEN BIT,
	@TIJDENS_AFSTELLEN BIT,
	@DEMONTAGE BIT,
	@FREQUENTIE NUMERIC(9, 2),
	@MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS NUMERIC(9, 2),
	@MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE NUMERIC(9, 2),
	@ERNST_VAN_DE_GEVOLGEN NUMERIC(9, 2)
AS BEGIN
	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	-- Phantom mogelijk bij:
	-- EXISTS
	-- dbo.FN_GET_NEW_REGELNUMMER(@PROJECTNUMMER, @RAPPORTNUMMER)

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
				INSERT RISICOREGEL
				VALUES (
					@PROJECTNUMMER, 
					@RAPPORTNUMMER, 
					dbo.FN_GET_NEW_REGELNUMMER(@PROJECTNUMMER, @RAPPORTNUMMER), 
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

				-- Insert nieuwe tabel...
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