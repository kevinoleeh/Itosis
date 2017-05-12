<?php include_once('include/header.php'); ?>
<div class="container">
    <div class="page-header">
        <h1>Aspecten</h1>
    </div>

    <div class="row">
        <div class="col-md-5">
            <input type="search" style="">
            <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
            <div class="row">

            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Aspect</th>
                        </tr>
                    </thead>

                    <?php

                    $rs = $dbh->query("SELECT * FROM ASPECT");
                    $bedrijven = $rs->fetchAll();
                    $i = 1;
                    foreach ($bedrijven as $bedrijf) {

            ?>
                        <tr>
                            <td class="numberwidth">
                                <?php echo $i++; ?>
                            </td>
                            <td><?php echo $bedrijf["ASPECTNAAM"] ?></td>
                        </tr>
                        <?php } ?>
                </table>
            </div>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-5">
            <input type="search" style="">
            <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
            <div class="row">
            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Effect</th>
                        </tr>
                    </thead>

                    <?php

                    $rs = $dbh->query("SELECT * FROM EFFECT");
                    $bedrijven = $rs->fetchAll();
                    $i = 1;
                    foreach ($bedrijven as $bedrijf) {

                ?>


                        <tr>
                            <td class="numberwidth">
                                <?php echo $i++; ?>
                            </td>
                            <td><?php echo $bedrijf["EFFECTNAAM"] ?> </td>
                        </tr>
                        <?php } ?>


                </table>
            </div>
        </div>
    </div>
</div>

<?php include_once('include/footer.php');?>
