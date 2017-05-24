GO

CREATE PROCEDURE SP_INSERT_PERIODIEKE_BEOORDELING
    @PROJECTNUMMER int,
    @RAPPORTNUMMER int,
    @REGELNUMMER int,
    @DATUM_LAATSTE_BEOORDELING date,
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
        VALUES (@PROJECTNUMMER, @RAPPORTNUMMER, @REGELNUMMER, @DATUM_LAATSTE_BEOORDELING, @INSPECTIE_IS_DE_ACTIE_UITGEVOERD, @OPMERKING_STAND_VAN_ZAKEN, @STAND_VAN_ZAKEN, @SCORE)
	  END
    ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient de plan van aanpak te bestaan.', 16, 1)
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