<?php
include("include/header.php");


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_GET["new"])) {
        $query = 'EXEC dbo.SP_INSERT_BEDRIJF
              :BEDRIJFSNAAM,
              :LOCATIE';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':BEDRIJFSNAAM', $_POST['BEDRIJFSNAAM']);
        $stmt->bindParam(':LOCATIE', $_POST['LOCATIE']);

        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Bedrijf opgeslagen.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Bedrijf niet opgeslagen. Foutmelding: " . $e->getMessage();
        }
    }
    if (isset($_GET["project"])) {
        $query = 'EXEC dbo.SP_INSERT_PROJECT
              :BEDRIJFSNAAM,
              :LOCATIE,
              :PROJECTOMSCHRIJVING';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':BEDRIJFSNAAM', $_GET['project']);
        $stmt->bindParam(':LOCATIE', $_GET['locatie']);
        $stmt->bindParam(':PROJECTOMSCHRIJVING', $_POST['PROJECTOMSCHRIJVING']);

        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Project opgeslagen.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Project niet opgeslagen. Foutmelding: " . $e->getMessage();
        }
    }
}

if (isset($_POST["editBEDRIJFSNAAM"]) && isset($_POST["editLOCATIE"])) {
    $query = 'EXEC dbo.SP_UPDATE_BEDRIJF
              :Bedrijfsnaam,
              :Locatie,
              :uBedrijfsnaam,
              :uLocatie';
    $stmt = $dbh->prepare($query);

    $stmt->bindParam(':Bedrijfsnaam', $_POST['oudBEDRIJFSNAAM']);
    $stmt->bindParam(':Locatie', $_POST['oudLOCATIE']);
    $stmt->bindParam(':uBedrijfsnaam', $_POST['editBEDRIJFSNAAM']);
    $stmt->bindParam(':uLocatie', $_POST['editLOCATIE']);

    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Bedrijf en/of locatie geüpdatet.";

    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Bedrijf niet geupdatet. Foutmelding: " . $e->getMessage();
    }
}

if (isset($_GET["remove"])) {
    $query = 'EXEC dbo.SP_DELETE_BEDRIJF
            :BEDRIJFSNAAM,
            :LOCATIE';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':BEDRIJFSNAAM', $_GET['remove']);
    $stmt->bindParam(':LOCATIE', $_GET['LOCATIE']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Bedrijf verwijderd.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Bedrijf niet verwijderd. Foutmelding: " . $e->getMessage();
    }
}


if (isset($_GET["removeProject"])) {
    $query = 'EXEC dbo.SP_DELETE_PROJECT
            :PROJECTNUMMER';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['removeProject']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Project verwijderd.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Project niet verwijderd. Foutmelding: " . $e->getMessage();
    }
}

if (isset($_POST["projectomschrijving"])) {
    $query = 'EXEC dbo.SP_UPDATE_PROJECT
            :PROJECTNUMMER,
            :PROJECTOMSCHRIJVING';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_POST['UPROJECTNUMMER']);
    $stmt->bindParam(':PROJECTOMSCHRIJVING', $_POST['projectomschrijving']);

    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Project geüpdatet.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Project niet geüpdatet. Foutmelding: " . $e->getMessage();
    }
}

try {
    $rs = $dbh->query("SELECT *
                                FROM BEDRIJF");
    $bedrijven = $rs->fetchAll();
} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Project niet geüpdatet. Foutmelding: " . $e->getMessage();
}

