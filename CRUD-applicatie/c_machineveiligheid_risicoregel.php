<?php include_once('include/header.php');
include_once('include/risicoregel/effect_aspect.php'); ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_INSERT_MACHINEVEILIGHEID_RISICOREGEL
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :PID,
             :LIJN,
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
             :MACHINE_CODE,
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
    $stmt->bindParam(':AFSCHERMING', $_POST['AFSCHERMING'], PDO::PARAM_INT);
    $stmt->bindParam(':INSTRUCTIE', $_POST['INSTRUCTIE'], PDO::PARAM_INT);
    $stmt->bindParam(':FREQUENTIE', $_POST['FREQUENTIE'], PDO::PARAM_INT);
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
?>

<div class="container">
    <div class="page-header">
        <h1>Machineveiligheidregel toevoegen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form method="post">
        <?php include_once('include/risicoregel/form_risicoregel.php') ?>
        <?php include_once('include/risicoregel/form_visuele_beoordeling.php') ?>
        <?php include_once('include/risicoregel/form_machineveiligheid.php') ?>
        <button class="btn btn-block btn-primary" name="submit" type="submit">Regel updaten</button>
    </form>
    <br>
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
</script>
