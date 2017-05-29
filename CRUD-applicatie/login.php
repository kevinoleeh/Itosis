<?php include_once('include/header.php') ?>

<?php

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        $hostname = "euratexserver.nl";
        $dbname = "Euratex";
        $username = "sa";
        $password = "Euratex1234";
        $dbh = new PDO("sqlsrv:Server=$hostname;Database=$dbname", "$username", "$password");
        $dbh->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    } catch (PDOException $e) {
        echo $e->getMessage();
        echo "Er kon geen verbinding met de database gemaakt worden.";
        exit;
    }

    $query = 'SELECT PWDCOMPARE(:WACHTWOORD, password_hash) 
              FROM sys.sql_logins 
              WHERE name = :GEBRUIKERSNAAM';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':GEBRUIKERSNAAM', $_POST['gebruikersnaam']);
    $stmt->bindParam(':WACHTWOORD', $_POST['wachtwoord']);
    $stmt->execute();
    $result = $stmt->fetch();

    if($result[0] == 1) {
        $_SESSION['gebruikersnaam'] = $_POST['gebruikersnaam'];
        $_SESSION['wachtwoord'] = $_POST['wachtwoord'];

        header('Location: '. 'index.php');
    } else {
        session_destroy();

        $meldingStatus = false;
        $melding = "Gebruikersnaam en/of wachtwoord incorrect.";
    }
}

?>

<div class="container">
    <div class="row">
        <div class="col-lg-offset-3 col-lg-6">
            <?php include_once('include/melding.php') ?>
            <form class="form-group" method="post">
                <h2>Login</h2>
                <label for="gebruikersnaam">Gebruikersnaam</label>
                <input type="text" id="gebruikersnaam" name="gebruikersnaam" class="form-control" placeholder="Gebruikersnaam" required="">
                <br>
                <label for="wachtwoord">Wachtwoord</label>
                <input type="password" id="wachtwoord" name="wachtwoord" class="form-control" placeholder="Wachtwoord" required="">
                <br>
                <button class="btn btn-primary btn-block" type="submit">Inloggen</button>
            </form>
        </div>
    </div>
</div>
<?php include_once('include/footer.php'); ?>