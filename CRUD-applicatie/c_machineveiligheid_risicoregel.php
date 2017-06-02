<?php include_once('include/header.php') ?>

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
             :MACHINE_ONDERDEEL,
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
             :VOOR_ERNST_VAN_HET_ONGEVAL,
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
    $stmt->bindParam(':MACHINE_ONDERDEEL', $_POST['MACHINE_ONDERDEEL']);
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

        $result['PID'] = $_POST['PID'];
        $result['LIJN'] = $_POST['LIJN'];
        $result['ASPECTNAAM'] = $_POST['ASPECTNAAM'];
        $result['EFFECTNAAM'] = $_POST['EFFECTNAAM'];
        $result['ARBO_ONDERWERP'] = $_POST['ARBO_ONDERWERP'];
        $result['RISICO_OMSCHRIJVING_OF_BEVINDING'] = $_POST['RISICO_OMSCHRIJVING_OF_BEVINDING'];
        $result['HUIDIGE_BEHEERSMAATREGEL'] = $_POST['HUIDIGE_BEHEERSMAATREGEL'];
        $result['PROCES'] = $_POST['PROCES'];
        $result['MACHINE_ONDERDEEL'] = $_POST['MACHINE_ONDERDEEL'];
        $result['AFDELING'] = $_POST['AFDELING'];
        $result['MACHINE'] = $_POST['MACHINE'];
        $result['MACHINE_CODE'] = $_POST['MACHINE_CODE'];
        $result['MODEL_TYPE'] = $_POST['MODEL_TYPE'];
        $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'] = $_POST['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
        $result['AFWIJKENDE_ACTIE_TER_UITVOERING'] = $_POST['AFWIJKENDE_ACTIE_TER_UITVOERING'];
        $result['RESTRISICO'] = $_POST['RESTRISICO'];
        $result['VOOR_ERNST_VAN_HET_ONGEVAL'] = $_POST['VOOR_ERNST_VAN_HET_ONGEVAL'];
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
            <label for="MACHINE_ONDERDEEL_">Machine(onderdeel)</label>
            <input type="text" class="form-control" name="MACHINE_ONDERDEEL_" value="<?php if(isset($result['MACHINE_ONDERDEEL_'])) { echo $result['MACHINE_ONDERDEEL_']; } ?>">
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
            <label for="PID">PID</label>
            <input type="text" class="form-control" name="PID" value="<?php if(isset($result['PID'])) { echo $result['PID']; } ?>">
        </div>
        <div class="form-group">
            <label for="LIJN">Lijn</label>
            <input type="text" class="form-control" name="LIJN" value="<?php if(isset($result['LIJN'])) { echo $result['LIJN']; } ?>">
        </div>
        <div class="form-group">
            <label for="MACHINE_CODE">Machine code</label>
            <input type="text" class="form-control" name="MACHINE_CODE" value="<?php if(isset($result['MACHINE_CODE'])) { echo $result['MACHINE_CODE']; } ?>">
        </div>
        <div class="form-group">
            <label for="MACHINE">Machine</label>
            <input type="text" class="form-control" name="MACHINE" value="<?php if(isset($result['MACHINE'])) { echo $result['MACHINE']; } ?>">
        </div>
        <div class="form-group">
            <label for="MODEL_TYPE">Model type</label>
            <input type="text" class="form-control" name="MODEL_TYPE" value="<?php if(isset($result['MODEL_TYPE'])) { echo $result['MODEL_TYPE']; } ?>">
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
            <label for="AANVULLENDE_OMSCHRIJVING">Aanvullende omschrijving</label>
            <input type="text" class="form-control" name="AANVULLENDE_OMSCHRIJVING" value="<?php if(isset($result['AANVULLENDE_OMSCHRIJVING'])) { echo $result['AANVULLENDE_OMSCHRIJVING']; } ?>">
        </div>
        <div class="form-group">
            <label for="TAKEN">Taken</label>
            <input type="text" class="form-control" name="TAKEN" value="<?php if(isset($result['TAKEN'])) { echo $result['TAKEN']; } ?>">
        </div>
        <div class="form-group">
            <label for="TRANSPORT">Transport</label>
            <input type="checkbox" class="form-control" rel="TRANSPORT" <?php if(isset($result['TRANSPORT'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="MONTAGE">Montage</label>
            <input type="checkbox" class="form-control" rel="MONTAGE" <?php if(isset($result['Montage'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="IN_BEDRIJFSNAME">In bedrijfsname</label>
            <input type="checkbox" class="form-control" rel="IN_BEDRIJFSNAME" <?php if(isset($result['IN_BEDRIJFSNAME'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="TIJDENS_PRODUCTIE">Tijdens productie</label>
            <input type="checkbox" class="form-control" rel="TIJDENS_PRODUCTIE" <?php if(isset($result['TIJDENS_PRODUCTIE'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="TIJDENS_ONDERHOUD">Tijdens onderhoud</label>
            <input type="checkbox" class="form-control" rel="TIJDENS_ONDERHOUD" <?php if(isset($result['TIJDENS_ONDERHOUD'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="TIJDENS_STORING">Tijdens storing</label>
            <input type="checkbox" class="form-control" rel="TIJDENS_STORING" <?php if(isset($result['TIJDENS_STORING'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="TIJDENS_REINIGEN">Tijdens reinigen</label>
            <input type="checkbox" class="form-control" rel="TIJDENS_REINIGEN" <?php if(isset($result['TIJDENS_REINIGEN'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="TIJDENS_AFSTELLEN">Tijdens afstellen</label>
            <input type="checkbox" class="form-control" rel="TIJDENS_AFSTELLEN" <?php if(isset($result['TIJDENS_AFSTELLEN'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="DEMONTAGE">Demontage</label>
            <input type="checkbox" class="form-control" rel="DEMONTAGE" <?php if(isset($result['DEMONTAGE'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="ONTWERP">Ontwerp</label>
            <input type="checkbox" class="form-control" rel="ONTWERP" <?php if(isset($result['ONTWERP'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="AFSCHERMING">Afscherming</label>
            <input type="checkbox" class="form-control" rel="AFSCHERMING" <?php if(isset($result['AFSCHERMING'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="INSTRUCTIE">Instructie</label>
            <input type="checkbox" class="form-control" rel="INSTRUCTIE" <?php if(isset($result['INSTRUCTIE'])) { echo 'checked'; } ?>>
        </div>
        <div class="form-group">
            <label for="FREQUENTIE">Frequentie</label>
            <input type="text" class="form-control" name="FREQUENTIE" value="<?php if(isset($result['FREQUENTIE'])) { echo $result['FREQUENTIE']; } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4, 5</small>
        </div>
        <div class="form-group">
            <label for="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS">Mogelijkheid optreden gevaarlijke gebeurtenis</label>
            <input type="text" class="form-control" name="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS" value="<?php if(isset($result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'])) { echo $result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS']; } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4, 5</small>
        </div>
        <div class="form-group">
            <label for="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE">Mogelijkheid voorkomen of beperken schade</label>
            <input type="text" class="form-control" name="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE" value="<?php if(isset($result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'])) { echo $result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE']; } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 3, 5</small>
        </div>
        <div class="form-group">
            <label for="ERNST_VAN_DE_GEVOLGEN">Ernst van de gevolgen</label>
            <input type="text" class="form-control" name="ERNST_VAN_DE_GEVOLGEN" value="<?php if(isset($result['ERNST_VAN_DE_GEVOLGEN'])) { echo $result['ERNST_VAN_DE_GEVOLGEN']; } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4</small>
        </div>
        <div class="form-group">
            <label for="CI">CI</label>
            <input type="text" class="form-control" name="CI" value="<?php if(isset($result['CI'])) { echo $result['CI']; } ?>" disabled>
        </div>
        <h3>Risico voor maatregelen</h3>
        <div class="form-group">
            <label for="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL">Voorgestelde actie ter uitvoering</label>
            <textarea class="form-control" rows="2" name="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL"><?php if(isset($result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'])) { echo $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL']; } ?></textarea>
        </div>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="VOOR_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="VOOR_ERNST_VAN_ONGEVAL" value="<?php if(isset($result['VOOR_ERNST_VAN_ONGEVAL'])) { echo $result['VOOR_ERNST_VAN_ONGEVAL']; } ?>">
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
