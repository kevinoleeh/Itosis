<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

  include_once('PHPExcel/Classes/PHPExcel.php');
  include_once('include/header.php');

  $querytype = "SELECT RAPPORT_TYPE
            FROM RAPPORT
            WHERE PROJECTNUMMER = :PROJECTNUMMER
            AND RAPPORTNUMMER = :RAPPORTNUMMER";
  $stmt3 = $dbh->prepare($querytype);
  $stmt3->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
  $stmt3->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
  $stmt3->execute();
  $type = $stmt3->fetch();
  $query = "SELECT *
            FROM RISICOREGEL
            WHERE PROJECTNUMMER = :PROJECTNUMMER
            AND RAPPORTNUMMER = :RAPPORTNUMMER";
  if($type['RAPPORT_TYPE'] == 'Visuele beoordeling' || $type['RAPPORT_TYPE'] == 'Machineveiligheid'){
  $query = "SELECT *
            FROM RISICOREGEL r
            LEFT JOIN VISUELE_BEOORDELING vb ON r.PROJECTNUMMER = vb.PROJECTNUMMER  AND r.RAPPORTNUMMER = vb.RAPPORTNUMMER   AND r.REGELNUMMER = vb.REGELNUMMER
            WHERE r.PROJECTNUMMER = :PROJECTNUMMER
            AND r.RAPPORTNUMMER = :RAPPORTNUMMER"; }
  if($type['RAPPORT_TYPE'] == 'Machineveiligheid'){
  $query = "SELECT *
            FROM RISICOREGEL r
            LEFT JOIN VISUELE_BEOORDELING vb ON r.PROJECTNUMMER = vb.PROJECTNUMMER  AND r.RAPPORTNUMMER = vb.RAPPORTNUMMER   AND r.REGELNUMMER = vb.REGELNUMMER
            LEFT JOIN MACHINEVEILIGHEID m ON r.PROJECTNUMMER = m.PROJECTNUMMER AND r.RAPPORTNUMMER = m.RAPPORTNUMMER AND r.REGELNUMMER = m.REGELNUMMER
            WHERE r.PROJECTNUMMER = :PROJECTNUMMER
            AND r.RAPPORTNUMMER = :RAPPORTNUMMER"; }

  $query2 = "SELECT REGELNUMMER
             FROM RISICOREGEL
             WHERE PROJECTNUMMER = :PROJECTNUMMER
             AND RAPPORTNUMMER = :RAPPORTNUMMER";
  $stmt = $dbh->prepare($query);
  $projectnummer = $_GET['projectnummer'];
  $rapportnummer = $_GET['rapportnummer'];
  $stmt2 = $dbh->prepare($query2);
  $stmt2->bindParam(':PROJECTNUMMER', $projectnummer);
  $stmt2->bindParam(':RAPPORTNUMMER', $rapportnummer);
  $stmt2->execute();
  $stmt->bindParam(':PROJECTNUMMER', $projectnummer);
  $stmt->bindParam(':RAPPORTNUMMER', $rapportnummer);
  $stmt->execute();
  $results = array();
  $results2 = array();
  while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
    $results[] = $row;
  }

  while($row = $stmt2->fetch(PDO::FETCH_ASSOC)){
    $results2[] = $row;
  }
  $filename =  'Projectnummer'.$projectnummer.'Rapportnummer'.$rapportnummer.' Excel';
  $objPHPExcel = new PHPExcel();
  $objPHPExcel->getActiveSheet()->setTitle('Organisatie risicoregel');

  // Zet hier alle kolommen neer
  $objPHPExcel->setActiveSheetIndex(0);
  $objPHPExcel->getActiveSheet()->getStyle('1:1')->getFont()->setBold(true);
  $excelLetters = array();
  $excelLetter = 'A';

while ($excelLetter !== 'AAA') {
    $excelLetters[] = $excelLetter++;
}

  $setHeaders = false;
  $keys = array_keys($results[0]);
  $offset = '2';
  for($i = 0; $i < sizeof($keys); $i ++){
    $objPHPExcel->getActiveSheet()->getColumnDimension($excelLetters[$i])->setWidth(22);
  }
  foreach ($results as $key => $row) {

    if(!$setHeaders){
      for($i = 0; $i < sizeof($row); $i ++){
        $objPHPExcel->getActiveSheet()->setCellValue($excelLetters[$i] . '1', $keys[$i]);
      }
      $setHeaders = true;
    }
    for($i = 0; $i < sizeof($row); $i ++){
      $offsetfinal = ''+intval($key)+intval($offset);
      if($i < 2){
        if($i < 1){
          $objPHPExcel->getActiveSheet()->setCellValue($excelLetters[$i].$offsetfinal, $projectnummer);
        }
        else{
          $objPHPExcel->getActiveSheet()->setCellValue($excelLetters[$i].$offsetfinal, $rapportnummer);
        }
      }
      if($i == 2){
        $objPHPExcel->getActiveSheet()->setCellValue($excelLetters[$i].$offsetfinal, $results2[$key]["REGELNUMMER"]);
      }
      if($i > 2){
      $objPHPExcel->getActiveSheet()->setCellValue($excelLetters[$i].$offsetfinal, $row[$keys[$i]]);
    }
    }
  }

  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel5');
  header('Content-type: application/vnd.ms-excel');
  header('Content-disposition: attachment; filename="'.$filename.'.xls"');
  header('Cache-Control: max-age=0');
  ob_end_clean();
  $objWriter->save('php://output');
include_once('include/pdo-disconnect.php');
exit();
}
?>
