<?php include_once('include/header.php') ?>

<?php
if(isset($_GET['delete'])){
  $query = "EXEC SP_DELETE_RAPPORT :PROJECTNUMMER, :RAPPORTNUMMER";
  $stmt = $dbh->prepare($query);
  $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
  $stmt->bindParam(':RAPPORTNUMMER', $_GET['delete']);


try {
    $stmt->execute();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}
}
$query = "SELECT *
         FROM RAPPORT
         WHERE PROJECTNUMMER = :PROJECTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$result = null;

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

?>

<div class="container">
    <div class="page-header">
        <h1>Rapporten</h1>
        <h4>Projectnummer <?= $_GET['projectnummer'] ?></h4>
    </div>

    <?php include_once('include/melding.php') ?>

    <div class="row">
        <div class="col-md-12">
            <a href="c_rapportage.php?projectnummer=<?= $_GET['projectnummer'] ?>" class="btn btn-block btn-primary">Rapport toevoegen</a>
            <br>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Rapportnummer</th>
                    <th>Type</th>
                </tr>
                </thead>
                <tbody>
                <?php if(count($result) > 0) { ?>
                    <?php foreach ($result as &$value) { ?>
                        <tr onClick="document.location.href='rd_risicoregels.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $value['RAPPORTNUMMER'] ?>';">
                            <td><?= $value['RAPPORTNUMMER'] ?></td>
                            <td><?= $value['RAPPORT_TYPE'] ?>
                            <a href="?delete=<?= $value['RAPPORTNUMMER']?>"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                          </td>
                        </tr>
                    <?php } ?>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include_once('include/footer.php');
