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

?>

<div class="container">
    <div class="page-header">
        <h1>Rapportage</h1>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="organisatie.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" class="btn btn-block btn-primary">Regel toevoegen</a>
            <br>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Regelnummer</th>
                    <th>Aspect</th>
                    <th>Effect</th>
                    <th>Arbo onderwerp</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($result as &$value) { ?>
                    <tr>
                        <td><a href="organisatie.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $value['RAPPORTNUMMER'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>"><?= $value['REGELNUMMER'] ?></td>
                        <td><?= $value['ASPECTNAAM'] ?></td>
                        <td><?= $value['EFFECTNAAM'] ?></td>
                        <td><?= $value['ARBO_ONDERWERP'] ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php include_once('include/footer.php');
