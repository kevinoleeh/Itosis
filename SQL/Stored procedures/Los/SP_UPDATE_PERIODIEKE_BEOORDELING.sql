GO

CREATE PROCEDURE SP_UPDATE_PERIODIEKE_BEOORDELING
    @PROJECTNUMMER int,
    @RAPPORTNUMMER int,
    @REGELNUMMER int,
    @DATUM_BEOORDELING_OUD date,
    @DATUM_BEOORDELING_NIEUW date,
    @INSPECTIE_IS_DE_ACTIE_UITGEVOERD bit,
    @OPMERKING_STAND_VAN_ZAKEN text,
    @STAND_VAN_ZAKEN varchar(255),
    @SCORE numeric
AS
  BEGIN
    SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
    -- Dit vermijd dat DATUM_BEOORDELING_OUD veranderd kan worden door een andere transactie gedurende deze transactie
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
					 AND datum_beoordeling = @DATUM_BEOORDELING_OUD)
      BEGIN
        UPDATE PERIODIEKE_BEOORDELING
        SET datum_beoordeling = @DATUM_BEOORDELING_NIEUW, inspectie_is_de_actie_uitgevoerd = @INSPECTIE_IS_DE_ACTIE_UITGEVOERD, opmerking_stand_van_zaken = @OPMERKING_STAND_VAN_ZAKEN, stand_van_zaken = @STAND_VAN_ZAKEN, score = @SCORE
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