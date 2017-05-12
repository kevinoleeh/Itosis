<?php include_once('include/header.php') ?>

<?php
$query = "SELECT *
         FROM RAPPORT
         WHERE PROJECTNUMMER = :PROJECTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);

try {
    $stmt->execute();
    $result = $stmt->fetchAll();
} catch (PDOException $e) {
    echo "Foutmelding: " . $e->getMessage();
}

?>

<div class="container">
    <div class="page-header">
        <h1>Rapportage</h1>
    </div>

    <div class="row">
        <div class="col-md-12">
            <table class="table table-striped table-bordered">
                <thead>
                <tr>
                    <th>Rapportnummer</th>
                    <th>Type</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($result as &$value) { ?>
                    <tr>
                        <td><a href="risicoregels.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $value['RAPPORTNUMMER'] ?>"><?= $value['RAPPORTNUMMER'] ?></a></td>
                        <td><?= $value['RAPPORT_TYPE'] ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
<?php include_once('include/footer.php');
