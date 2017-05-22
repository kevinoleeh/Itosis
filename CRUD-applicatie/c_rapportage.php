<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.INSERT_RAPPORT
             :PROJECTNUMMER,
             :RAPPORT_TYPE";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORT_TYPE', $_POST['RAPPORT_TYPE']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Rapport opgeslagen.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Rapport niet opgeslagen. Foutmelding: " . $e->getMessage();
    }
    header('Location: rd_rapportages.php?projectnummer='.$_GET['projectnummer']);
}

?>

<div class="container">
    <div class="page-header">
        <h1>Rapport toevoegen</h1>
        <h4>Projectnummer <?= $_GET['projectnummer'] ?></h4>
    </div>

    <?php include_once('include/melding.php') ?>

    <form action="c_rapportage.php?projectnummer=<?= $_GET['projectnummer'] ?>" method="post">
        <div class="form-group">
            <label for="ASPECT">Rapport type</label>
            <select class="form-control" name="RAPPORT_TYPE">
                <option>Organisatie</option>
                <option>Visuele beoordeling</option>
            </select>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit">Rapport toevoegen</button>
    </form>
    <br>
</div>

<?php include_once('include/footer.php'); ?>
