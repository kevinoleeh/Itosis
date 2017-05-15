-- Test INSERT_ORGANISATIE_RISICOREGEL

-- Test of er een error is als rapport type geen organisatie is
-- Test of insert goed gaat

-- Test UPDATE_ORGANISATIE_RISICOREGEL

-- Test of er een error is als rapport type geen organisatie is
-- Test of insert goed gaat

SELECT *
FROM RAPPORT
WHERE PROJECTNUMMER = 1
AND RAPPORTNUMMER = 1

UPDATE RAPPORT
SET RAPPORT_TYPE = 'Organisatie'
WHERE PROJECTNUMMER = 1
AND RAPPORTNUMMER = 1

EXEC INSERT_ORGANISATIE_RISICOREGEL
	1,
	1,
	'Brandgevaar',
	'Verbranding',
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