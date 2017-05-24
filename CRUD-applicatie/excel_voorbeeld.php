<?php

include_once('include/pdo-connect.php');

$projectnummer = 1;
$rapportnummer = 12;
$regelnummer = 15;

$query = "SELECT *
          FROM RISICOREGEL
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER
          AND REGELNUMMER = :REGELNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $projectnummer);
$stmt->bindParam(':RAPPORTNUMMER', $rapportnummer);
$stmt->bindParam(':REGELNUMMER', $regelnummer);
$stmt->execute();
$result = $stmt->fetch();

require_once dirname(__FILE__) . '/PHPExcel/Classes/PHPExcel.php';

$objPHPExcel = new PHPExcel();
$objPHPExcel->getActiveSheet()->setTitle('Organisatie risicoregel');

// Zet hier alle kolommen neer
$objPHPExcel->setActiveSheetIndex(0)
    ->setCellValue('A1', 'Aspect')
    ->setCellValue('A2', $result['ASPECTNAAM']);

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
$objWriter->save(str_replace('.php', '.xlsx', __FILE__));

include_once('include/pdo-disconnect.php');

?>

<a href="http://localhost/Github/Itosis/CRUD-applicatie/excel_voorbeeld.xlsx">Download</a>