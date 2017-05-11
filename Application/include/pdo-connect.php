<?php
session_start();

try {
    $hostname = "(local)\SQLEXPRESS";
    $dbname = "Euratex";
    $username = "sa";
    $password = "fiets123";
    $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", "$username", "$password");
} catch (PDOException $e) {
    echo "Er kon geen verbinding met de database gemaakt worden.";
    exit;
}
?>
