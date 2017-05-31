GO
CREATE PROCEDURE SP_UPDATE_MACHINEVEILIGHEID_RISICOREGEL
		@PROJECTNUMMER                                 INT,
		@RAPPORTNUMMER                                 INT,
		@REGELNUMMER                                   INT,
		@ASPECTNAAM                                    VARCHAR(255),
		@EFFECTNAAM                                    VARCHAR(255),
		@ARBO_ONDERWERP                                VARCHAR(255),
		@RISICO_OMSCHRIJVING_OF_BEVINDING              VARCHAR(255),
		@HUIDIGE_BEHEERSMAATREGEL                      VARCHAR(255),
		@VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL   VARCHAR(255),
		@AFWIJKENDE_ACTIE_TER_UITVOERING               VARCHAR(255),
		@RESTRISICO                                    VARCHAR(255),
		@PROCES                                        VARCHAR(255),
		@MACHINE_ONDERDEEL                             VARCHAR(255),
		@AFDELING                                      VARCHAR(255),
		@MACHINE                                       VARCHAR(255),
		@MODEL__TYPE                                   VARCHAR(255),
		@SERIENUMMER                                   VARCHAR(255),
		@LEVERANCIER                                   VARCHAR(255),
		@CE_MARKERING                                  VARCHAR(255),
		@CE_DOCUCHECK                                  VARCHAR(255),
		@TRANSPORT                                     BIT,
		@MONTAGE                                       BIT,
		@IN_BEDRIJFSNAME                               BIT,
		@TIJDENS_PRODUCTIE                             BIT,
		@TIJDENS_ONDERHOUD                             BIT,
		@TIJDENS_STORING                               BIT,
		@TIJDENS_REINIGEN                              BIT,
		@TIJDENS_AFSTELLEN                             BIT,
		@DEMONTAGE                                     BIT,
		@FREQUENTIE                                    NUMERIC(9, 2),
		@MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS NUMERIC(9, 2),
		@MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE     NUMERIC(9, 2),
		@ERNST_VAN_DE_GEVOLGEN                         NUMERIC(9, 2),
		@VOOR_ERNST_VAN_HET_ONGEVAL                    NUMERIC(9, 2),
		@VOOR_KANS_OP_BLOOTSTELLING                    NUMERIC(9, 2),
		@VOOR_KANS_OP_WAARSCHIJNLIJKHEID               NUMERIC(9, 2),
		@NA_ERNST_VAN_ONGEVAL                          NUMERIC(9, 2),
		@NA_KANS_OP_BLOOTSTELLING                      NUMERIC(9, 2),
		@NA_KANS_OP_WAARSCHIJNLIJKHEID                 NUMERIC(9, 2)

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

	BEGIN
		IF EXISTS(
			SELECT 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND RAPPORT_TYPE = 'Machineveiligheid'
		)
			UPDATE RISICOREGEL
			SET ASPECTNAAM                                  = @ASPECTNAAM,
				EFFECTNAAM                                  = @EFFECTNAAM,
				ARBO_ONDERWERP                              = @ARBO_ONDERWERP,
				RISICO_OMSCHRIJVING_OF_BEVINDING            = @RISICO_OMSCHRIJVING_OF_BEVINDING,
				HUIDIGE_BEHEERSMAATREGEL                    = @HUIDIGE_BEHEERSMAATREGEL,
				VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL = @VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
				VOOR_ERNST_VAN_HET_ONGEVAL                  = @VOOR_ERNST_VAN_HET_ONGEVAL,
				VOOR_KANS_OP_BLOOTSTELLING                  = @VOOR_KANS_OP_BLOOTSTELLING,
				VOOR_KANS_OP_WAARSCHIJNLIJKHEID             = @VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
				AFWIJKENDE_ACTIE_TER_UITVOERING             = @AFWIJKENDE_ACTIE_TER_UITVOERING,
				RESTRISICO                                  = @RESTRISICO,
				NA_ERNST_VAN_ONGEVAL                        = @NA_ERNST_VAN_ONGEVAL,
				NA_KANS_OP_BLOOTSTELLING                    = @NA_KANS_OP_BLOOTSTELLING,
				NA_KANS_OP_WAARSCHIJNLIJKHEID               = @NA_KANS_OP_WAARSCHIJNLIJKHEID
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND REGELNUMMER = @REGELNUMMER
		IF EXISTS(
			SELECT 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND RAPPORT_TYPE = 'Machine veiligheid'
		)
			UPDATE VISUELE_BEOORDELING
			SET PROCES             = @PROCES,
				MACHINE_ONDERDEEL_ = @MACHINE_ONDERDEEL,
				AFDELING           = @AFDELING
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND REGELNUMMER = @REGELNUMMER
		IF EXISTS(
			SELECT 1
			FROM RAPPORT
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND RAPPORT_TYPE = 'Machine veiligheid'
		)
			UPDATE MACHINEVEILIGHEID
			SET MACHINE                                       = @MACHINE,
				MODEL___TYPE                                  = @MODEL__TYPE,
				SERIENUMMER                                   = @SERIENUMMER,
				LEVERANCIER                                   = @LEVERANCIER,
				CE_MARKERING                                  = @CE_MARKERING,
				CE_DOCUCHECK                                  = @CE_DOCUCHECK,
				TRANSPORT                                     = @TRANSPORT,
				MONTAGE                                       = @MONTAGE,
				IN_BEDRIJFNAME                                = @IN_BEDRIJFSNAME,
				TIJDENS_PRODUCTIE                             = @TIJDENS_PRODUCTIE,
				TIJDENS_ONDERHOUD                             = @TIJDENS_ONDERHOUD,
				TIJDENS_STORING                               = @TIJDENS_STORING,
				TIJDENS_REININGEN                             = @TIJDENS_REINIGEN,
				TIJDENS_AFSTELLEN                             = @TIJDENS_AFSTELLEN,
				DEMONTAGE                                     = @DEMONTAGE,
				FREQUENTIE                                    = @FREQUENTIE,
				MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS = @MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS,
				MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE     = @MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE,
				ERNST_VAN_DE_GEVOLGEN                         = @ERNST_VAN_DE_GEVOLGEN
			WHERE PROJECTNUMMER = @PROJECTNUMMER
			      AND RAPPORTNUMMER = @RAPPORTNUMMER
			      AND REGELNUMMER = @REGELNUMMER

		ELSE
			RAISERROR ('Om deze SP te gebruiken moet RAPPORT.RAPPORT_TYPE "Machine veiligheid" zijn.', 16, 1)
		IF @TranCounter = 0 AND XACT_STATE() = 1
			COMMIT TRANSACTION;
	END
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
