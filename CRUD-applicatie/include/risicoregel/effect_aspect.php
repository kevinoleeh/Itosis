<?php

$query = "SELECT ASPECTNAAM, EFFECTNAAM 
          FROM ASPECT_EFFECT
          GROUP BY ASPECTNAAM, EFFECTNAAM 
          ORDER BY ASPECTNAAM";
$stmt = $dbh->prepare($query);
$result = null;

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}

global $effecten;

if(count($result) > 0) {
    foreach ($result as $row) {
        if (!isset($aspecten)) {
            $effectrow = 0;
            $number = 0;
            $aspecten[$number] = $row[0];
            $aspectlast = $row[0];
        }
        $effecten[$number][$effectrow] = $row[1];
        if ($aspectlast != $row[0]) {
            $effectrow = 0;
            $number++;
            $aspecten[$number] = $row[0];
            $aspectlast = $row[0];
        } else {
            $effectrow++;
        }
    }
}

?>
