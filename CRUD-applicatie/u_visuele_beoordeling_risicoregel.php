<?php

include_once('include/header.php');
include_once('include/risicoregel/effect_aspect.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_VISUELE_BEOORDELING_RISICOREGEL
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :REGELNUMMER,
             :ASPECTNAAM,
             :EFFECTNAAM,
             :ARBO_ONDERWERP,
             :RISICO_OMSCHRIJVING_OF_BEVINDING,
             :HUIDIGE_BEHEERSMAATREGEL,
             :VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
             :AFWIJKENDE_ACTIE_TER_UITVOERING,
             :RESTRISICO,
             :PROCES,
	         :MACHINE_ONDERDEEL,
	         :AFDELING,
             :VOOR_ERNST_VAN_HET_ONGEVAL,
             :VOOR_KANS_OP_BLOOTSTELLING,
             :VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
             :NA_ERNST_VAN_ONGEVAL,
             :NA_KANS_OP_BLOOTSTELLING,
             :NA_KANS_OP_WAARSCHIJNLIJKHEID";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':ASPECTNAAM', $_POST['ASPECTNAAM']);
    $stmt->bindParam(':EFFECTNAAM', $_POST['EFFECTNAAM']);
    $stmt->bindParam(':ARBO_ONDERWERP', $_POST['ARBO_ONDERWERP']);
    $stmt->bindParam(':RISICO_OMSCHRIJVING_OF_BEVINDING', $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING']);
    $stmt->bindParam(':HUIDIGE_BEHEERSMAATREGEL', $_POST['HUIDIGE_BEHEERSMAATREGEL']);
    $stmt->bindParam(':VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL', $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL']);
    $stmt->bindParam(':AFWIJKENDE_ACTIE_TER_UITVOERING', $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING']);
    $stmt->bindParam(':RESTRISICO', $_POST['RESTRISICO']);
    $stmt->bindParam(':VOOR_ERNST_VAN_HET_ONGEVAL', $_POST['VOOR_ERNST_VAN_HET_ONGEVAL']);
    $stmt->bindParam(':VOOR_KANS_OP_BLOOTSTELLING', $_POST['VOOR_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':VOOR_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID']);
    $stmt->bindParam(':NA_ERNST_VAN_ONGEVAL', $_POST['NA_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':NA_KANS_OP_BLOOTSTELLING', $_POST['NA_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':NA_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID']);
    $stmt->bindParam(':PROCES', $_POST['PROCES']);
    $stmt->bindParam(':MACHINE_ONDERDEEL', $_POST['MACHINE_ONDERDEEL']);
    $stmt->bindParam(':AFDELING', $_POST['AFDELING']);

    try {
        $stmt->execute();
        // Redirect om de parameters uit de URL te halen
        header('Location: rd_risicoregels.php?projectnummer=' . $_GET['projectnummer'] . '&rapportnummer=' . $_GET['rapportnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet geüpdatet. Foutmelding: " . $e->getMessage();

        $result['ARBO_ONDERWERP'] = $_POST['ARBO_ONDERWERP'];
        $result['ASPECTNAAM'] = $_POST['ASPECTNAAM'];
        $result['EFFECTNAAM'] = $_POST['EFFECTNAAM'];
        $result['RISICO_OMSCHRIJVING_OF_BEVINDING'] = $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING'];
        $result['HUIDIGE_BEHEERSMAATREGEL'] = $_POST['HUIDIGE_BEHEERSMAATREGEL'];
        $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'] = $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
        $result['AFWIJKENDE_ACTIE_TER_UITVOERING'] = $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING'];
        $result['RESTRISICO'] = $_POST['RESTRISICO'];
        $result['VOOR_ERNST_VAN_HET_ONGEVAL'] = $_POST['VOOR_ERNST_VAN_HET_ONGEVAL'];
        $result['VOOR_KANS_OP_BLOOTSTELLING'] = $_POST['VOOR_KANS_OP_BLOOTSTELLING'];
        $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['NA_ERNST_VAN_ONGEVAL'] = $_POST['NA_ERNST_VAN_ONGEVAL'];
        $result['NA_KANS_OP_BLOOTSTELLING'] = $_POST['NA_KANS_OP_BLOOTSTELLING'];
        $result['NA_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['PROCES'] = $_POST['PROCES'];
        $result['MACHINE_ONDERDEEL'] = $_POST['MACHINE_ONDERDEEL'];
        $result['AFDELING'] = $_POST['AFDELING'];
    }
}

$query = "SELECT *
          FROM RISICOREGEL RR INNER JOIN VISUELE_BEOORDELING VB
          ON RR.PROJECTNUMMER = VB.PROJECTNUMMER
          AND RR.RAPPORTNUMMER = VB.RAPPORTNUMMER
          AND RR.REGELNUMMER = VB.REGELNUMMER
          WHERE RR.PROJECTNUMMER = :PROJECTNUMMER
          AND RR.RAPPORTNUMMER = :RAPPORTNUMMER
          AND RR.REGELNUMMER = :REGELNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
$result = null;

try {
    $stmt->execute();
    $result = $stmt->fetch();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

$query = "SELECT *
          FROM RISICOREGEL_HISTORY
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER
          AND REGELNUMMER = :REGELNUMMER
          ORDER BY DATUM DESC";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
$history = null;

try {
    $stmt->execute();
    $history = $stmt->fetchAll();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

?>

<script>
    function ShowDiv() {
        document.getElementById("versiebeheer").style.display = "";
    }
</script>

<div class="container">
    <div class="page-header">
        <h1>Visuele beoordelingregel wijzigingen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form method="post" id="uvisuelebeoordeling">
        <?php include_once('include/risicoregel/form_risicoregel.php') ?>
        <?php include_once('include/risicoregel/form_visuele_beoordeling.php') ?>

        <button class="btn btn-block btn-primary" name="submit" type="submit">Regel updaten</button>
    </form>

    <hr>

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
                        <th>Arbo onderwerp</th>
                        <th>Aspect</th>
                        <th>Effect</th>
                        <th>Risico omschrijving of bevinding</th>
                        <th>Huidige beheersmaatregel</th>
                        <th>Voorgestelde actie ter uitvoering</th>
                        <th>Voor ernst van ongeval</th>
                        <th>Voor kans op blootstelling</th>
                        <th>Voor kans op waarschijnlijkheid</th>
                        <th>Voor risico</th>
                        <th>Voor prioriteit</th>
                        <th>Na ernst van ongeval</th>
                        <th>Na kans op blootstelling</th>
                        <th>Na kans op waarschijnlijkheid</th>
                        <th>Na risico</th>
                        <th>Na prioriteit</th>
                        <th>Afwijkende actie ter uitvoering</th>
                        <th>Rest risico</th>
                        <th>Proces</th>
                        <th>Machine(onderdeel)</th>
                        <th>Afdeling</th>
                    </tr>
                    </thead>
                    <tbody>
                    <?php foreach ($history as $value) { ?>
                        <tr>
                            <td><?= $value['DATUM'] ?></td>
                            <td><?= $value['GEBRUIKER'] ?></td>
                            <td><?= $value['ACTIE'] ?></td>
                            <td><?= $value['ARBO_ONDERWERP'] ?></td>
                            <td><?= $value['ASPECTNAAM'] ?></td>
                            <td><?= $value['EFFECTNAAM'] ?></td>
                            <td><?= $value['RISICO_OMSCHRIJVING_OF_BEVINDING'] ?></td>
                            <td><?= $value['HUIDIGE_BEHEERSMAATREGEL'] ?></td>
                            <td><?= $value['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'] ?></td>
                            <td><?= $value['VOOR_ERNST_VAN_ONGEVAL'] ?></td>
                            <td><?= $value['VOOR_KANS_OP_BLOOTSTELLING'] ?></td>
                            <td><?= $value['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'] ?></td>
                            <td><?= $value['VOOR_RISICO'] ?></td>
                            <td><?= $value['VOOR_PRIORITEIT'] ?></td>
                            <td><?= $value['NA_ERNST_VAN_ONGEVAL'] ?></td>
                            <td><?= $value['NA_KANS_OP_BLOOTSTELLING'] ?></td>
                            <td><?= $value['NA_KANS_OP_WAARSCHIJNLIJKHEID'] ?></td>
                            <td><?= $value['NA_RISICO'] ?></td>
                            <td><?= $value['NA_PRIORITEIT'] ?></td>
                            <td><?= $value['AFWIJKENDE_ACTIE_TER_UITVOERING'] ?></td>
                            <td><?= $value['RESTRISICO'] ?></td>
                            <td><?= $value['PROCES'] ?></td>
                            <td><?= $value['MACHINE_ONDERDEEL'] ?></td>
                            <td><?= $value['AFDELING'] ?></td>
                        </tr>
                    <?php } ?>
                    </tbody>
                </table>
            <?php } else { ?>
                <p>Er zijn geen oudere versies.</p>
            <?php } ?>
        </div>
    </div>
    <br>
</div>

<?php include_once('include/footer.php'); ?>
<?php include_once('include/pdo-disconnect.php') ?>
