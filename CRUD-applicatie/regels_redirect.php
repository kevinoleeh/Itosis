<?php

include_once('include/header.php');

$type = null;

$query = "SELECT RAPPORT_TYPE
          FROM RAPPORT
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);

try {
    $stmt->execute();
    $type = $stmt->fetch();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

switch ($type['RAPPORT_TYPE']) {
    case 'Organisatie':
        if(isset($_GET['regelnummer'])) {
            header('Location: u_organisatie_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer'].'&regelnummer='.$_GET['regelnummer']);
        } else {
            header('Location: c_organisatie_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
        }

        break;
    case 'Visuele beoordeling':
        if(isset($_GET['regelnummer'])) {
            header('Location: u_visuele_beoordeling_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer'].'&regelnummer='.$_GET['regelnummer']);
        } else {
            header('Location: c_visuele_beoordeling_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
        }

        break;
    case 'Machineveiligheid':
        if(isset($_GET['regelnummer'])) {
            header('Location: u_machineveiligheid_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer'].'&regelnummer='.$_GET['regelnummer']);
        } else {
            header('Location: c_machineveiligheid_risicoregel.php?projectnummer='.$_GET['projectnummer'].'&rapportnummer='.$_GET['rapportnummer']);
        }

        break;
    default:
        header('Location: rd_risicoregels.php');

        break;
}

include_once('include/footer.php');

?>
