<?php include_once('include/header.php') ?>

<?php

$query = "SELECT *
          FROM RISICOREGEL
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

$query = "SELECT RAPPORT_TYPE
          FROM RAPPORT
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);

try {
    $stmt->execute();
    $type = $stmt->fetch();
} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

$query = "SELECT regelnummer
FROM PLAN_VAN_AANPAK
 WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER ";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);

try {
    $stmt->execute();
    $regelnummers = $stmt->fetchAll(PDO::FETCH_COLUMN, 0);

} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

if ($type['RAPPORT_TYPE'] === 'Organisatie') {
    $url = 'organisatie_risicoregel.php';
} else if ($type['RAPPORT_TYPE'] === 'Visuele beoordeling') {
    $url = 'visuele_beoordeling_risicoregel.php';
}

?>

    <div class="container">
        <div class="page-header">
            <h1>Regels</h1>
            <h4>Projectnummer <?= $_GET['projectnummer'] ?>, rapportnummer <?= $_GET['rapportnummer'] ?></h4>
        </div>

        <div class="row">
            <div class="col-md-6">
                <a id="regelopenenbutton" class="btn btn-block btn-primary">Regel openen</a>
            </div>
            <div class="col-md-6">
                <a href="c_<?= $url ?>?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>"
                   class="btn btn-block btn-primary">Regel toevoegen</a>
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
                            <td style="display: none;"><?= $value['REGELNUMMER'] ?></td>
                            <td><?= $value['REGELNUMMER'] ?></td>
                            <td><?= $value['ARBO_ONDERWERP'] ?></td>
                            <td><?= $value['ASPECTNAAM'] ?></td>
                            <td><?= $value['EFFECTNAAM'] ?></td>
                            <td><?= $value['VOOR_RISICO'] ?></td>
                            <td><?= $value['VOOR_PRIORITEIT'] ?></td>
                            <td><?php if (in_array($value['REGELNUMMER'], $regelnummers)) { ?>

                                    <div class="">
                                        <a id="pvabutton"
                                           href="u_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>"
                                           class="btn btn-block btn-primary">PvA wijzigen</a>
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
                                } ?></td>
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
<?php include_once('include/footer.php');
