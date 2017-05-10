GO
CREATE PROCEDURE InsertOrganisatieRisicoregel
	@Projectnummer INT,
	@Rapportnummer INT,
    @Regelnummer INT,
	@Aspectnaam VARCHAR(255),
	@Effectnaam VARCHAR(255),
	@ArboOnderwerp VARCHAR(255),
	@HuidigeBeheersmaatregel VARCHAR(255),
	@VoorgesteldeActieOfVerbeteringsmaatregel VARCHAR(255),
	@AfwijkendeActieTerUitvoering VARCHAR(255),
	@RestRisico VARCHAR(255),
	@VoorErnstVanOngeval NUMERIC(9, 2),
	@VoorKansOpBlootstelling NUMERIC(9, 2),
	@VoorKansOpWaarschijnlijkheid NUMERIC(9, 2),
	@NaErnstVanOngeval NUMERIC(9, 2),
	@NaKansOpBlootstelling NUMERIC(9, 2),
	@NaKansOpWaarschijnlijkheid NUMERIC(9, 2)
AS BEGIN
	SET NOCOUNT, XACT_ABORT ON
	DECLARE @TranCounter INT;
	SET @TranCounter = @@TRANCOUNT;

	IF @TranCounter > 0
		SAVE TRANSACTION ProcedureSave;
	ELSE
		BEGIN TRANSACTION;

	BEGIN TRY
		-- 1. Basis van een regel.
		INSERT RISICOREGEL
		VALUES (@Projectnummer, @Rapportnummer, @Regelnummer, @Aspectnaam, @Effectnaam, @ArboOnderwerp, @HuidigeBeheersmaatregel)

		-- 2. Fine en Kinney die bij de risicoregel hoort.
		INSERT FINE_EN_KINNEY (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, FINE_EN_KINNEY_TYPE, ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID)
		VALUES (@Projectnummer, @Rapportnummer, @Regelnummer, 'Voor', @VoorErnstVanOngeval, @VoorKansOpBlootstelling, @VoorKansOpWaarschijnlijkheid)

		-- 3. Maatregel die bij de regel hoort.
		INSERT RISICOMAATREGEL
		VALUES (@Projectnummer, @Rapportnummer, @Regelnummer, @VoorgesteldeActieOfVerbeteringsmaatregel, @AfwijkendeActieTerUitvoering, @RestRisico)

		-- 4. Fine en Kinney die bij de risicomaatregel hoort.
		INSERT FINE_EN_KINNEY (PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, FINE_EN_KINNEY_TYPE, ERNST_VAN_HET_ONGEVAL, KANS_OP_BLOOTSTELLING, KANS_OP_WAARSCHIJNLIJKHEID)
		VALUES (@Projectnummer, @Rapportnummer, @Regelnummer, 'Na', @NaErnstVanOngeval, @NaKansOpBlootstelling, @NaKansOpWaarschijnlijkheid)

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