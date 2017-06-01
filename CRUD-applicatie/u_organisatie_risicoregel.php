<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_ORGANISATIE_RISICOREGEL
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

    try {
        $stmt->execute();
        header('Location: rd_risicoregels.php?projectnummer=' . $_GET['projectnummer'] . '&rapportnummer=' . $_GET['rapportnummer']);
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet geüpdatet. Foutmelding: " . $e->getMessage();

        $result['ASPECTNAAM'] = $_POST['ASPECTNAAM'];
        $result['EFFECTNAAM'] = $_POST['EFFECTNAAM'];
        $result['ARBO_ONDERWERP'] = $_POST['ARBO_ONDERWERP'];
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
    }
}

try {
    $query = "SELECT *
              FROM RISICOREGEL
              WHERE PROJECTNUMMER = :PROJECTNUMMER
              AND RAPPORTNUMMER = :RAPPORTNUMMER
              AND REGELNUMMER = :REGELNUMMER";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);

    $stmt->execute();
    $result = $stmt->fetch();
    $rs = $dbh->query('SELECT ASPECTNAAM, EFFECTNAAM FROM ASPECT_EFFECT GROUP BY ASPECTNAAM, EFFECTNAAM ORDER BY ASPECTNAAM');
    $effectaspecten = $rs->fetchAll();
    global $effecten;
    foreach ($effectaspecten as $row) {
        if (!isset($aspecten)) {
            $effectrow = 0;
            $number = 0;
            $aspecten[$number] = $row[0];
            $aspectlast = $row[0];
        }
        $effecten[$number][$effectrow] = $row[1];
        if ($aspectlast != $row[0]) {
            $effectrow = 0;
            $aspecten[$number] = $row[0];
            $aspectlast = $row[0];
            $number++;
        } else {
            $effectrow++;
        }
    }
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
}

function getPrioriteitStyle($prioriteit)
{
    switch ($prioriteit) {
        case 'P 1':
            return 'background-color: #ff0000; color: #fff;';
            break;
        case 'P 2':
            return 'background-color: #ff5500; color: #fff;';
            break;
        case 'P 3':
            return 'background-color: #ffa000; color: #fff;';
            break;
        case 'P 4':
            return 'background-color: #ffc800; color: #000;';
            break;
        case 'P 5':
            return 'background-color: #00a000; color: #000;';
            break;
    }

    return '';
}

?>

