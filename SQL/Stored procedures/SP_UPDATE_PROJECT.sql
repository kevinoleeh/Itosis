CREATE PROCEDURE SP_UPDATE_PROJECT
	  @Projectnummer	     int,
	  @Bedrijfsnaam        VARCHAR(255),
    @Locatie             VARCHAR(255),
	  @omschrijvingOud     Varchar(255),
    @OmschrijvingNew     VARCHAR(255)
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
		UPDATE Project SET PROJECTOMSCHRIJVING = @OmschrijvingNew
		WHERE BEDRIJFSNAAM = @Bedrijfsnaam AND LOCATIE = @Locatie AND Projectomschrijving = @omschrijvingOud AND PROJECTNUMMER = @Projectnummer
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
