<?php
session_start();

try {
    $hostname = '(local)\MSSQLSERVER01';
    $dbname = 'Euratex';
    $username = 'Random';
    $password = 'Kappa';
    $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", $username, $password);
} catch (PDOException $e) {
    echo $e->getMessage();
    echo "Er kon geen verbinding met de database gemaakt worden.";
    exit;
}
?>
