<?php
include("include/header.php");


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_GET["new"])) {
        $query = 'EXEC dbo.insertBedrijf
              :BEDRIJFSNAAM,
              :LOCATIE';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':BEDRIJFSNAAM', $_POST['BEDRIJFSNAAM']);
        $stmt->bindParam(':LOCATIE', $_POST['LOCATIE']);

        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Regel opgeslagen.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
        }
    }
}
if (isset($_GET["remove"])){
  $query = 'EXEC dbo.deleteBedrijf
            :BEDRIJFSNAAM,
            :LOCATIE';
  $stmt = $dbh->prepare($query);
  $stmt->bindParam(':BEDRIJFSNAAM', $_GET['remove']);
  $stmt->bindParam(':LOCATIE', $_GET['LOCATIE']);
  try {
      $stmt->execute();

      $meldingStatus = true;
      $melding = "Bedrijf verwijderd.";
  }   catch (PDOException $e) {
      $meldingStatus = false;
      $melding = "Bedrijf niet verwijderd. Foutmelding: " . $e->getMessage();
  }
}
if (isset($_GET["removeProject"])){
  $query = 'EXEC dbo.deleteProject
            :PROJECTNUMMER';
  $stmt = $dbh->prepare($query);
  $stmt->bindParam(':PROJECTNUMMER', $_GET['removeProject']);
  try {
      $stmt->execute();

      $meldingStatus = true;
      $melding = "Project verwijderd.";
  }   catch (PDOException $e) {
      $meldingStatus = false;
      $melding = "Project niet verwijderd. Foutmelding: " . $e->getMessage();
  }
}
?>
    <div class="container">
        <div class="page-header">
            <h1>Bedrijven en projecten beheren.</h1>
        </div>
        <?php include_once('include/melding.php') ?>
        <div class="col-md-5">
            <input type="search" style="" value="vul een bedrijfsnaam in.">
            <a class="no-link" href="?new=1">
                <button class="btn btn-justified btn-right">Toevoegen</button>
            </a>
            <div class="row">
            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr>
                            <th>Bedrijf</th>
                            <th>Locatie</th>
                        </tr>
                    </thead>
                    <?php
                if(isset($_GET["new"])){
                  echo '<form action="bedrijfproject.php?new=1" method="post">';
                  echo '<tr>';
                  echo '<td><input type="text" name="BEDRIJFSNAAM"></td>';
                  echo '<td><input type="text" name="LOCATIE"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                  echo '</tr>';
                  echo '</form>';
                }
                  $rs = $dbh->query("SELECT * FROM BEDRIJF");
                  $bedrijven = $rs->fetchAll();
                  foreach ($bedrijven as $bedrijf){
                    echo '<tr>';
                    echo '<td><a class="no-link" href="?project='.$bedrijf["BEDRIJFSNAAM"].'">'.$bedrijf["BEDRIJFSNAAM"].'</a></td>';
                    echo '<td>'.$bedrijf["LOCATIE"].'
                    <a href="?remove='.$bedrijf["BEDRIJFSNAAM"].'&LOCATIE='.$bedrijf["LOCATIE"].'"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                    <a href="?edit='.$bedrijf["BEDRIJFSNAAM"].'&LOCATIE='.$bedrijf["LOCATIE"].'"><span class="glyphicon glyphicon-pencil widintable"></span></a>';
                  }
                    ?>
                </table>
            </div>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-5">
          <?php if(isset($_GET['project'])){
            echo '<a class="no-link" href="?newProject=1project="'.$_GET['project'].'">
                  <button class="btn btn-justified btn-right">Toevoegen</button>
                  </a>';
          }
          ?>
            <div class="row">
            </div>
        <?php  if(isset($_GET['project'])) { ?>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr>
                            <th>Project</th>
                            <th>Omschrijving</th>
                        </tr>
                    </thead>
                    <?php
                    if(isset($_GET["newProject"])){
                      echo '<form action="bedrijfproject.php?newProject=1&project='.$_GET['project'].'" method="post">';
                      echo '<tr>';
                      echo '<td></td>';
                      echo '<td><input type="text" name="PROJECTOMSCHRIJVING"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                      echo '</tr>';
                      echo '</form>';
                    }
                    $stmt = $dbh->prepare("SELECT * FROM PROJECT WHERE BEDRIJFSNAAM = :BEDRIJFSNAAM");
                    $stmt->execute(array(':BEDRIJFSNAAM'=>$_GET['project']));
                    $projecten = $stmt->fetchAll();
                    foreach ($projecten as $project) {
                      echo '<tr>';
                      echo '<td>'.$project["PROJECTNUMMER"].'</td>';
                      echo '<td>'.$project["PROJECTOMSCHRIJVING"].'
                      <a href="?removeProject='.$project["PROJECTNUMMER"].'&project='.$_GET['project'].'"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                      <a href="?editProject='.$project["PROJECTNUMMER"].'&project='.$_GET['project'].'"><span class="glyphicon glyphicon-pencil widintable"></span></a></td>';
                    }
                  }
                    ?>
                    <tfoot>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <form method="GET" id="bedrijfForm" action="Zoeken">
        <input type="hidden" id="inputBedrijf" name="bedrijf" />
    </form>


    <?php include_once('include/footer.php'); ?>
