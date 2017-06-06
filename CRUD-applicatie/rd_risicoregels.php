<?php include_once('include/header.php'); ?>
<?php include_once('include/excelGenerator.php');
    if(isset($_GET['delete'])) {
        $query = "DELETE RISICOREGEL
                  WHERE PROJECTNUMMER = :PROJECTNUMMER
                  AND RAPPORTNUMMER = :RAPPORTNUMMER
                  AND REGELNUMMER = :REGELNUMMER";
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
        $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
        $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);

        try {
            $stmt->execute();

            header('Location: rd_risicoregels.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Foutmelding: " . $e->getMessage();
        }
    }


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

            <?php include_once('include/melding.php') ?>

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
                                <th>Voorbeeld</th>
                                <th>Risico voor maatregel</th>
                                <th>Prioriteit voor maatregel</th>
                                <th>Plan van aanpak</th>
                                <th style="text-align: center">D</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($result as $value) { ?>
                                <?php

                                $query = "SELECT URL
                                          FROM AFBEELDING
                                          WHERE PROJECTNUMMER = :PROJECTNUMMER
                                          AND RAPPORTNUMMER = :RAPPORTNUMMER
                                          AND REGELNUMMER = :REGELNUMMER";
                                $stmt = $dbh->prepare($query);
                                $stmt->bindParam(':PROJECTNUMMER', $value['PROJECTNUMMER']);
                                $stmt->bindParam(':RAPPORTNUMMER', $value['RAPPORTNUMMER']);
                                $stmt->bindParam(':REGELNUMMER', $value['REGELNUMMER']);
                                $afbeelding = null;

                                try {
                                    $stmt->execute();
                                    $afbeelding = $stmt->fetchColumn();
                                } catch (PDOException $e) {
                                    echo "Foutmelding: " . $e->getMessage();
                                }

                                ?>
                            <tr>
                                <td><?= $value['REGELNUMMER'] ?></td>
                                <td><?= $value['ARBO_ONDERWERP'] ?></td>
                                <td><?= $value['ASPECTNAAM'] ?></td>
                                <td><?= $value['EFFECTNAAM'] ?></td>
                                <td>
                                    <?php if($afbeelding != '') { ?>
                                        <!-- URL wordt uit de database gehaald, omdat dit test data is wordt deze URL niet getoond maar een placeholder -->
                                        <a href="images/placeholder.jpg"><img src="images/placeholder_thumbnail.jpg" style="height:75px; width: 75px;"></a>
                                    <?php } ?>
                                </td>
                                <td style="<?php if (isset($value['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($value['VOOR_PRIORITEIT']); } ?>"><?= $value['VOOR_RISICO'] ?></td>
                                <td style="<?php if (isset($value['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($value['VOOR_PRIORITEIT']); } ?>"><?= $value['VOOR_PRIORITEIT'] ?></td>
                                <td>
                                    <?php if (in_array($value['REGELNUMMER'], $regelnummers)) { ?>

                                    <div>
                                        <a id="pvabutton" class="btn btn-block btn-primary" style="padding: 0 12px;" href="u_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>">Wijzigen</a>
                                    </div>

                                    <?php
                                } else {
                                    ?>
                                        <div>
                                            <a id="pvabutton" class="btn btn-block btn-primary" style="padding: 0 12px;" href="c_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>">Toevoegen</a>
                                        </div>
                                        <?php
                                } ?>
                                </td>
                                <td><a href="rd_risicoregels.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>&delete=1"><span class="glyphicon glyphicon-remove widintable red"></span></a></td>
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
?>