if (isset($_GET['project'])) {
    try {
        $stmt = $dbh->prepare("SELECT *
                                        FROM PROJECT
                                        WHERE BEDRIJFSNAAM = :BEDRIJFSNAAM
                                        AND LOCATIE = :LOCATIE");
        $stmt->execute(array(':BEDRIJFSNAAM' => $_GET['project'], ':LOCATIE' => $_GET['locatie']));
        $projecten = $stmt->fetchAll();
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Project niet geüpdatet. Foutmelding: " . $e->getMessage();
    }
}

?>
<div class="container">
    <div class="page-header">
        <h1>Bedrijven en projecten beheren</h1>
    </div>
    <?php include_once('include/melding.php') ?>

    <div class="row">
        <div class="col-md-6">
            <a href="?new=1" class="btn btn-block btn-primary">Bedrijf toevoegen</a>
            <div class="table-responsive marginTop">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Bedrijf</th>
                        <th>Locatie</th>
                    </tr>
                    </thead>
                    <?php
                    if (isset($_GET["new"])) {

                        echo '<form action="crud_bedrijf_project.php?new=1" method="post">
                        <tr>
                        <td><input class="form-control" type="text" name="BEDRIJFSNAAM"></td>
                        <td><input class="form-control" type="text" name="LOCATIE"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>
                        </tr>
                        </form>';
                    }
                    if (isset($_GET["editbedrijf"])) {
                        echo '<form action="crud_bedrijf_project.php?edit=1" method="post">
                        <input type="hidden" value="' . $_GET["editbedrijf"] . '" name="oudBEDRIJFSNAAM"></td>
                        <input type="hidden" value="' . $_GET["LOCATIE"] . '" name="oudLOCATIE"></td>
                        <tr>
                        <td><input class="form-control" type="text" value="' . $_GET["editbedrijf"] . '" name="editBEDRIJFSNAAM"></td>
                        <td><input class="form-control" type="text" value="' . $_GET["LOCATIE"] . '" name="editLOCATIE"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>
                        </tr>
                        </form>';
                    }
                    if (isset($bedrijven)) {
                        foreach ($bedrijven as $bedrijf) {
                          ?>  <tr onClick="document.location.href='crud_bedrijf_project.php?project=<?= $bedrijf["BEDRIJFSNAAM"] ?>&locatie=<?= $bedrijf["LOCATIE"]?>'">
                          <?php
                            echo '<td>' . $bedrijf["BEDRIJFSNAAM"] . '</td>
                            <td>' . $bedrijf["LOCATIE"] . '
                    <a href="?remove=' . $bedrijf["BEDRIJFSNAAM"] . '&LOCATIE=' . $bedrijf["LOCATIE"] . '"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                    <a href="?editbedrijf=' . $bedrijf["BEDRIJFSNAAM"] . '&LOCATIE=' . $bedrijf["LOCATIE"] . '"><span class="glyphicon glyphicon-pencil widintable"></span></a>';
                        }
                    }
                    ?>
                </table>
            </div>
        </div>
        <div class="col-md-6">
            <?php if (isset($_GET['project'])) {
                echo '<a class="no-link" href="?newProject=1&project=' . $_GET['project'] . '&locatie=' . $_GET['locatie'] . '">
                  <button class="btn btn-block btn-primary">Project aan bedrijf toevoegen</button>
                  </a>';
            }
            ?>
            <?php if (isset($_GET['project'])) { ?>
            <div class="table-responsive marginTop">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>Project</th>
                        <th>Omschrijving</th>
                    </tr>
                    </thead>
                    <?php
                    if (isset($_GET["newProject"])) {
                        echo '<form action="crud_bedrijf_project.php?project=' . $_GET['project'] . '&locatie=' . $_GET['locatie'] . '" method="post">
                        <tr>
                        <td></td>
                        <td><input class="form-control" type="text" name="PROJECTOMSCHRIJVING"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>
                        </tr>
                        </form>';
                    }

                    if (isset($_GET["editProject"])) {
                        echo '<form action="crud_bedrijf_project.php?edit=1" method="post">
                        <input type="hidden" value="' . $_GET["projectnummer1"] . '" name="UPROJECTNUMMER"></td>
                        <input type="hidden" value="' . $_GET["editProject"] . '" name="omschrijvingOud"></td>
                        <tr>
                        <td>' . $_GET["projectnummer1"] . '</a></td>
                        <td><input class="form-control" type="text" value="' . $_GET["editProject"] . '" name="projectomschrijving"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>
                        </tr>
                        </form>';
                    }
                    foreach ($projecten as $project) {
                        echo '<tr>
                        <td><a href=rd_rapportages.php?projectnummer=' . $project["PROJECTNUMMER"] . '>' . $project["PROJECTNUMMER"] . '</a></td>
                        <td>' . $project["PROJECTOMSCHRIJVING"] . '
                      <a href="?removeProject=' . $project["PROJECTNUMMER"] . '&project=' . $_GET['project'] . '&locatie=' . $_GET['locatie'] . '"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                      <a href="?editProject=' . $project["PROJECTOMSCHRIJVING"] . '&project=' . $_GET['project'] . '&locatie=' . $_GET['locatie'] . '&projectnummer1=' . $project["PROJECTNUMMER"] . '"><span class="glyphicon glyphicon-pencil widintable"></span></a></td>';
                    }
                    }
                    ?>
                </table>
            </div>
        </div>
    </div>
</div>

<?php include_once('include/footer.php'); ?>
