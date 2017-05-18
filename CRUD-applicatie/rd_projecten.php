<?php include_once('include/header.php') ?>

<?php
$query = "SELECT *
          FROM PROJECT";
$stmt = $dbh->prepare($query);

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

?>

<div class="container">
    <div class="page-header">
        <h1>Projecten</h1>
    </div>

    <div class="row">
        <div class="col-md-12">
            <a href="bedrijfproject.php" class="btn btn-block btn-primary">Project toevoegen</a>
            <br>

            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Projectnummer</th>
                    <th>Projectomschrijving</th>
                    <th>Bedrijf</th>
                    <th>Locatie</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($result as &$value) { ?>
                    <tr>
                        <td><a href="rd_rapportages.php?projectnummer=<?= $value['PROJECTNUMMER'] ?>"><?= $value['PROJECTNUMMER'] ?></a></td>
                        <td><?= $value['PROJECTOMSCHRIJVING'] ?></td>
                        <td><?= $value['BEDRIJFSNAAM'] ?></td>
                        <td><?= $value['LOCATIE'] ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php include_once('include/footer.php');
