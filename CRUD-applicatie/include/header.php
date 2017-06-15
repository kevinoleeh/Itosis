<?php

include_once('include/functions.php');

session_start();

if(strstr($_SERVER["PHP_SELF"], 'login.php') != 'login.php') {
    if(isset($_SESSION['gebruikersnaam']) and isset($_SESSION['wachtwoord'])) {
        include_once('pdo-connect.php');
    } else {
        header('Location: login.php');
    }
}

?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Euratex</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
</head>

<body>

<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Wissel de navigatie</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.php">Euratex</a>
        </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <?php if(isset($_SESSION['gebruikersnaam']) and isset($_SESSION['wachtwoord'])) { ?>
                <li><a href="r_projecten.php">Alle projecten</a></li>
                <li><a href="crud_bedrijf_project.php">Bedrijf en project</a></li>
                <li><a href="crud_aspect_effect.php">Aspect en effect</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a><?= $_SESSION['gebruikersnaam'] ?></a></li>
                <li><a href="logout.php">Uitloggen</a></li>
            </ul>
            <?php } ?>
        </div>
    </div>
</nav>
