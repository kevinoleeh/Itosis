<?php

include_once('include/pdo-connect.php');
include_once('PHPExcel/Classes/PHPExcel.php');

$projectnummer = 1;
$rapportnummer = 12;

$query = "SELECT REGELNUMMER, ASPECTNAAM, EFFECTNAAM, ARBO_ONDERWERP, RISICO_OMSCHRIJVING, HUIDIGE_BEHEERSMAATREGEL, VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL, VOOR_ERNST_VAN_HET_ONGEVAL,
          VOOR_KANS_OP_BLOOTSTELLING, VOOR_KANS_OP_WAARSCHIJNLIJKHEID, VOOR_RISICO, VOOR_PRIORITEIT, AFWIJKENDE_ACTIE_TER_UITVOERING, RESTRISICO, NA_ERNST_VAN_HET_ONGEVAL,
          NA_KANS_OP_BLOOTSTELLING, NA_KANS_OP_WAARSCHIJNLIJKHEID, NA_RISICO, NA_PRIORITEIT
          FROM RISICOREGEL
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $projectnummer);
$stmt->bindParam(':RAPPORTNUMMER', $rapportnummer);
$stmt->execute();
$results = $stmt->fetchAll();

$filename =  $projectnummer.''.$rapportnummer.' Excel.xslx';
$objPHPExcel = new PHPExcel();
$objPHPExcel->getActiveSheet()->setTitle('Organisatie risicoregel');

// Zet hier alle kolommen neer
$objPHPExcel->setActiveSheetIndex(0)
$excelLetters = range('A', 'Z');
$setHeaders = false;
foreach ($results as $key => $row) {
  if(!$setHeaders){
    for($i = 0; $i < sizeof($row); $i ++){
      $objPHPExcel->setCellValue($excelLetters[$i].'1', key($row));
    }
    $setHeaders = true;
  }
  for($i = 0; $i < sizeof($row); $i ++){
    $objPHPExcel->setCellValue($excelLetters[$i].$key, $row[$i]);
  }
}

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
header('Content-type: application/vnd.ms-excel');
header('Content-disposition: attachment; filname="'.$filename.'"');
header('Cache-Control: max-age=0');
$objWriter->save('php://output');


include_once('include/pdo-disconnect.php');

?>
