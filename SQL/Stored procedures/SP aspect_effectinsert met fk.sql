ALTER PROCEDURE sp_insertAspect_Effect_MetEffect
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
		execute sp_insertEffect @Effect
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
