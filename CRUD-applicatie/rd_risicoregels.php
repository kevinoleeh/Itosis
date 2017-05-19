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

if($type['RAPPORT_TYPE'] === 'Organisatie') {
    $url = 'organisatie_risicoregel.php';
}
else if($type['RAPPORT_TYPE'] === 'Visuele beoordeling') {
    $url = 'visuele_beoordeling_risicoregel.php';
}

?>

<div class="container">
    <div class="page-header">
        <h1>Regels</h1>
        <h4>Projectnummer <?= $_GET['projectnummer'] ?>, rapportnummer <?= $_GET['rapportnummer'] ?></h4>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="c_<?= $url ?>?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" class="btn btn-block btn-primary">Regel toevoegen</a>
            <br>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Regelnummer</th>
                    <th>Arbo onderwerp</th>
                    <th>Aspect</th>
                    <th>Effect</th>
                    <th>Risico voor maatregel</th>
                    <th>Prioriteit voor maatregel</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($result as &$value) { ?>
                    <tr>
                        <td><a href="u_<?= $url ?>?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $value['RAPPORTNUMMER'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>"><?= $value['REGELNUMMER'] ?></td>
                        <td><?= $value['ARBO_ONDERWERP'] ?></td>
                        <td><?= $value['ASPECTNAAM'] ?></td>
                        <td><?= $value['EFFECTNAAM'] ?></td>
                        <td><?= $value['VOOR_RISICO'] ?></td>
                        <td><?= $value['VOOR_PRIORITEIT'] ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php include_once('include/footer.php');
