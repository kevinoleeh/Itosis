-- insertProject tests
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC insertProject @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han'
	ROLLBACK TRANSACTION
	EXEC _result 'insertProject', 1, ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'insertProject', 0, @msg
END CATCH
EXEC _end 0
GO
-- Fail op fk
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC insertProject @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han'
		EXEC insertProject @Bedrijfsnaam = 'HANMMMMM', @Locatie = 'Arnhem', @ProjectOmschrijving = 'Project voor de han'
	ROLLBACK TRANSACTION
	EXEC _result 'insertProject', 0, ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'insertProject', 1, @msg
END CATCH
EXEC _end 0
GO
-- insertBedrijf test
-- Succes
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC insertBedrijf @Bedrijfsnaam = 'HAN', @Locatie = 'Gelre'
	ROLLBACK TRANSACTION
	EXEC _result 'insertBedrijf', 1, ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'insertBedrijf', 0, @msg
END CATCH
EXEC _end 0
GO
-- Fail op pk
EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC insertBedrijf @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem'
		EXEC insertBedrijf @Bedrijfsnaam = 'HAN', @Locatie = 'Arnhem    '
	ROLLBACK TRANSACTION
	EXEC _result 'insertBedrijf', 0, ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'insertBedrijf', 1, @msg
END CATCH
EXEC _end 1
GO