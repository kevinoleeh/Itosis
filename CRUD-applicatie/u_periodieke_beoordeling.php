<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_PERIODIEKE_BEOORDELING
                 :PROJECTNUMMER,
                 :RAPPORTNUMMER,
                 :REGELNUMMER,
                 :DATUM_BEOORDELING_OUD,
                 :DATUM_BEOORDELING_NIEUW,
                 :INSPECTIE_IS_DE_ACTIE_UITGEVOERD,
                 :OPMERKING_STAND_VAN_ZAKEN,
                 :STAND_VAN_ZAKEN,
                 :SCORE";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':DATUM_BEOORDELING_OUD', $_GET['datum']);
    $stmt->bindParam(':DATUM_BEOORDELING_NIEUW', $_POST['DATUM_BEOORDELING']);
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
}

$query = "SELECT *
              FROM PERIODIEKE_BEOORDELING
              WHERE PROJECTNUMMER = :PROJECTNUMMER
              AND RAPPORTNUMMER = :RAPPORTNUMMER
              AND REGELNUMMER = :REGELNUMMER
              AND DATUM_BEOORDELING = :DATUM_BEOORDELING";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
$stmt->bindParam(':DATUM_BEOORDELING', $_GET['datum']);

try {
    $stmt->execute();
    $result = $stmt->fetch();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

$query = "SELECT PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, DATUM_BEOORDELING, INSPECTIE_IS_DE_ACTIE_UITGEVOERD,
          OPMERKING_STAND_VAN_ZAKEN, STAND_VAN_ZAKEN, SCORE, GEBRUIKER, DATUM, ACTIE
          FROM PERIODIEKE_BEOORDELING_HISTORY
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER
          AND REGELNUMMER = :REGELNUMMER
          AND DATUM_BEOORDELING = :DATUM_BEOORDELING";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
$stmt->bindParam(':DATUM_BEOORDELING', $_GET['datum']);
$history = null;

try {
    $stmt->execute();
    $history = $stmt->fetchall();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}
?>

<div class="container" xmlns="http://www.w3.org/1999/html">
    <div class="row">
        <div class="page-header">
            <h1>Periodieke beoordeling wijzigen</h1>
            <h4>Projectnummer
                <?= $_GET['projectnummer'] ?>, rapportnummer
                <?= $_GET['rapportnummer'] ?>, regelnummer
                <?= $_GET['regelnummer'] ?>
        </div>
    </div>
    <div class="row">
        <?php include_once('include/melding.php') ?>

        <form action="u_periodieke_beoordeling.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['regelnummer'] ?>&datum=<?= $_GET['datum'] ?>" method="post">
            <div class="form-group">
                <label for="DATUM_BEOORDELING">Datum beoordeling</label>
                <input type="date" class="form-control" name="DATUM_BEOORDELING" value="<?php if (isset($result['DATUM_BEOORDELING'])) {
                    echo strftime('%Y-%m-%d', strtotime($result['DATUM_BEOORDELING']));
                } ?>">
            </div>


            <label for="INSPECTIE_IS_DE_ACTIE_UITGEVOERD">Is de actie uitgevoerd?</label><br>
            <div class="form-group">
                <input type="checkbox" style="width: 34px; height: 34px;" rel="INSPECTIE_IS_DE_ACTIE_UITGEVOERD" <?php if(strcmp($result['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'], '1') == 0) { echo 'checked'; } ?>>
            </div>

            <div class="form-group">
                <label for="OPMERKING_STAND_VAN_ZAKEN">Opmerking stand van zaken</label>
                <input type="text" class="form-control" name="OPMERKING_STAND_VAN_ZAKEN" value="<?php if (isset($result['OPMERKING_STAND_VAN_ZAKEN'])) {
                    echo $result['OPMERKING_STAND_VAN_ZAKEN'];
                } ?>">
            </div>
            <div class="form-group">
                <label for="STAND_VAN_ZAKEN">Stand van zaken</label>
                <input type="text" class="form-control" name="STAND_VAN_ZAKEN" value="<?php if (isset($result['STAND_VAN_ZAKEN'])) {
                    echo $result['STAND_VAN_ZAKEN'];
                } ?>">
            </div>
            <div class="form-group">
                <label for="SCORE">Score</label>
                <input type="text" class="form-control" name="SCORE" value="<?php if (isset($result['SCORE'])) {
                    echo $result['SCORE'];
                } ?>">
            </div>


            <button class="btn btn-block btn-primary" name="submit" type="submit">Periodieke beoordeling wijzigen</button>

            <br>
        </form>
        <button class="btn btn-block btn-default" onclick="ShowDiv()">Versiegeschiedenis weergeven</button>

        <div style="display: none;" id="versiebeheer">
            <br>
            <h1>Versiegeschiedenis</h1>
            <div style="overflow: auto;">
                <?php if (count($history) > 0) { ?>
                    <table class="table table-striped table-bordered" style="margin: 0; padding: 0;">
                        <thead>
                        <tr>
                            <th>Datum</th>
                            <th>Gebruiker</th>
                            <th>Actie</th>
                            <th>Projectnummer</th>
                            <th>Rapportnummer</th>
                            <th>Regelnummer</th>
                            <th>Datum beoordeling</th>
                            <th>Inspectie is de actie uitgevoerd</th>
                            <th>Opmerking stand van zaken</th>
                            <th>Stand van zaken</th>
                            <th>Score</th>
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
                                    <?= $value['DATUM_BEOORDELING'] ?>
                                </td>
                                <td>
                                    <?= $value['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'] ?>
                                </td>
                                <td>
                                    <?= $value['OPMERKING_STAND_VAN_ZAKEN'] ?>
                                </td>
                                <td>
                                    <?= $value['SCORE'] ?>
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
</div>

<br>
<?php include_once('include/footer.php'); ?>
<script type="text/javascript">
    var projectnummer = "<?= $_GET['projectnummer'] ?>";
    var rapportnummer = "<?= $_GET['rapportnummer'] ?>";
    $(document).ready(function () {
        var chk = $('input[type="checkbox"]');
        chk.each(function () {
            var v = $(this).attr('checked') == 'checked' ? 1 : 0;
            $(this).after('<input type="hidden" class="form-control" name="' + $(this).attr('rel') + '" value="' + v + '" />');
        });
        chk.change(function () {
            var v = $(this).is(':checked') ? 1 : 0;
            $(this).next('input[type="hidden"]').val(v);
        });
    });

    function ShowDiv() {
        document.getElementById("versiebeheer").style.display = "";
    }
</script>
