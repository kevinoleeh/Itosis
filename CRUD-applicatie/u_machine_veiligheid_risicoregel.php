<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_MACHINE_VEILIGHEID_RISICOREGEL
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
             :MACHINE,
             :MODEL__TYPE,
             :SERIENUMMER,
             :LEVERANCIER,
             :CE_MARKERING,
             :CE_DOCUCHECK,
             :TRANSPORT,
             :MONTAGE,
             :IN_BEDRIJFSNAME,
             :TIJDENS_PRODUCTIE,
             :TIJDENS_ONDERHOUD,
             :TIJDENS_STORING,
             :TIJDENS_REINIGEN,
             :TIJDENS_AFSTELLEN,
             :DEMONTAGE,
             :FREQUENTIE,
             :MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS,
             :MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE,
             :ERNST_VAN_DE_GEVOLGEN,
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
    $stmt->bindParam(':PROCES', $_POST['PROCES']);
    $stmt->bindParam(':MACHINE_ONDERDEEL', $_POST['MACHINE_ONDERDEEL']);
    $stmt->bindParam(':AFDELING', $_POST['AFDELING']);
    $stmt->bindParam(':MODEL__TYPE', $_POST['MODEL__TYPE']);
    $stmt->bindParam(':SERIENUMMER', $_POST['SERIENUMMER']);
    $stmt->bindParam(':LEVERANCIER', $_POST['LEVERANCIER']);
    $stmt->bindParam(':CE_MARKERING', $_POST['CE_MARKERING']);
    $stmt->bindParam(':CE_DOCUCHECK', $_POST['CE_DOCUCHECK']);
    $stmt->bindParam(':TRANSPORT', $_POST['TRANSPORT']);
    $stmt->bindParam(':MONTAGE', $_POST['MONTAGE']);
    $stmt->bindParam(':IN_BEDRIJFSNAME', $_POST['IN_BEDRIJFSNAME']);
    $stmt->bindParam(':TIJDENS_PRODUCTIE', $_POST['TIJDENS_PRODUCTIE']);
    $stmt->bindParam(':TIJDENS_ONDERHOUD', $_POST['TIJDENS_ONDERHOUD']);
    $stmt->bindParam(':TIJDENS_STORING', $_POST['TIJDENS_STORING']);
    $stmt->bindParam(':TIJDENS_REINIGEN', $_POST['TIJDENS_REINIGEN']);
    $stmt->bindParam(':TIJDENS_AFSTELLEN', $_POST['TIJDENS_AFSTELLEN']);
    $stmt->bindParam(':DEMONTAGE', $_POST['DEMONTAGE']);
    $stmt->bindParam(':FREQUENTIE', $_POST['FREQUENTIE']);
    $stmt->bindParam(':MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS', $_POST['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS']);
    $stmt->bindParam(':MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE', $_POST['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE']);
    $stmt->bindParam(':ERNST_VAN_DE_GEVOLGEN', $_POST['ERNST_VAN_DE_GEVOLGEN']);
    $stmt->bindParam(':VOOR_ERNST_VAN_HET_ONGEVAL', $_POST['VOOR_ERNST_VAN_HET_ONGEVAL']);
    $stmt->bindParam(':VOOR_KANS_OP_BLOOTSTELLING', $_POST['VOOR_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':VOOR_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID']);
    $stmt->bindParam(':NA_ERNST_VAN_ONGEVAL', $_POST['NA_ERNST_VAN_ONGEVAL']);
    $stmt->bindParam(':NA_KANS_OP_BLOOTSTELLING', $_POST['NA_KANS_OP_BLOOTSTELLING']);
    $stmt->bindParam(':NA_KANS_OP_WAARSCHIJNLIJKHEID', $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID']);

    try {
        $stmt->execute();
        header('Location: rd_risicoregels.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();

        $result['ASPECTNAAM'] = $_POST['ASPECTNAAM'];
        $result['EFFECTNAAM'] = $_POST['EFFECTNAAM'];
        $result['ARBO_ONDERWERP'] = $_POST['ARBO_ONDERWERP'];
        $result['RISICO_OMSCHRIJVING_OF_BEVINDING'] = $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING'];
        $result['HUIDIGE_BEHEERSMAATREGEL'] = $_POST['HUIDIGE_BEHEERSMAATREGEL'];
        $result['PROCES'] = $_POST['PROCES'];
        $result['MACHINE_ONDERDEEL'] = $_POST['MACHINE_ONDERDEEL'];
        $result['AFDELING'] = $_POST['AFDELING'];
        $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'] = $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
        $result['AFWIJKENDE_ACTIE_TER_UITVOERING'] = $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING'];
        $result['RESTRISICO'] = $_POST['RESTRISICO'];
        $result['VOOR_ERNST_VAN_HET_ONGEVAL'] = $_POST['VOOR_ERNST_VAN_HET_ONGEVAL'];
        $result['VOOR_KANS_OP_BLOOTSTELLING'] = $_POST['VOOR_KANS_OP_BLOOTSTELLING'];
        $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['NA_ERNST_VAN_ONGEVAL'] = $_POST['NA_ERNST_VAN_ONGEVAL'];
        $result['NA_KANS_OP_BLOOTSTELLING'] = $_POST['NA_KANS_OP_BLOOTSTELLING'];
        $result['NA_KANS_OP_WAARSCHIJNLIJKHEID'] = $_POST['NA_KANS_OP_WAARSCHIJNLIJKHEID'];
        $result['MODEL__TYPE'] = $_POST['MODEL__TYPE'];
        $result['SERIENUMMER'] = $_POST['SERIENUMMER'];
        $result['LEVERANCIER'] = $_POST['LEVERANCIER'];
        $result['CE_MARKERING'] = $_POST['CE_MARKERING'];
        $result['CE_DOCUCHECK'] = $_POST['CE_DOCUCHECK'];
        $result['TRANSPORT'] = $_POST['TRANSPORT'];
        $result['MONTAGE'] = $_POST['MONTAGE'];
        $result['IN_BEDRIJFSNAME'] = $_POST['IN_BEDRIJFSNAME'];
        $result['TIJDENS_PRODUCTIE'] = $_POST['TIJDENS_PRODUCTIE'];
        $result['TIJDENS_ONDERHOUD'] = $_POST['TIJDENS_ONDERHOUD'];
        $result['TIJDENS_STORING'] = $_POST['TIJDENS_STORING'];
        $result['TIJDENS_REINIGEN'] = $_POST['TIJDENS_REINIGEN'];
        $result['TIJDENS_AFSTELLEN'] = $_POST['TIJDENS_AFSTELLEN'];
        $result['DEMONTAGE'] = $_POST['DEMONTAGE'];
        $result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'] = $_POST['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'];
        $result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'] = $_POST['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'];
        $result['ERNST_VAN_DE_GEVOLGEN'] = $_POST['ERNST_VAN_DE_GEVOLGEN'];
    }
}

try {
    $query = "SELECT *
              FROM RISICOREGEL RR INNER JOIN VISUELE_BEOORDELING VB
              ON RR.PROJECTNUMMER = VB.PROJECTNUMMER
              AND RR.RAPPORTNUMMER = VB.RAPPORTNUMMER
              AND RR.REGELNUMMER = VB.REGELNUMMER
              INNER JOIN MACHINE_VEILIGHEID MV
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

    $stmt->execute();
    $result = $stmt->fetch();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
}
$rs = $dbh->query('SELECT ASPECTNAAM, EFFECTNAAM FROM ASPECT_EFFECT GROUP BY ASPECTNAAM, EFFECTNAAM ORDER BY ASPECTNAAM');
$effectaspecten = $rs->fetchAll();
global $effecten;
foreach ($effectaspecten as $row) {
  if(!isset($aspecten)){
    $effectrow = 0;
    $number = 0;
    $aspecten[$number] = $row[0];
    $aspectlast = $row[0];
  }
    $effecten[$number][$effectrow]= $row[1];
  if($aspectlast != $row[0]){
    $effectrow = 0;
    $aspecten[$number] = $row[0];
    $aspectlast = $row[0];
    $number ++;
  }
  else{
    $effectrow ++;
  }

}
?>

<div class="container">
    <div class="page-header">
        <h1>Organisatieregel toevoegen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form action="c_machineveiligheid_risicoregel.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>" method="post" id="crisicoregel">
        <h3>Risico inventarisatie</h3>
        <div class="form-group">
            <label for="ARBO_ONDERWERP">Arbo onderwerp</label>
            <input type="text" class="form-control" name="ARBO_ONDERWERP" value="<?php if(isset($result['ARBO_ONDERWERP'])) { echo $result['ARBO_ONDERWERP']; } ?>">
        </div>
        <div class="form-group">
            <label for="ASPECT">Aspect</label>
            <select class="form-control" name="ASPECTNAAM" id="selectcat" form="crisicoregel">
              <?php for($i = 0; $i < sizeof($aspecten); $i ++){
                echo "<option id='$i' value='$aspecten[$i]'";if(isset($result['ASPECTNAAM']) && $aspecten[$i] == $result['ASPECTNAAM']){ $id = $i; echo "selected";} echo ">".$aspecten[$i]."</option>";
              } ?>
            </select>
        </div>
        <div class="form-group">
            <label for="EFFECT">Effect</label>
            <select class="form-control" name="EFFECTNAAM" id="selectprod" form="crisicoregel">
              <?php
                for($i = 0; $i < sizeof($effecten); $i++){
                  for($j = 0; $j < sizeof($effecten[$i]); $j++){
                    echo "<option value='".$effecten[$i][$j]."' id='$i' ";if(isset($result['EFFECTNAAM']) && $effecten[$i][$j] == $result['EFFECTNAAM']) {echo "selected";} echo ">".$effecten[$i][$j]."</option>";
                  }
                } ?>
            </select>
        </div>
        <div class="form-group">
            <label for="PROCES">Proces</label>
            <input type="text" class="form-control" name="PROCES" value="<?php if(isset($result['PROCES'])) { echo $result['PROCES']; } ?>">
        </div>
        <div class="form-group">
            <label for="AFDELING">Afdeling</label>
            <input type="text" class="form-control" name="AFDELING" value="<?php if(isset($result['AFDELING'])) { echo $result['AFDELING']; } ?>">
        </div>
        <div class="form-group">
            <label for="MACHINE_ONDERDEEL">Machine(onderdeel)</label>
            <input type="text" class="form-control" name="MACHINE_ONDERDEEL" value="<?php if(isset($result['MACHINE_ONDERDEEL_'])) { echo $result['MACHINE_ONDERDEEL_']; } ?>">
        </div>
        <div class="form-group">
            <label for="RISICO_OMSCHRIJVING_OF_BEVINDING">Risico omschrijving of bevinding</label>
            <textarea class="form-control" rows="2" name="RISICO_OMSCHRIJVING_OF_BEVINDING"><?php if(isset($result['RISICO_OMSCHRIJVING_OF_BEVINDING'])) { echo $result['RISICO_OMSCHRIJVING_OF_BEVINDING']; } ?></textarea>
        </div>
        <div class="form-group">
            <label for="HUIDIGE_BEHEERSMAATREGEL">Huidige beheersmaatregel</label>
            <textarea class="form-control" rows="2" name="HUIDIGE_BEHEERSMAATREGEL"><?php if(isset($result['HUIDIGE_BEHEERSMAATREGEL'])) { echo $result['HUIDIGE_BEHEERSMAATREGEL']; } ?></textarea>
        </div>
        <h3>Machine veiligheid</h3>
        <div class="form-group">
            <label for="MODEL__TYPE">MODEL__TYPE</label>
            <input type="text" class="form-control" name="MODEL__TYPE" value="<?php if(isset($result['MODEL__TYPE'])) { echo $result['MODEL__TYPE']; } ?>">
        </div>
        <div class="form-group">
            <label for="SERIENUMMER">Serienummer</label>
            <input type="text" class="form-control" name="SERIENUMMER" value="<?php if(isset($result['SERIENUMMER'])) { echo $result['SERIENUMMER']; } ?>">
        </div>
        <div class="form-group">
            <label for="LEVERANCIER">Leverancier</label>
            <input type="text" class="form-control" name="LEVERANCIER" value="<?php if(isset($result['LEVERANCIER'])) { echo $result['LEVERANCIER']; } ?>">
        </div>
        <div class="form-group">
            <label for="CE_MARKERING">CE Markering</label>
            <input type="text" class="form-control" name="CE_MARKERING" value="<?php if(isset($result['CE_MARKERING'])) { echo $result['CE_MARKERING']; } ?>">
        </div>
        <div class="form-group">
            <label for="CE_DOCUCHECK">CE Docucheck</label>
            <input type="text" class="form-control" name="CE_DOCUCHECK" value="<?php if(isset($result['CE_DOCUCHECK'])) { echo $result['CE_DOCUCHECK']; } ?>">
        </div>
        <div class="form-group">
            <label for="TRANSPORT">Transport</label>
            <input type="checkbox" class="form-control" name="TRANSPORT" value="<?php if(isset($result['TRANSPORT'])) { echo $result['TRANSPORT']; } ?>">
        </div>
        <div class="form-group">
            <label for="MONTAGE">Montage</label>
            <input type="checkbox" class="form-control" name="MONTAGE" value="<?php if(isset($result['Montage'])) { echo $result['Montage']; } ?>">
        </div>
        <div class="form-group">
            <label for="IN_BEDRIJFSNAME">In bedrijfsname</label>
            <input type="checkbox" class="form-control" name="MONTAGE" value="<?php if(isset($result['IN_BEDRIJFSNAME'])) { echo $result['IN_BEDRIJFSNAME']; } ?>">
        </div>
        <div class="form-group">
            <label for="TIJDENS_PRODUCTIE">Tijdens productie</label>
            <input type="checkbox" class="form-control" name="TIJDENS_PRODUCTIE" value="<?php if(isset($result['TIJDENS_PRODUCTIE'])) { echo $result['TIJDENS_PRODCUTIE']; } ?>">
        </div>
        <div class="form-group">
            <label for="TIJDENS_ONDERHOUD">Tijdens onderhoud</label>
            <input type="checkbox" class="form-control" name="TIJDENS_ONDERHOUD" value="<?php if(isset($result['TIJDENS_ONDERHOUD'])) { echo $result['TIJDENS_ONDERHOUD']; } ?>">
        </div>
        <div class="form-group">
            <label for="TIJDENS_STORING">Tijdens storing</label>
            <input type="checkbox" class="form-control" name="TIJDENS_STORING" value="<?php if(isset($result['TIJDENS_STORING'])) { echo $result['TIJDENS_STORING']; } ?>">
        </div>
        <div class="form-group">
            <label for="TIJDENS_REINIGEN">Tijdens reinigen</label>
            <input type="checkbox" class="form-control" name="TIJDENS_REINIGEN" value="<?php if(isset($result['TIJDENS_REINIGEN'])) { echo $result['TIJDENS_REINIGEN']; } ?>">
        </div>
        <div class="form-group">
            <label for="TIJDENS_AFSTELLEN">Tijdens afstellen</label>
            <input type="checkbox" class="form-control" name="TIJDENS_AFSTELLEN" value="<?php if(isset($result['TIJDENS_AFSTELLEN'])) { echo $result['TIJDENS_AFSTELLEN']; } ?>">
        </div>
        <div class="form-group">
            <label for="DEMONTAGE">Demontage</label>
            <input type="checkbox" class="form-control" name="DEMONTAGE" value="<?php if(isset($result['DEMONTAGE'])) { echo $result['DEMONTAGE']; } ?>">
        </div>
        <div class="form-group">
            <label for="FREQUENTIE">Frequentie</label>
            <input type="text" class="form-control" name="FREQUENTIE" value="<?php if(isset($result['FREQUENTIE'])) { echo $result['FREQUENTIE']; } ?>">
        </div>
        <div class="form-group">
            <label for="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS">MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS</label>
            <input type="text" class="form-control" name="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS" value="<?php if(isset($result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'])) { echo $result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS']; } ?>">
        </div>
        <div class="form-group">
            <label for="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE">MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE</label>
            <input type="text" class="form-control" name="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE" value="<?php if(isset($result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'])) { echo $result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE']; } ?>">
        </div>
        <div class="form-group">
            <label for="ERNST_VAN_DE_GEVOLGEN">Ernst van de gevolgen</label>
            <input type="text" class="form-control" name="ERNST_VAN_DE_GEVOLGEN" value="<?php if(isset($result['ERNST_VAN_DE_GEVOLGEN'])) { echo $result['ERNST_VAN_DE_GEVOLGEN']; } ?>">
        </div>
        <h3>Risico voor maatregelen</h3>
        <div class="form-group">
            <label for="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL">Voorgestelde actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL"><?php if(isset($result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'])) { echo $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL']; } ?></textarea>
        </div>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="VOOR_ERNST_VAN_HET_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="VOOR_ERNST_VAN_HET_ONGEVAL" value="<?php if(isset($result['VOOR_ERNST_VAN_HET_ONGEVAL'])) { echo $result['VOOR_ERNST_VAN_HET_ONGEVAL']; } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_BLOOTSTELLING" value="<?php if(isset($result['VOOR_KANS_OP_BLOOTSTELLING'])) { echo $result['VOOR_KANS_OP_BLOOTSTELLING']; } ?>">
            <small id="VOOR_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0.5</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_WAARSCHIJNLIJKHEID" value="<?php if(isset($result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'])) { echo $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID']; } ?>">
            <small id="VOOR_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2</small>
        </div>
        <h3>Risico na maatregelen</h3>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="NA_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="NA_ERNST_VAN_ONGEVAL" value="<?php if(isset($result['NA_ERNST_VAN_ONGEVAL'])) { echo $result['NA_ERNST_VAN_ONGEVAL']; } ?>">
            <small id="NA_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="NA_KANS_OP_BLOOTSTELLING" value="<?php if(isset($result['NA_KANS_OP_BLOOTSTELLING'])) { echo $result['NA_KANS_OP_BLOOTSTELLING']; } ?>">
            <small id="NA_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="NA_KANS_OP_WAARSCHIJNLIJKHEID" value="<?php if(isset($result['NA_KANS_OP_WAARSCHIJNLIJKHEID'])) { echo $result['NA_KANS_OP_WAARSCHIJNLIJKHEID']; } ?>">
            <small id="NA_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2</small>
        </div>
        <div class="form-group">
            <label for="AFWIJKENDE_ACTIE_TER_UITVOERING">Afwijkende actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="AFWIJKENDE_ACTIE_TER_UITVOERING"><?php if(isset($result['AFWIJKENDE_ACTIE_TER_UITVOERING'])) { echo $result['AFWIJKENDE_ACTIE_TER_UITVOERING']; } ?></textarea>
        </div>
        <div class="form-group">
            <label for="RESTRISICO">Rest risico</label>
            <textarea class="form-control" rows="2" name="RESTRISICO"><?php if(isset($result['RESTRISICO'])) { echo $result['RESTRISICO']; } ?></textarea>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit"><?php if(isset($_GET['regelnummer'])) { echo 'Regel updaten'; } else { echo 'Regel opslaan'; } ?></button>
    </form>
    <br>
</div>

<?php include_once('include/footer.php'); ?>
