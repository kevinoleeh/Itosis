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
