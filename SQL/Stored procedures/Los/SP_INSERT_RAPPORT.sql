CREATE PROCEDURE SP_INSERT_RAPPORT
		@PROJECTNUMMER      INT,
		@RAPPORT_TYPE		VARCHAR(255)
AS
	BEGIN
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
				FROM PROJECT
				WHERE PROJECTNUMMER = @PROJECTNUMMER
			) BEGIN
				INSERT INTO RAPPORT(PROJECTNUMMER,RAPPORTNUMMER, RAPPORT_TYPE)
				VALUES (@PROJECTNUMMER, dbo.FN_GET_NEW_RAPPORTNUMMER(@PROJECTNUMMER), @RAPPORT_TYPE)
			END ELSE BEGIN
				RAISERROR('Projectnummer bestaat niet.', 16, 1)
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