<div class="container">
    <div class="page-header">
        <h1>Organisatieregel wijzigingen</h1>
    </div>

    <?php include_once('include/melding.php') ?>

    <form action="u_organisatie_risicoregel.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['regelnummer'] ?>"
          method="post" id="urisicoregel">
        <h3>Risico inventarisatie</h3>
        <div class="form-group">
            <label for="ARBO_ONDERWERP">Arbo onderwerp</label>
            <input type="text" class="form-control" name="ARBO_ONDERWERP"
                   value="<?php if (isset($result['ARBO_ONDERWERP'])) {
                       echo $result['ARBO_ONDERWERP'];
                   } ?>">
        </div>
        <div class="form-group">
            <label for="ASPECT">Aspect</label>
            <select class="form-control" name="ASPECTNAAM" id="selectcat" form="urisicoregel">
                <?php for ($i = 0; $i < sizeof($aspecten); $i++) {
                    echo "<option id='$i' value='$aspecten[$i]'";
                    if (isset($result['ASPECTNAAM']) && $aspecten[$i] == $result['ASPECTNAAM']) {
                        $id = $i;
                        echo "selected";
                    }
                    echo ">" . $aspecten[$i] . "</option>";
                } ?>
            </select>
        </div>
        <div class="form-group">
            <label for="EFFECT">Effect</label>
            <select class="form-control" name="EFFECTNAAM" id="selectprod" form="urisicoregel">
                <?php
                for ($i = 0; $i < sizeof($effecten); $i++) {
                    for ($j = 0; $j < sizeof($effecten[$i]); $j++) {
                        echo "<option value='" . $effecten[$i][$j] . "' id='$i' ";
                        if (isset($result['EFFECTNAAM']) && $effecten[$i][$j] == $result['EFFECTNAAM']) {
                            echo "selected";
                        }
                        echo ">" . $effecten[$i][$j] . "</option>";
                    }
                } ?>
            </select>
        </div>
        <div class="form-group">
            <label for="RISICO_OMSCHRIJVING_OF_BEVINDING">Risico omschrijving of bevinding</label>
            <textarea class="form-control" rows="2"
                      name="RISICO_OMSCHRIJVING_OF_BEVINDING"><?php if (isset($result['RISICO_OMSCHRIJVING_OF_BEVINDING'])) {
                    echo $result['RISICO_OMSCHRIJVING_OF_BEVINDING'];
                } ?></textarea>
        </div>
        <div class="form-group">
            <label for="HUIDIGE_BEHEERSMAATREGEL">Huidige beheersmaatregel</label>
            <textarea class="form-control" rows="2"
                      name="HUIDIGE_BEHEERSMAATREGEL"><?php if (isset($result['HUIDIGE_BEHEERSMAATREGEL'])) {
                    echo $result['HUIDIGE_BEHEERSMAATREGEL'];
                } ?></textarea>
        </div>
        <h3>Risico voor maatregelen</h3>
        <div class="form-group">
            <label for="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL">Voorgestelde actie ter uitvoering</label>
            <textarea class="form-control" rows="2"
                      name="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL"><?php if (isset($result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'])) {
                    echo $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
                } ?></textarea>
        </div>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="VOOR_ERNST_VAN_HET_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="VOOR_ERNST_VAN_HET_ONGEVAL"
                   value="<?php if (isset($result['VOOR_ERNST_VAN_HET_ONGEVAL'])) {
                       echo $result['VOOR_ERNST_VAN_HET_ONGEVAL'];
                   } ?>">
            <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_BLOOTSTELLING"
                   value="<?php if (isset($result['VOOR_KANS_OP_BLOOTSTELLING'])) {
                       echo $result['VOOR_KANS_OP_BLOOTSTELLING'];
                   } ?>">
            <small id="VOOR_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0.5</small>
        </div>
        <div class="form-group">
            <label for="VOOR_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="VOOR_KANS_OP_WAARSCHIJNLIJKHEID"
                   value="<?php if (isset($result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'])) {
                       echo $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'];
                   } ?>">
            <small id="VOOR_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2
            </small>
        </div>
        <div class="form-group">
            <label>Risico</label>
            <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) {
                echo getPrioriteitStyle($result['VOOR_PRIORITEIT']);
            } ?>" value="<?php if (isset($result['VOOR_RISICO'])) {
                echo $result['VOOR_RISICO'];
            } ?>" disabled>
        </div>
        <div class="form-group">
            <label>Prioriteit</label>
            <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) {
                echo getPrioriteitStyle($result['VOOR_PRIORITEIT']);
            } ?>" value="<?php if (isset($result['VOOR_PRIORITEIT'])) {
                echo $result['VOOR_PRIORITEIT'];
            } ?>" disabled>
        </div>
        <h3>Risico na maatregelen</h3>
        <h4>Fine en Kinney</h4>
        <div class="form-group">
            <label for="NA_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
            <input type="text" class="form-control" name="NA_ERNST_VAN_ONGEVAL"
                   value="<?php if (isset($result['NA_ERNST_VAN_ONGEVAL'])) {
                       echo $result['NA_ERNST_VAN_ONGEVAL'];
                   } ?>">
            <small id="NA_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
            <input type="text" class="form-control" name="NA_KANS_OP_BLOOTSTELLING"
                   value="<?php if (isset($result['NA_KANS_OP_BLOOTSTELLING'])) {
                       echo $result['NA_KANS_OP_BLOOTSTELLING'];
                   } ?>">
            <small id="NA_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
        </div>
        <div class="form-group">
            <label for="NA_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
            <input type="text" class="form-control" name="NA_KANS_OP_WAARSCHIJNLIJKHEID"
                   value="<?php if (isset($result['NA_KANS_OP_WAARSCHIJNLIJKHEID'])) {
                       echo $result['NA_KANS_OP_WAARSCHIJNLIJKHEID'];
                   } ?>">
            <small id="NA_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2
            </small>
        </div>
        <div class="form-group">
            <label>Risico</label>
            <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) {
                echo getPrioriteitStyle($result['NA_PRIORITEIT']);
            } ?>" value="<?php if (isset($result['NA_RISICO'])) {
                echo $result['NA_RISICO'];
            } ?>" disabled>
        </div>
        <div class="form-group">
            <label>Prioriteit</label>
            <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) {
                echo getPrioriteitStyle($result['NA_PRIORITEIT']);
            } ?>" value="<?php if (isset($result['NA_PRIORITEIT'])) {
                echo $result['NA_PRIORITEIT'];
            } ?>" disabled>
        </div>
        <div class="form-group">
            <label for="AFWIJKENDE_ACTIE_TER_UITVOERING">Afwijkende actie ter uitvoering</label>
            <textarea class="form-control" rows="2"
                      name="AFWIJKENDE_ACTIE_TER_UITVOERING"><?php if (isset($result['AFWIJKENDE_ACTIE_TER_UITVOERING'])) {
                    echo $result['AFWIJKENDE_ACTIE_TER_UITVOERING'];
                } ?></textarea>
        </div>
        <div class="form-group">
            <label for="RESTRISICO">Rest risico</label>
            <textarea class="form-control" rows="2" name="RESTRISICO"><?php if (isset($result['RESTRISICO'])) {
                    echo $result['RESTRISICO'];
                } ?></textarea>
        </div>

        <button class="btn btn-block btn-primary" name="submit" type="submit"><?php if (isset($_GET['regelnummer'])) {
                echo 'Regel updaten';
            } else {
                echo 'Regel opslaan';
            } ?></button>
    </form>
    <br>
</div>
<?php include_once('include/footer.php'); ?>
