<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

  session_start();
  include_once('PHPExcel/Classes/PHPExcel.php');
  include_once('include/pdo-connect.php');
  $query = "SELECT *
            FROM RISICOREGEL r
            LEFT JOIN VISUELE_BEOORDELING vb ON r.PROJECTNUMMER = vb.PROJECTNUMMER  AND r.RAPPORTNUMMER = vb.RAPPORTNUMMER   AND r.REGELNUMMER = vb.REGELNUMMER
            LEFT JOIN MACHINEVEILIGHEID m ON r.PROJECTNUMMER = m.PROJECTNUMMER AND r.RAPPORTNUMMER = m.RAPPORTNUMMER AND r.REGELNUMMER = m.REGELNUMMER
            WHERE r.PROJECTNUMMER = :PROJECTNUMMER
            AND r.RAPPORTNUMMER = :RAPPORTNUMMER";
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
} else {?>
    <?php include_once('include/header.php'); ?>
    <?php

$query = "SELECT *
          FROM RISICOREGEL
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$result = null;

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

$query = "SELECT REGELNUMMER
          FROM PLAN_VAN_AANPAK
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER ";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$regelnummers = null;

try {
    $stmt->execute();
    $regelnummers = $stmt->fetchAll(PDO::FETCH_COLUMN, 0);
} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

function getPrioriteitStyle($prioriteit)
{
    switch ($prioriteit) {
        case 'P 1':
            return 'color: #ff0000;';
            break;
        case 'P 2':
            return 'color: #ff5500;';
            break;
        case 'P 3':
            return 'color: #ffa000;';
            break;
        case 'P 4':
            return 'color: #ffc800;';
            break;
        case 'P 5':
            return 'color: #00a000;';
            break;
    }

    return '';
}

?>
        <div class="container">
            <div class="page-header">
                <h1>Regels</h1>
                <h4>Projectnummer
                    <?= $_GET['projectnummer'] ?>, rapportnummer
                        <?= $_GET['rapportnummer'] ?>
                </h4>
            </div>

            <div class="row">
                <div class="col-md-4">
                    <a id="regelopenenbutton" class="btn btn-block btn-primary">Regel openen</a>
                </div>
                <div class="col-md-4">
                    <a href="risicoregel.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" class="btn btn-block btn-primary">Regel toevoegen</a>
                </div>
                <div class="col-md-4">
                    <form action="rd_risicoregels.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" method="post">
                        <input type="submit" class="btn btn-block btn-default" value="Regels exporteren naar Excel">
                </div>

                <div class="col-md-12">

                    <br>

                    <table id="table" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Regelnummer</th>
                                <th>Arbo onderwerp</th>
                                <th>Aspect</th>
                                <th>Effect</th>
                                <th>Risico voor maatregel</th>
                                <th>Prioriteit voor maatregel</th>
                                <th>Plan van aanpak</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($result as &$value) { ?>
                            <tr>
                                <td><?= $value['REGELNUMMER'] ?></td>
                                <td><?= $value['ARBO_ONDERWERP'] ?></td>
                                <td><?= $value['ASPECTNAAM'] ?></td>
                                <td><?= $value['EFFECTNAAM'] ?></td>
                                <td style="<?php if (isset($value['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($value['VOOR_PRIORITEIT']); } ?>"><?= $value['VOOR_RISICO'] ?></td>
                                <td style="<?php if (isset($value['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($value['VOOR_PRIORITEIT']); } ?>"><?= $value['VOOR_PRIORITEIT'] ?></td>
                                <td>
                                    <?php if (in_array($value['REGELNUMMER'], $regelnummers)) { ?>

                                    <div class="">
                                        <a id="pvabutton" href="u_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>" class="btn btn-block btn-primary">PvA wijzigen</a>
                                    </div>

                                    <?php
                                } else {
                                    ?>
                                        <div class="">
                                            <a id="pvabutton"
                                               href="c_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>"
                                               class="btn btn-block btn-primary">PvA toevoegen</a>
                                        </div>
                                        <?php
                                } ?>
                                </td>
                            </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            var projectnummer = "<?php echo $_GET['projectnummer']; ?>";
            var rapportnummer = "<?php echo $_GET['rapportnummer']; ?>";
        </script>
<?php
   include_once('include/footer.php');
 }
?>
