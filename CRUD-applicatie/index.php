<?php include_once('include/header.php') ?>
    <div class="container">
        <div class="page-header">
            <h1>Welkom <?= $_SESSION['gebruikersnaam'] ?></h1>
        </div>

        <div class="row">
            <div class="col-md-2">
                <a href="rd_projecten.php" class="btn btn-primary btn-lg btn-block btn-huge">
                    <span class="glyphicon glyphicon-list-alt glyphicon-big"></span>
                    <p>Alle projecten</p>
                </a>
            </div>
            <div class="col-md-2">
                <a href="crd_bedrijf_project.php" class="btn btn-primary btn-lg btn-block btn-huge">
                    <span class="glyphicon glyphicon-briefcase glyphicon-big"></span>
                    <p>Bedrijf en project</p>
                </a>
            </div>
            <div class="col-md-2">
                <a href="crd_aspect_effect.php" class="btn btn-primary btn-lg btn-block btn-huge">
                    <span class="glyphicon glyphicon-font glyphicon-big"></span>
                    <p>Aspect en effect</p>
                </a>
            </div>
        </div>
    </div>
<?php include_once('include/footer.php');
