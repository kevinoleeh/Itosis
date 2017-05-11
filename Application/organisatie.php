<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.INSERT_ORGANISATIE_RISICOREGEL
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :ASPECT,
             :EFFECT,
             :ARBO_ONDERWERP,
             :HUIDIGE_BEHEERSMAATREGEL,
             :VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
             :AFWIJKENDE_ACTIE_TER_UITVOERING,
             :RESTRISICO,
             :VOOR_ERNST_VAN_ONGEVAL,
             :VOOR_KANS_OP_BLOOTSTELLING,
             :VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
             :NA_ERNST_VAN_ONGEVAL,
             :NA_KANS_OP_BLOOTSTELLING,
             :NA_KANS_OP_WAARSCHIJNLIJKHEID";

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
>>>>>>> origin/development
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':ASPECT', $_POST['ASPECT']);
    $stmt->bindParam(':EFFECT', $_POST['EFFECT']);
    $stmt->bindParam(':ARBO_ONDERWERP', $_POST['ARBO_ONDERWERP']);
    $stmt->bindParam(':HUIDIGE_BEHEERSMAATREGEL', $_POST['HUIDIGE_BEHEERSMAATREGEL']);
    $stmt->bindParam(':VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL', $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL']);
    $stmt->bindParam(':AFWIJKENDE_ACTIE_TER_UITVOERING', $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING']);
    $stmt->bindParam(':RESTRISICO', $_POST['RESTRISICO']);
    $stmt->bindParam(':VOOR_ERNST_VAN_ONGEVAL', $_POST['VOOR_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':VOOR_KANS_OP_BLOOTSTELLING', $_POST['VOOR_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':VOOR_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID']);
    $stmt->bindParam(':NA_ERNST_VAN_ONGEVAL', $_POST['NA_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':NA_KANS_OP_BLOOTSTELLING', $_POST['NA_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':NA_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID']);

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
            <label for="ASPECT">Aspect</label>
            <input type="text" class="form-control" name="ASPECT">
        </div>
        <div class="form-group">
            <label for="EFFECT">Effect</label>
            <input type="text" class="form-control" name="EFFECT">
        </div>
        <div class="form-group">
            <label for="ARBO_ONDERWERP">Arbo onderwerp</label>
            <input type="text" class="form-control" name="ARBO_ONDERWERP" id="arboonderwerp">
        </div>
        <div class="form-group">
            <label for="HUIDIGE_BEHEERSMAATREGEL">Huidige beheersmaatregel</label>
            <textarea class="form-control" rows="2" name="HUIDIGE_BEHEERSMAATREGEL"></textarea>
        </div>
        <h3>Risico voor maatregelen</h3>
        <div class="form-group">
            <label for="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL">Voorgestelde actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL"></textarea>
        </div>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="VOOR_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="VOOR_ERNST_VAN_ONGEVAL">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_BLOOTSTELLING">
            <small id="VOOR_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0.5</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_WAARSCHIJNLIJKHEID">
            <small id="VOOR_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2</small>
        </div>
        <h3>Risico na maatregelen</h3>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="NA_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="NA_ERNST_VAN_ONGEVAL">
            <small id="NA_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="NA_KANS_OP_BLOOTSTELLING">
            <small id="NA_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="NA_KANS_OP_WAARSCHIJNLIJKHEID">
            <small id="NA_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2</small>
        </div>
        <div class="form-group">
            <label for="AFWIJKENDE_ACTIE_TER_UITVOERING">Afwijkende actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="AFWIJKENDE_ACTIE_TER_UITVOERING"></textarea>
        </div>
        <div class="form-group">
            <label for="RESTRISICO">Rest risico</label>
            <textarea class="form-control" rows="2" name="RESTRISICO"></textarea>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit">Regel opslaan</button>
    </form>
    <br>
</div>

<<<<<<< HEAD
<?php include_once('include/footer.php'); ?>
=======
<?php include_once('footer.php'); ?>
>>>>>>> origin/development
