GO
CREATE PROCEDURE SELECT_ALLE_RAPPORTEN
	@PROJECTNUMMER INT
AS BEGIN
	SELECT *
	FROM RAPPORT R INNER JOIN RISICOREGEL RR
	ON R.PROJECTNUMMER = RR.PROJECTNUMMER
	AND R.RAPPORTNUMMER = RR.RAPPORTNUMMER
	WHERE R.PROJECTNUMMER = @PROJECTNUMMER
END
GO

EXEC SELECT_ALLE_RAPPORTEN 1


SELECT * FROM RAPPORT WHERE PROJECTNUMMER = 1