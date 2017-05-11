<?php include_once('include/header.php') ?>

<?php
$query = "EXEC dbo.SELECT_ALLE_RISICOREGELS 
         :PROJECTNUMMER, 
         :RAPPORTNUMMER";
$stmt = $dbh->prepare($query);
$stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
$stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);

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
                    <th>Regelnummer</th>
                    <th>Aspect</th>
                    <th>Effect</th>
                    <th>Arbo onderwerp</th>
                </tr>
                </thead>
                <tbody>
                <?php foreach ($result as &$value) { ?>
                    <tr>
                        <td><?= $value['REGELNUMMER'] ?></td>
                        <td><?= $value['ASPECTNAAM'] ?></td>
                        <td><?= $value['EFFECTNAAM'] ?></td>
                        <td><?= $value['ARBO_ONDERWERP'] ?></td>
                    </tr>
                <?php } ?>
                </tbody>
            </table>
        </div>
    </div>

    <div class="row">
        <ul class="pagination">
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
        </ul>
    </div>
</div>
<?php include_once('include/footer.php');
