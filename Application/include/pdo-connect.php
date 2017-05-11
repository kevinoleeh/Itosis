<?php
session_start();

try {
<<<<<<< HEAD
    $hostname = "(local)\SQLEXPRESS";
    $dbname = "Euratex";
    $username = "sa";
    $password = "P@ssw0rd";
    $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", "$username", "$password");
    $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
=======
    $hostname = '(local)\MSSQLSERVER01';
    $dbname = 'Euratex';
    $username = 'Random';
    $password = 'Kappa';
    $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", $username, $password);
>>>>>>> 4d85bce7a62b73663045b39995fea0c2bab91811
} catch (PDOException $e) {
    echo $e->getMessage();
    echo "Er kon geen verbinding met de database gemaakt worden.";
    exit;
}
?>
