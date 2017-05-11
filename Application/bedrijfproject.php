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
        $stmt->release();
    }
}
if (isset($_GET["remove"])) {
    $query = 'EXEC dbo.deleteBedrijf
            :BEDRIJFSNAAM,
            :LOCATIE';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':BEDRIJFSNAAM', $dbh->quote($_GET['remove']));
    $stmt->bindParam(':LOCATIE', $dbh->quote($_GET['LOCATIE']));
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Regel opgeslagen.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
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
            <a href="?new=1">
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
                    if (isset($_GET["new"])) {
                        echo '<form action="bedrijfproject.php?new=1" method="post">';
                        echo '<tr>';
                        echo '<td><input type="text" name="BEDRIJFSNAAM"></td>';
                        echo '<td><input type="text" name="LOCATIE"><button type="submit"><span class="glyphicon glyphicon-ok widintable"></button></td>';
                        echo '</tr>';
                        echo '</form>';
                    }
                    ?>
                    <tr>
                        <?php
                        $rs = $dbh->query("SELECT * FROM BEDRIJF");
                        $bedrijven = $rs->fetchAll();
                        foreach ($bedrijven as $bedrijf) {
                            echo '<tr>';
                            echo '<td>' . $bedrijf["BEDRIJFSNAAM"] . '</td>';
                            echo '<td>' . $bedrijf["LOCATIE"] . '
                    <a href="?remove=' . $bedrijf["BEDRIJFSNAAM"] . '&LOCATIE=' . $bedrijf["LOCATIE"] . '"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                    <a href="?edit=' . $bedrijf["BEDRIJFSNAAM"] . '&LOCATIE=' . $bedrijf["LOCATIE"] . '"><span class="glyphicon glyphicon-pencil widintable"></span></a>
                    </td>';
                            echo '</tr>';
                        }

                        ?>
                    </tr>
                </table>
            </div>
        </div>
        <div class="col-md-2">
        </div>
        <div class="col-md-5">
            <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
            <div class="row">
            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                    <tr>
                        <th>Project</th>
                        <th>Omschrijving</th>
                    </tr>
                    </thead>
                    <tr>
                        <td>Project 1</td>
                        <td>Omschrijving 1
                            <a href="?remove=1"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                            <a href="?edit=1"><span class="glyphicon glyphicon-pencil widintable"></span></a>
                        </td>
                    </tr>
                    <tfoot>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    <form method="GET" id="bedrijfForm" action="Zoeken">
        <input type="hidden" id="inputBedrijf" name="bedrijf"/>
    </form>


<?php include_once('include/footer.php');
