<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_INSERT_PERIODIEKE_BEOORDELING
                 :PROJECTNUMMER,
                 :RAPPORTNUMMER,
                 :REGELNUMMER,
                 :DATUM_BEOORDELING,
                 :INSPECTIE_IS_DE_ACTIE_UITGEVOERD,
                 :OPMERKING_STAND_VAN_ZAKEN,
                 :STAND_VAN_ZAKEN,
                 :SCORE";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':DATUM_BEOORDELING', $_POST['DATUM_BEOORDELING']);
    $stmt->bindParam(':INSPECTIE_IS_DE_ACTIE_UITGEVOERD', $_POST['INSPECTIE_IS_DE_ACTIE_UITGEVOERD']);
    $stmt->bindParam(':OPMERKING_STAND_VAN_ZAKEN', $_POST['OPMERKING_STAND_VAN_ZAKEN']);
    $stmt->bindParam(':STAND_VAN_ZAKEN', $_POST['STAND_VAN_ZAKEN']);
    $stmt->bindParam(':SCORE', $_POST['SCORE']);

    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Periodieke beoordeling opgeslagen.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Periodieke beoordeling niet opgeslagen. Foutmelding: " . $e->getMessage();


        $result['DATUM_BEOORDELING'] = $_POST['DATUM_BEOORDELING'];
        $result['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'] = $_POST['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'];
        $result['OPMERKING_STAND_VAN_ZAKEN'] = $_POST['OPMERKING_STAND_VAN_ZAKEN'];
        $result['STAND_VAN_ZAKEN'] = $_POST['STAND_VAN_ZAKEN'];
        $result['SCORE'] = $_POST['SCORE'];

    }
}

?>

<div class="container" xmlns="http://www.w3.org/1999/html">
    <div class="row">
        <div class="page-header">
            <h1>Periodieke beoordeling toevoegen</h1>
        </div>
    </div>
    <?php include_once('include/melding.php') ?>

    <div class="row">
        <div class="form-group">
            <div class="col-md-3">
                <label>Projectnummer:</label>
                <input disabled type="text" class="form-control" name="projectnummer"
                       value=" <?= $_GET['projectnummer'] ?>">
            </div>
            <div class="col-md-3">
                <label>Rapportnummer</label>
                <input disabled type="text" class="form-control" name="rapportnummer"
                       value=" <?= $_GET['rapportnummer'] ?>">
            </div>
            <div class="col-md-3">
                <label>Regelnummer:</label>
                <input disabled type="text" class="form-control" name="regelnummer"
                       value=" <?= $_GET['regelnummer'] ?>">
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <form action="c_periodieke_beoordeling.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['regelnummer'] ?> "
              method="post">
            <h3>Periodieke beoordeling toevoegen</h3>
            <div class="form-group">
                <div class="form-group">
                    <label for="DATUM_BEOORDELING">Datum beoordeling</label>
                    <input type="date" class="form-control" name="DATUM_BEOORDELING"
                           value="<?php echo date("Y-m-d"); ?>">
                </div>
            </div>

            <label for="INSPECTIE_IS_DE_ACTIE_UITGEVOERD">Is de actie uitgevoerd?</label>
            <div class="btn-group" data-toggle="buttons">
                <label class="btn btn-success">
                    <input type="radio" name="INSPECTIE_IS_DE_ACTIE_UITGEVOERD" value="1" checked> Ja
                </label>
                <label class="btn btn-danger">
                    <input type="radio" name="INSPECTIE_IS_DE_ACTIE_UITGEVOERD" value="0"> Nee
                </label>
            </div>

            <div class="form-group">
                <label for="OPMERKING_STAND_VAN_ZAKEN">Opmerking stand van zaken</label>
                <input type="text" class="form-control" name="OPMERKING_STAND_VAN_ZAKEN"
                       value="<?php if (isset($result['OPMERKING_STAND_VAN_ZAKEN'])) {
                           echo $result['OPMERKING_STAND_VAN_ZAKEN'];
                       } ?>">
            </div>
            <div class="form-group">
                <label for="STAND_VAN_ZAKEN">Stand van zaken</label>
                <input type="text" class="form-control" name="STAND_VAN_ZAKEN"
                       value="<?php if (isset($result['STAND_VAN_ZAKEN'])) {
                           echo $result['STAND_VAN_ZAKEN'];
                       } ?>">
            </div>
            <div class="form-group">
                <label for="SCORE">Score</label>
                <input type="number" class="form-control" name="SCORE"
                       value="<?php if (isset($result['SCORE'])) {
                           echo $result['SCORE'];
                       } ?>">
            </div>
                <button class="btn btn-block btn-primary" name="submit" type="submit">Aanmaken</button>
        </form>

    </div>

</div>

<br>
<script type="text/javascript">
    var projectnummer = "<?= $_GET['projectnummer'] ?>";
    var rapportnummer = "<?= $_GET['rapportnummer'] ?>";

</script>

<?php include_once('include/footer.php'); ?>
