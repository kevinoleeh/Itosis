GO
CREATE PROCEDURE INSERT_VISUELE_BEOORDELING_RISICOREGEL
	@PROJECTNUMMER INT,
	@RAPPORTNUMMER INT,
	@ASPECTNAAM VARCHAR(255),
	@EFFECTNAAM VARCHAR(255),
	@ARBO_ONDERWERP VARCHAR(255),
	@HUIDIGE_BEHEERSMAATREGEL VARCHAR(255),
	@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL VARCHAR(255),
	@AFWIJKENDE_ACTIE_TER_UITVOERING VARCHAR(255),
	@REST_RISICO VARCHAR(255),
	@VOOR_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@VOOR_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@VOOR_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@NA_ERNST_VAN_ONGEVAL NUMERIC(9, 2),
	@NA_KANS_OP_BLOOTSTELLING NUMERIC(9, 2),
	@NA_KANS_OP_WAARSCHIJNLIJKHEID NUMERIC(9, 2),
	@PROCES VARCHAR(255),
	@MACHINE_ONDERDEEL VARCHAR(255),
	@AFDELING VARCHAR(255)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		DECLARE @REGELNUMMER INT = (
			SELECT MAX(REGELNUMMER) + 1
			FROM RISICOREGEL
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			AND RAPPORTNUMMER = @RAPPORTNUMMER
		)

		-- 1. Basis van een regel.
		INSERT RISICOREGEL
		VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @ASPECTNAAM, @EFFECTNAAM, @ARBO_ONDERWERP, @HUIDIGE_BEHEERSMAATREGEL)

		-- 2. Fine en Kinney die bij de risicoregel hoort.
		INSERT FINE_EN_KINNEY (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, FINE_EN_KINNEY_TYPE, ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID)
		VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, 'Voor', @VOOR_ERNST_VAN_ONGEVAL, @VOOR_KANS_OP_BLOOTSTELLING, @VOOR_KANS_OP_WAARSCHIJNLIJKHEID)

		-- 3. Maatregel die bij de regel hoort.
		INSERT RISICOMAATREGEL
		VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL, @AFWIJKENDE_ACTIE_TER_UITVOERING, @REST_RISICO)

		-- 4. Fine en Kinney die bij de risicomaatregel hoort.
		INSERT FINE_EN_KINNEY (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, FINE_EN_KINNEY_TYPE, ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID)
		VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, 'Na', @NA_ERNST_VAN_ONGEVAL, @NA_KANS_OP_BLOOTSTELLING, @NA_KANS_OP_WAARSCHIJNLIJKHEID)

		-- 5. Onderdeel van de visuele beoordeling.
		INSERT VISUELE_BEOORDELING
		VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @PROCES, @MACHINE_ONDERDEEL, @AFDELING)

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