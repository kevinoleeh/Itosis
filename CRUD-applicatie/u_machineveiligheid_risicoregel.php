<?php include_once('include/header.php');
include_once('include/risicoregel/effect_aspect.php'); ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_MACHINEVEILIGHEID_RISICOREGEL
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :REGELNUMMER,
             :PID,
             :LIJN,
             :MACHINE_CODE,
             :ASPECTNAAM,
             :EFFECTNAAM,
             :ARBO_ONDERWERP,
             :RISICO_OMSCHRIJVING_OF_BEVINDING,
             :HUIDIGE_BEHEERSMAATREGEL,
             :VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL,
             :AFWIJKENDE_ACTIE_TER_UITVOERING,
             :RESTRISICO,
             :PROCES,
             :MACHINE_ONDERDEEL_,
             :AFDELING,
             :MACHINE,
             :MODEL_TYPE,
             :SERIENUMMER,
             :LEVERANCIER,
             :CE_MARKERING,
             :CE_DOCUCHECK,
             :AANVULLENDE_OMSCHRIJVING,
             :TAKEN,
             :TRANSPORT,
             :MONTAGE,
             :IN_BEDRIJFSNAME,
             :TIJDENS_PRODUCTIE,
             :TIJDENS_ONDERHOUD,
             :TIJDENS_STORING,
             :TIJDENS_REINIGEN,
             :TIJDENS_AFSTELLEN,
             :DEMONTAGE,
             :ONTWERP,
             :AFSCHERMING,
             :INSTRUCTIE,
             :FREQUENTIE,
             :MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS,
             :MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE,
             :ERNST_VAN_DE_GEVOLGEN,
             :VOOR_ERNST_VAN_ONGEVAL,
             :VOOR_KANS_OP_BLOOTSTELLING,
             :VOOR_KANS_OP_WAARSCHIJNLIJKHEID,
             :NA_ERNST_VAN_ONGEVAL,
             :NA_KANS_OP_BLOOTSTELLING,
             :NA_KANS_OP_WAARSCHIJNLIJKHEID";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':PID', $_POST['PID']);
    $stmt->bindParam(':LIJN', $_POST['LIJN']);
    $stmt->bindParam(':ASPECTNAAM', $_POST['ASPECTNAAM']);
    $stmt->bindParam(':EFFECTNAAM', $_POST['EFFECTNAAM']);
    $stmt->bindParam(':ARBO_ONDERWERP', $_POST['ARBO_ONDERWERP']);
    $stmt->bindParam(':RISICO_OMSCHRIJVING_OF_BEVINDING', $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING']);
    $stmt->bindParam(':HUIDIGE_BEHEERSMAATREGEL', $_POST['HUIDIGE_BEHEERSMAATREGEL']);
    $stmt->bindParam(':VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL', $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL']);
    $stmt->bindParam(':AFWIJKENDE_ACTIE_TER_UITVOERING', $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING']);
    $stmt->bindParam(':RESTRISICO', $_POST['RESTRISICO']);
    $stmt->bindParam(':PROCES', $_POST['PROCES']);
    $stmt->bindParam(':MACHINE_ONDERDEEL_', $_POST['MACHINE_ONDERDEEL_']);
    $stmt->bindParam(':AFDELING', $_POST['AFDELING']);
    $stmt->bindParam(':MACHINE_CODE', $_POST['MACHINE_CODE']);
    $stmt->bindParam(':MACHINE', $_POST['MACHINE']);
    $stmt->bindParam(':MODEL_TYPE', $_POST['MODEL_TYPE']);
    $stmt->bindParam(':SERIENUMMER', $_POST['SERIENUMMER']);
    $stmt->bindParam(':LEVERANCIER', $_POST['LEVERANCIER']);
    $stmt->bindParam(':CE_MARKERING', $_POST['CE_MARKERING']);
    $stmt->bindParam(':CE_DOCUCHECK', $_POST['CE_DOCUCHECK']);
    $stmt->bindParam(':AANVULLENDE_OMSCHRIJVING', $_POST['AANVULLENDE_OMSCHRIJVING']);
    $stmt->bindParam(':TAKEN', $_POST['TAKEN']);
    $stmt->bindParam(':TRANSPORT', $_POST['TRANSPORT'], PDO::PARAM_INT);
    $stmt->bindParam(':MONTAGE', $_POST['MONTAGE'], PDO::PARAM_INT);
    $stmt->bindParam(':IN_BEDRIJFSNAME', $_POST['IN_BEDRIJFSNAME'], PDO::PARAM_INT);
    $stmt->bindParam(':TIJDENS_PRODUCTIE', $_POST['TIJDENS_PRODUCTIE'], PDO::PARAM_INT);
    $stmt->bindParam(':TIJDENS_ONDERHOUD', $_POST['TIJDENS_ONDERHOUD'], PDO::PARAM_INT);
    $stmt->bindParam(':TIJDENS_STORING', $_POST['TIJDENS_STORING'], PDO::PARAM_INT);
    $stmt->bindParam(':TIJDENS_REINIGEN', $_POST['TIJDENS_REINIGEN'], PDO::PARAM_INT);
    $stmt->bindParam(':TIJDENS_AFSTELLEN', $_POST['TIJDENS_AFSTELLEN'], PDO::PARAM_INT);
    $stmt->bindParam(':DEMONTAGE', $_POST['DEMONTAGE'], PDO::PARAM_INT);
    $stmt->bindParam(':ONTWERP', $_POST['ONTWERP'], PDO::PARAM_INT);
    $stmt->bindParam(':AFSCHERMING', $_POST['AFSCHERMING']);
    $stmt->bindParam(':INSTRUCTIE', $_POST['INSTRUCTIE']);
    $stmt->bindParam(':FREQUENTIE', $_POST['FREQUENTIE']);
    $stmt->bindParam(':MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS', $_POST['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS']);
    $stmt->bindParam(':MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE', $_POST['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE']);
    $stmt->bindParam(':ERNST_VAN_DE_GEVOLGEN', $_POST['ERNST_VAN_DE_GEVOLGEN']);
    $stmt->bindParam(':VOOR_ERNST_VAN_ONGEVAL', $_POST['VOOR_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':VOOR_KANS_OP_BLOOTSTELLING', $_POST['VOOR_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':VOOR_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID']);
    $stmt->bindParam(':NA_ERNST_VAN_ONGEVAL', $_POST['NA_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':NA_KANS_OP_BLOOTSTELLING', $_POST['NA_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':NA_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID']);
    try {
        $stmt->execute();
        header('Location: rd_regels.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();

        $result['PID'] = $_POST['PID'];
        $result['LIJN'] = $_POST['LIJN'];
        $result['ASPECTNAAM'] = $_POST['ASPECTNAAM'];
        $result['EFFECTNAAM'] = $_POST['EFFECTNAAM'];
        $result['ARBO_ONDERWERP'] = $_POST['ARBO_ONDERWERP'];
        $result['RISICO_OMSCHRIJVING_OF_BEVINDING'] = $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING'];
        $result['HUIDIGE_BEHEERSMAATREGEL'] = $_POST['HUIDIGE_BEHEERSMAATREGEL'];
        $result['PROCES'] = $_POST['PROCES'];
        $result['MACHINE_ONDERDEEL_'] = $_POST['MACHINE_ONDERDEEL_'];
        $result['AFDELING'] = $_POST['AFDELING'];
        $result['MACHINE'] = $_POST['MACHINE'];
        $result['MACHINE_CODE'] = $_POST['MACHINE_CODE'];
        $result['MODEL_TYPE'] = $_POST['MODEL_TYPE'];
        $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'] = $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
        $result['AFWIJKENDE_ACTIE_TER_UITVOERING'] = $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING'];
        $result['RESTRISICO'] = $_POST['RESTRISICO'];
        $result['VOOR_ERNST_VAN_ONGEVAL'] = $_POST['VOOR_ERNST_VAN_ONGEVAL'];
        $result['VOOR_KANS_OP_BLOOTSTELLING'] = $_POST['VOOR_KANS_OP_BLOOTSTELLING'];
        $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['NA_ERNST_VAN_ONGEVAL'] = $_POST['NA_ERNST_VAN_ONGEVAL'];
        $result['NA_KANS_OP_BLOOTSTELLING'] = $_POST['NA_KANS_OP_BLOOTSTELLING'];
        $result['NA_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['SERIENUMMER'] = $_POST['SERIENUMMER'];
        $result['LEVERANCIER'] = $_POST['LEVERANCIER'];
        $result['CE_MARKERING'] = $_POST['CE_MARKERING'];
        $result['CE_DOCUCHECK'] = $_POST['CE_DOCUCHECK'];
        $result['AANVULLENDE_OMSCHRIJVING'] = $_POST['AANVULLENDE_OMSCHRIJVING'];
        $result['TAKEN'] = $_POST['TAKEN'];
        $result['TRANSPORT'] = $_POST['TRANSPORT'];
        $result['MONTAGE'] = $_POST['MONTAGE'];
        $result['IN_BEDRIJFSNAME'] = $_POST['IN_BEDRIJFSNAME'];
        $result['TIJDENS_PRODUCTIE'] = $_POST['TIJDENS_PRODUCTIE'];
        $result['TIJDENS_ONDERHOUD'] = $_POST['TIJDENS_ONDERHOUD'];
        $result['TIJDENS_STORING'] = $_POST['TIJDENS_STORING'];
        $result['TIJDENS_REINIGEN'] = $_POST['TIJDENS_REINIGEN'];
        $result['TIJDENS_AFSTELLEN'] = $_POST['TIJDENS_AFSTELLEN'];
        $result['DEMONTAGE'] = $_POST['DEMONTAGE'];
        $result['ONTWERP'] = $_POST['ONTWERP'];
        $result['AFSCHERMING'] = $_POST['ONTWERP'];
        $result['INSTRUCTIE'] = $_POST['INSTRUCTIE'];
        $result['FREQUENTIE'] = $_POST['FREQUENTIE'];
        $result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'] = $_POST['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'];
        $result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'] = $_POST['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'];
        $result['ERNST_VAN_DE_GEVOLGEN'] = $_POST['ERNST_VAN_DE_GEVOLGEN'];
    }
}

$query = "SELECT *
          FROM RISICOREGEL RR INNER JOIN VISUELE_BEOORDELING VB
          ON RR.PROJECTNUMMER = VB.PROJECTNUMMER
          AND RR.RAPPORTNUMMER = VB.RAPPORTNUMMER
          AND RR.REGELNUMMER = VB.REGELNUMMER
          INNER JOIN MACHINEVEILIGHEID MV
          ON RR.PROJECTNUMMER = MV.PROJECTNUMMER
          AND RR.RAPPORTNUMMER = MV.RAPPORTNUMMER
          AND RR.REGELNUMMER = MV.REGELNUMMER
          WHERE RR.PROJECTNUMMER = :PROJECTNUMMER
          AND RR.RAPPORTNUMMER = :RAPPORTNUMMER
          AND RR.REGELNUMMER = :REGELNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
$stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);

try {
    $stmt->execute();
    $result = $stmt->fetch();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
}

$query = "SELECT RRH.*, VBH.PROCES, VBH.MACHINE_ONDERDEEL_, VBH.AFDELING, MH.*
          FROM RISICOREGEL_HISTORY RRH INNER JOIN VISUELE_BEOORDELING_HISTORY VBH
          ON RRH.PROJECTNUMMER = VBH.PROJECTNUMMER
          AND RRH.RAPPORTNUMMER = VBH.RAPPORTNUMMER
          AND RRH.REGELNUMMER = VBH.REGELNUMMER
          AND RRH.VERSIENUMMER = VBH.VERSIENUMMER
          INNER JOIN MACHINEVEILIGHEID_HISTORY MH
          ON RRH.PROJECTNUMMER = MH.PROJECTNUMMER
          AND RRH.RAPPORTNUMMER = MH.RAPPORTNUMMER
          AND RRH.REGELNUMMER = MH.REGELNUMMER
          AND RRH.VERSIENUMMER = MH.VERSIENUMMER
          WHERE RRH.PROJECTNUMMER = :PROJECTNUMMER
          AND RRH.RAPPORTNUMMER = :RAPPORTNUMMER
          AND RRH.REGELNUMMER = :REGELNUMMER
          ORDER BY RRH.DATUM DESC";
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

<div class="container">
    <div class="page-header">
        <h1>Machineveiligheidregel wijzigen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form method="post">
        <?php include_once('include/risicoregel/form_risicoregel.php') ?>
        <?php include_once('include/risicoregel/form_visuele_beoordeling.php') ?>
        <?php include_once('include/risicoregel/form_machineveiligheid.php') ?>
        <button class="btn btn-block btn-primary" name="submit" type="submit">Regel updaten</button>
    </form>
    <br>

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
                        <th>PID</th>
                        <th>Lijn</th>
                        <th>Machine_code</th>
                        <th>Machine</th>
                        <th>Model_type</th>
                        <th>Serienummer</th>
                        <th>Leverancier</th>
                        <th>CE Markering</th>
                        <th>CE Docucheck</th>
                        <th>Aanvullende omschrijving</th>
                        <th>Taken</th>
                        <th>In bedrijfsname</th>
                        <th>Tijdens productie</th>
                        <th>Tijdens onderhoud</th>
                        <th>Tijdens storing</th>
                        <th>Tijdens reinigen</th>
                        <th>Tijdens afstellen</th>
                        <th>Demontage</th>
                        <th>Ontwerp</th>
                        <th>Afscherming</th>
                        <th>Instructie</th>
                        <th>Frequentie</th>
                        <th>Mogelijkheid optreden gevaarlijk gebeurtenis</th>
                        <th>Mogelijkheid voorkomen of beperken schade</th>
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
                            <td><?= $value['MACHINE_ONDERDEEL_'] ?></td>
                            <td><?= $value['AFDELING'] ?></td>
                            <td><?= $value['PID'] ?></td>
                            <td><?= $value['LIJN'] ?></td>
                            <td><?= $value['MACHINE_CODE'] ?></td>
                            <td><?= $value['MACHINE'] ?></td>
                            <td><?= $value['MODEL_TYPE'] ?></td>
                            <td><?= $value['SERIENUMMER'] ?></td>
                            <td><?= $value['LEVERANCIER'] ?></td>
                            <td><?= $value['CE_MARKERING'] ?></td>
                            <td><?= $value['CE_DOCUCHECK'] ?></td>
                            <td><?= $value['AANVULLENDE_OMSCHRIJVING'] ?></td>
                            <td><?= $value['TAKEN'] ?></td>
                            <td><?= ($value['IN_BEDRIJFSNAME'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['TIJDENS_PRODUCTIE'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['TIJDENS_ONDERHOUD'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['TIJDENS_STORING'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['TIJDENS_REINIGEN'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['TIJDENS_AFSTELLEN'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= ($value['DEMONTAGE'] == '1' ? 'Ja' : 'Nee')?></td>
                            <td><?= $value['ONTWERP'] ?></td>
                            <td><?= $value['AFSCHERMING'] ?></td>
                            <td><?= $value['INSTRUCTIE'] ?></td>
                            <td><?= $value['FREQUENTIE'] ?></td>
                            <td><?= $value['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'] ?></td>
                            <td><?= $value['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'] ?></td>
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

</div>
<?php include_once('include/footer.php'); ?>
<script>
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
function ShowDiv() {
    document.getElementById("versiebeheer").style.display = "";
}
</script>
