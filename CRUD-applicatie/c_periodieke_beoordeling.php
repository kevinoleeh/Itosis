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

        header('Location: u_plan_van_aanpak.php?projectnummer=' . $_GET['projectnummer'] . '&rapportnummer=' . $_GET['rapportnummer'] . '&regelnummer=' . $_GET['regelnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Periodieke beoordeling niet opgeslagen. Foutmelding: " . $e->getMessage();


        $result['DATUM_BEOORDELING'] = $_POST['DATUM_BEOORDELING'];
        $result['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'] = $_POST['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'];
        $result['OPMERKING_STAND_VAN_ZAKEN'] = $_POST['OPMERKING_STAND_VAN_ZAKEN'];
        $result['STAND_VAN_ZAKEN'] = $_POST['STAND_VAN_ZAKEN'];
        $result['SCORE'] = $_POST['SCORE'];

    }
    $query = "SELECT PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, UITGEVOERD_DOOR, EINDVERANTWOORDELIJKE,
              DATUM_GEREED_GEPLAND, PBM, VOORLICHTING, WERKINSTRUCTIE_PROCEDURE, TRA, CONTRACT_LIJST_, GEBRUIKER, DATUM, ACTIE
              FROM PLAN_VAN_AANPAK_HISTORY
              WHERE PROJECTNUMMER = :PROJECTNUMMER
              AND RAPPORTNUMMER = :RAPPORTNUMMER
              AND REGELNUMMER = :REGELNUMMER";
              $stmt = $dbh->prepare($query);
              $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
              $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
              $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
              $history = null;
              try{
              $stmt->execute();
              $history = $stmt->fetchall();
            }
            catch (PDOException $e) {
                $meldingStatus = false;
                $melding = "Periodieke beoordeling niet kunnen ophalen. Foutmelding: " . $e->getMessage();
            }
}

?>

<div class="container" xmlns="http://www.w3.org/1999/html">
    <div class="row">
        <div class="page-header">
            <h1>Periodieke beoordeling toevoegen</h1>
            <h4>Projectnummer
                <?= $_GET['projectnummer'] ?>, rapportnummer
                    <?= $_GET['rapportnummer'] ?>, regelnummer
                        <?= $_GET['regelnummer'] ?>
        </div>
    </div>
    <?php include_once('include/melding.php') ?>

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
            <div class="form-group">
                <input type="checkbox" style="outline: 2px solid" rel="INSPECTIE_IS_DE_ACTIE_UITGEVOERD">
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
        <button class="btn btn-block btn-default" onclick="ShowDiv()">Versiegeschiedenis weergeven</button>

        <div style="display: none;" id="versiebeheer">
            <br>
            <h1>Versiegeschiedenis</h1>
            <div style="overflow: auto;">
                <?php if(count($history) > 0) { ?>
                <table class="table table-striped table-bordered" style="margin: 0; padding: 0;">
                    <thead>
                        <tr>
                            <th>Datum</th>
                            <th>Gebruiker</th>
                            <th>Actie</th>
                            <th>Projectnummer</th>
                            <th>Rapportnummer</th>
                            <th>Regelnummer</th>
                            <th>Uitgevoerd door</th>
                            <th>Eindverantwoordelijke</th>
                            <th>Datum gereed gepland</th>
                            <th>PBM</th>
                            <th>Voorlichting</th>
                            <th>Werkinstructie procedure</th>
                            <th>TRA</th>
                            <th>Contract lijst</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php foreach ($history as $value) { ?>
                        <tr>
                            <td><?= $value['DATUM'] ?></td>
                            <td>
                                <?= $value['GEBRUIKER'] ?>
                            </td>
                            <td>
                                <?= $value['ACTIE'] ?>
                            </td>
                            <td>
                                <?= $value['PROJECTNUMMER'] ?>
                            </td>
                            <td>
                                <?= $value['RAPPORTNUMMER'] ?>
                            </td>
                            <td>
                                <?= $value['REGELNUMMER'] ?>
                            </td>
                            <td>
                                <?= $value['UITGEVOERD_DOOR'] ?>
                            </td>
                            <td>
                                <?= $value['EINDVERANTWOORDELIJKE'] ?>
                            </td>
                            <td>
                                <?= $value['DATUM_GEREED_GEPLAND'] ?>
                            </td>
                            <td>
                                <?= $value['PBM'] ?>
                            </td>
                            <td>
                                <?= $value['VOORLICHTING'] ?>
                            </td>
                            <td>
                                <?= $value['WERKINSTRUCTIE_PROCEDURE'] ?>
                            </td>
                            <td>
                                <?= $value['TRA'] ?>
                            </td>
                            <td>
                                <?= $value['CONTRACT_LIJST_'] ?>
                            </td>
                        </tr>
                        <?php } ?>
                    </tbody>
                </table>
                <?php } else { ?>
                <p>Er zijn geen oudere versies.</p>
                <?php } ?>

    </div>

</div>
</div>

<br>

<?php include_once('include/footer.php'); ?>
<script type="text/javascript">
$(document).ready(function() {
    var chk = $('input[type="checkbox"]');
    chk.each(function(){
        var v = $(this).attr('checked') == 'checked'?1:0;
        $(this).after('<input type="hidden" class="form-control" name="'+$(this).attr('rel')+'" value="'+v+'" />');
    });
    chk.change(function(){
        var v = $(this).is(':checked')?1:0;
        $(this).next('input[type="hidden"]').val(v);
    });
});
    var projectnummer = "<?= $_GET['projectnummer'] ?>";
    var rapportnummer = "<?= $_GET['rapportnummer'] ?>";
    function ShowDiv() {
        document.getElementById("versiebeheer").style.display = "";
    }
</script>
