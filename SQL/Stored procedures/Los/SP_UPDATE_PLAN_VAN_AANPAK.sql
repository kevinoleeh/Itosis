GO

CREATE PROCEDURE SP_UPDATE_PLAN_VAN_AANPAK
@PROJECTNUMMER int,
@RAPPORTNUMMER int,
@REGELNUMMER int,
@UITGEVOERD_DOOR varchar(255),
@EINDVERANTWOORDELIJKE varchar(255),
@DATUM_GEREED_GEPLAND date,
@PBM varchar(255),
@VOORLICHTING varchar(255),
@WERKINSTRUCTIE_PROCEDURE varchar(255),
@TRA varchar(255),
@CONTRACT_LIJST_ varchar(255)
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
        UPDATE PLAN_VAN_AANPAK
        SET projectnummer = @PROJECTNUMMER, rapportnummer = @RAPPORTNUMMER, regelnummer = @REGELNUMMER, uitgevoerd_door = @UITGEVOERD_DOOR, eindverantwoordelijke = @EINDVERANTWOORDELIJKE, datum_gereed_gepland = @DATUM_GEREED_GEPLAND,PBM = @PBM, voorlichting = @VOORLICHTING, werkinstructie_procedure = @WERKINSTRUCTIE_PROCEDURE, TRA = @TRA, contract_lijst_ = @CONTRACT_LIJST_
        WHERE projectnummer = @PROJECTNUMMER AND rapportnummer = @RAPPORTNUMMER AND regelnummer = @REGELNUMMER
      END
      ELSE
      BEGIN
        RAISERROR ('Om deze SP te kunnen gebruiken dient de combinatie projectnummer+rapportnummer+regelnummer te bestaan.', 16, 1)
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