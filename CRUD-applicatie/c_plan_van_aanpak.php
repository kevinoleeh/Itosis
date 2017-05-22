<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_INSERT_PLAN_VAN_AANPAK 
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :REGELNUMMER,
             :UITGEVOERD_DOOR,
             :EINDVERANTWOORDELIJKE,
             :DATUM_GEREED_GEPLAND,
             :PBM,
             :VOORLICHTING,
             :WERKINSTRUCTIE_PROCEDURE,
             :TRA,
             :CONTRACT_LIJST_";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':UITGEVOERD_DOOR', $_POST['UITGEVOERD_DOOR']);
    $stmt->bindParam(':EINDVERANTWOORDELIJKE', $_POST['EINDVERANTWOORDELIJKE']);
    $stmt->bindParam(':DATUM_GEREED_GEPLAND', $_POST['DATUM_GEREED_GEPLAND']);
    $stmt->bindParam(':PBM', $_POST['PBM']);
    $stmt->bindParam(':VOORLICHTING', $_POST['VOORLICHTING']);
    $stmt->bindParam(':WERKINSTRUCTIE_PROCEDURE', $_POST['WERKINSTRUCTIE_PROCEDURE']);
    $stmt->bindParam(':TRA', $_POST['TRA']);
    $stmt->bindParam(':CONTRACT_LIJST_', $_POST['CONTRACT_LIJST_']);


    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Plan van aanpak opgeslagen.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Plan van aanpak niet opgeslagen. Foutmelding: " . $e->getMessage();


        $result['UITGEVOERD_DOOR'] = $_POST['UITGEVOERD_DOOR'];
        $result['EINDVERANTWOORDELIJKE'] = $_POST['EINDVERANTWOORDELIJKE'];
        $result['PBM'] = $_POST['PBM'];
        $result['VOORLICHTING'] = $_POST['VOORLICHTING'];
        $result['WERKINSTRUCTIE_PROCEDURE'] = $_POST['WERKINSTRUCTIE_PROCEDURE'];
        $result['TRA'] = $_POST['TRA'];
        $result['CONTRACT_LIJST_'] = $_POST['CONTRACT_LIJST_'];
    }
}

?>

<div class="container" xmlns="http://www.w3.org/1999/html">
    <div class="row">
        <div class="page-header">
            <h1>Plan van Aanpak toevoegen</h1>
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
        <form action="c_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['rapportnummer'] ?> " method="post">
            <h3>Plan van aanpak</h3>
            <div class="form-group">
                <label for="UITGEVOERD_DOOR">Uitgevoerd door:</label>
                <input type="text" class="form-control" name="UITGEVOERD_DOOR" value="<?php if(isset($result['UITGEVOERD_DOOR'])) { echo $result['UITGEVOERD_DOOR']; } ?>">
            </div>
            <div class="form-group">
                <label for="EINDVERANTWOORDELIJKE">Eindverantwoordelijke</label>
                <input type="text" class="form-control" name="EINDVERANTWOORDELIJKE" value="<?php if(isset($result['EINDVERANTWOORDELIJKE'])) { echo $result['EINDVERANTWOORDELIJKE']; } ?>">
            </div>
            <div class="form-group">
                <label for="DATUM_GEREED_GEPLAND">Datum gereed gepland</label>
                <input type="text" class="form-control" name="DATUM_GEREED_GEPLAND" value="<?php if(isset($result['DATUM_GEREED_GEPLAND'])) { echo $result['DATUM_GEREED_GEPLAND']; } ?>">
            </div>
            <div class="form-group">
                <label for="PBM">PBM</label>
                <textarea class="form-control" rows="2" name="PBM"><?php if(isset($result['PBM'])) { echo $result['PBM']; } ?></textarea>
            </div>
            <div class="form-group">
                <label for="VOORLICHTING">Voorlichting</label>
                <textarea class="form-control" rows="2" name="VOORLICHTING"><?php if(isset($result['VOORLICHTING'])) { echo $result['VOORLICHTING']; } ?></textarea>
            </div>
            <div class="form-group">
                <label for="WERKINSTRUCTIE_PROCEDURE">Werkinstructie procedure</label>
                <textarea class="form-control" rows="2" name="WERKINSTRUCTIE_PROCEDURE"><?php if(isset($result['WERKINSTRUCTIE_PROCEDURE'])) { echo $result['WERKINSTRUCTIE_PROCEDURE']; } ?></textarea>
            </div>
            <div class="form-group">
                <label for="TRA">TRA</label>
                <textarea class="form-control" rows="2" name="TRA"><?php if(isset($result['TRA'])) { echo $result['TRA']; } ?></textarea>
            </div>
            <div class="form-group">
                <label for="CONTRACT_LIJST_">Controlelijst</label>
                <textarea class="form-control" rows="2" name="CONTRACT_LIJST_"><?php if(isset($result['CONTRACT_LIJST_'])) { echo $result['CONTRACT_LIJST_']; } ?></textarea>
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
</div>

<?php include_once('include/footer.php'); ?>
