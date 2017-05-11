<?php include_once('header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $hostname = "(local)\SQLEXPRESS";
    $dbname = "Euratex";
    $username = "sa";
    $password = "P@ssw0rd";
    $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", "$username", "$password");
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $query = "EXEC dbo.InsertOrganisatieRisicoregel
             :projectnummer,
             :rapportnummer,
             19,
             :aspect,
             :effect,
             :arboOnderwerp,
             :huidigeBeheersmaatregel,
             :voorgesteldeActieTerUitvoering,
             :afwijkendeActieTerUitvoering,
             :restRisico,
             :voorErnstVanOngeval,
             :voorKansOpBlootstelling,
             :voorKansOpWaarschijnlijkheid,
             :naErnstVanOngeval,
             :naKansOpBlootstelling,
             :naKansOpWaarschijnlijkheid";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':projectnummer', $_GET['projectnummer']);
    $stmt->bindParam(':rapportnummer', $_GET['rapportnummer']);
    $stmt->bindParam(':aspect', $_POST['aspect']);
    $stmt->bindParam(':effect', $_POST['effect']);
    $stmt->bindParam(':arboOnderwerp', $_POST['arboonderwerp']);
    $stmt->bindParam(':huidigeBeheersmaatregel', $_POST['huidigebeheersmaatregel']);
    $stmt->bindParam(':voorgesteldeActieTerUitvoering', $_POST['voorgesteldeactieteruitvoering']);
    $stmt->bindParam(':afwijkendeActieTerUitvoering', $_POST['afwijkendeactieteruitvoering']);
    $stmt->bindParam(':restRisico', $_POST['restrisico']);
    $stmt->bindParam(':voorErnstVanOngeval', $_POST['voorernstvanongeval']);
    $stmt->bindParam(':voorKansOpBlootstelling', $_POST['voorkansopblootstelling']);
    $stmt->bindParam(':voorKansOpWaarschijnlijkheid', $_POST['voorkansopwaarschijnlijkheid']);
    $stmt->bindParam(':naErnstVanOngeval', $_POST['naernstvanongeval']);
    $stmt->bindParam(':naKansOpBlootstelling', $_POST['nakansopblootstelling']);
    $stmt->bindParam(':naKansOpWaarschijnlijkheid', $_POST['nakansopwaarschijnlijkheid']);

    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Regel opgeslagen.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
    }
}
?>



<div class="container">
    <div class="page-header">
        <h1>Organisatieregel toevoegen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form action="organisatie.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" method="post">
        <h3>Risico inventarisatie</h3>
        <div class="form-group">
            <label for="aspect">Aspect</label>
            <input type="text" class="form-control" name="aspect" id="aspect">
        </div>
        <div class="form-group">
            <label for="effect">Effect</label>
            <input type="text" class="form-control" name="effect" id="effect">
        </div>
        <div class="form-group">
            <label for="arboonderwerp">Arbo onderwerp</label>
            <input type="text" class="form-control" name="arboonderwerp" id="arboonderwerp">
        </div>
        <div class="form-group">
            <label for="huidigebeheersmaatregel">Huidige beheersmaatregel</label>
            <textarea class="form-control" rows="2" name="huidigebeheersmaatregel" id="huidigebeheersmaatregel"></textarea>
        </div>
        <h3>Risico voor maatregelen</h3>
        <div class="form-group">
            <label for="voorgesteldeactieteruitvoering">Voorgestelde actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="voorgesteldeactieteruitvoering" id="voorgesteldeactieteruitvoering"></textarea>
        </div>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="voorernstvanongeval">Ernst van ongeval</label>
            <input type="text" class="form-control" name="voorernstvanongeval" id="voorernstvanongeval">
            <small id="voorernstvanongeval" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="voorkansopblootstelling">Kans op blootstelling</label>
            <input type="text" class="form-control" name="voorkansopblootstelling" id="voorkansopblootstelling">
            <small id="voorkansopblootstelling" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
        </div>
        <div class="form-group">
            <label for="voorkansopwaarschijnlijkheid">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="voorkansopwaarschijnlijkheid" id="voorkansopwaarschijnlijkheid">
            <small id="voorkansopwaarschijnlijkheid" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0,5 of 0,2</small>
        </div>
        <h3>Risico na maatregelen</h3>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="naernstvanongeval">Ernst van ongeval</label>
            <input type="text" class="form-control" name="naernstvanongeval" id="naernstvanongeval">
            <small id="naernstvanongeval" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="nakansopblootstelling">Kans op blootstelling</label>
            <input type="text" class="form-control" name="nakansopblootstelling" id="nakansopblootstelling">
            <small id="nakansopblootstelling" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
        </div>
        <div class="form-group">
            <label for="nakansopwaarschijnlijkheid">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="nakansopwaarschijnlijkheid" id="nakansopwaarschijnlijkheid">
            <small id="nakansopwaarschijnlijkheid" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0,5 of 0,2</small>
        </div>
        <div class="form-group">
            <label for="afwijkendeactieteruitvoering">Afwijkende actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="afwijkendeactieteruitvoering" id="afwijkendeactieteruitvoering"></textarea>
        </div>
        <div class="form-group">
            <label for="naernstvanongeval">Rest risico</label>
            <textarea class="form-control" rows="2" name="restrisico" id="restrisico"></textarea>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit">Regel opslaan</button>
    </form>
    <br>
</div>

<?php include_once('footer.php'); ?>
