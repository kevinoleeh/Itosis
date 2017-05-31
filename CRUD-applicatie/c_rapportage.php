<?php include_once('include/header.php') ?>

<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_INSERT_RAPPORT
             :PROJECTNUMMER,
             :RAPPORT_TYPE";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORT_TYPE', $_POST['RAPPORT_TYPE']);
    try {
        $stmt->execute();
        header('Location: rd_risicoregels.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Rapport niet opgeslagen. Foutmelding: " . $e->getMessage();
    }
}

$query = "SELECT *
          FROM RAPPORT_TYPE";
$stmt = $dbh->prepare($query);

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
        <h1>Rapportage toevoegen</h1>
        <h4>Projectnummer <?= $_GET['projectnummer'] ?></h4>
    </div>

    <?php include_once('include/melding.php') ?>

    <form action="c_rapportage.php?projectnummer=<?= $_GET['projectnummer'] ?>" method="post">
        <div class="form-group">
            <label for="ASPECT">Rapport type</label>
            <select class="form-control" name="RAPPORT_TYPE">
                <?php foreach ($result as $value) { ?>
                    <option><?= $value['RAPPORT_TYPE'] ?></option>
                <?php } ?>
            </select>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit">Rapport toevoegen</button>
    </form>
    <br>
</div>

<?php include_once('include/footer.php'); ?>
