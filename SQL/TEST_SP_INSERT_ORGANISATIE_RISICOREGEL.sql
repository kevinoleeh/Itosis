EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			1,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			99999,
			1,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Projectnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			99999,
			'Test 1',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Rapportnummer bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			1,
			'Bestaat niet',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			1,
			'Test 1',
			'Bestaat niet',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Effect bestaat niet.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			1,
			'Test 1',
			'Test 2',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Aspect hoort niet bij effect.', @msg
END CATCH
EXEC _end 0
GO

EXEC _begin
BEGIN TRY
	BEGIN TRANSACTION test
		EXEC SP_INSERT_ORGANISATIE_RISICOREGEL
			1,
			1,
			'Test 2',
			'Test 1',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			'Test',
			1,
			1,
			1,
			1,
			1,
			1
	ROLLBACK TRANSACTION
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 0, '', ''
END TRY
BEGIN CATCH
	ROLLBACK TRANSACTION
	DECLARE @msg VARCHAR(200) = ERROR_MESSAGE()
	EXEC _result 'SP_INSERT_ORGANISATIE_RISICOREGEL', 1, 'Effect hoort niet bij aspect.', @msg
END CATCH
EXEC _end 1
GO