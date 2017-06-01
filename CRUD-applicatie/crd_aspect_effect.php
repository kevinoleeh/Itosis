<?php include_once('include/header.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_GET["insertAspect"])) {
        $query = 'EXEC dbo.SP_INSERT_ASPECT
              :ASPECT';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':ASPECT', $_POST['ASPECTNAAM']);
        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Regel opgeslagen.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
        }
    }


    if (isset($_GET["aspectnaam"])) {
        $query = 'EXEC dbo.SP_INSERT_ASPECT_EFFECT_EFFECT
               :ASPECT,
              :EFFECT';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':ASPECT', $_GET['aspectnaam']);
        $stmt->bindParam(':EFFECT', $_POST['EFFECTNAAM']);
        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Regel opgeslagen.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Regel niet opgeslagen. Foutmelding: " . $e->getMessage();
        }
    }

    if (isset($_GET["aspectnaam"])) {
        if (isset($_GET["control"])) {
            $query = 'EXEC dbo.SP_INSERT_ASPECT_EFFECT
              :ASPECT,
              :EFFECT';
            $stmt = $dbh->prepare($query);
            $stmt->bindParam(':ASPECT', $_GET['aspectnaam']);
            $stmt->bindParam(':EFFECT', $_POST['EFFECTNAAM']);
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
}
if (isset($_GET["removeAspect"])) {
    if (isset($_GET["checkAspect"])) {
        $query = 'EXEC dbo.SP_DELETE_ASPECT
              :ASPECTNAAM';
        $stmt = $dbh->prepare($query);
        $stmt->bindParam(':ASPECTNAAM', $_GET['removeAspect']);
        try {
            $stmt->execute();

            $meldingStatus = true;
            $melding = "Aspect verwijderd.";
        } catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Aspect niet verwijderd. Foutmelding: " . $e->getMessage();
        }
    }
}
if (isset($_GET["removeEffect"])) {
    $query = 'EXEC dbo.SP_DELETE_EFFECT_BIJ_ASPECT_EFFECT
              :ASPECTNAAM,
              :EFFECTNAAM';
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':ASPECTNAAM', $_GET['removeAspect']);
    $stmt->bindParam(':EFFECTNAAM', $_GET['removeEffect']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Effect verwijderd.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Effect niet verwijderd. Foutmelding: " . $e->getMessage();
    }
}
if (isset($_POST["ASPECTNAAMNEW"])) {
    $query = 'EXEC dbo.SP_UPDATE_ASPECT
              :ASPECTNAAMOUD,
              :ASPECTNAAMNEW
              ';
    $stmt = $dbh->prepare($query);

    $stmt->bindParam(':ASPECTNAAMOUD', $_POST['ASPECTNAAMOUD']);

    $stmt->bindParam(':ASPECTNAAMNEW', $_POST['ASPECTNAAMNEW']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Het aspect is succesvol geüpdatet";

    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Aspect niet geupdatet. Foutmelding: " . $e->getMessage();
    }
}

if (isset($_POST["EFFECTNAAMNEW"])) {
    $query = 'EXEC dbo.SP_UPDATE_EFFECT
              :EFFECTNAAMOUD,
              :EFFECTNAAMNEW
              ';
    $stmt = $dbh->prepare($query);

    $stmt->bindParam(':EFFECTNAAMOUD', $_POST['EFFECTNAAMOUD']);

    $stmt->bindParam(':EFFECTNAAMNEW', $_POST['EFFECTNAAMNEW']);
    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Het effect is succesvol geüpdatet";

    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Effect niet geupdatet. Foutmelding: " . $e->getMessage();
    }
}
try {
$rs = $dbh->query("SELECT * FROM ASPECT");
$aspecten = $rs->fetchAll();
}catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Foutmelding: " . $e->getMessage();
}
if (isset($_GET["inserteffect"])) {
try{
$stmt = $dbh->query("SELECT EFFECTNAAM FROM ASPECT_EFFECT WHERE ASPECTNAAM = '$ASPECTNAAMKEUS'");

$effecten = $stmt->fetchAll();

$rss = $dbh->query("SELECT * FROM EFFECT");
$alleEffecten = $rss->fetchAll();
}
catch (PDOException $e) {
  $meldingStatus = false;
  $melding = "Foutmelding: " . $e->getMessage();
}
}
?>
<div class="container">
    <div class="page-header">
        <h1>Aspecten en effecten beheren</h1>
    </div>
    <?php include_once('include/melding.php') ?>

    <div class="row">
        <div class="col-md-5">
            <a href="?insertAspect=1" class="btn btn-block btn-primary">Aspect toevoegen</a>
        </div>

        <div class="col-md-1">
        </div>
        <div class="col-md-5">
            <?php if (isset($_GET['aspectnaam'])) {
                echo '  <a class="no-link" href="?inserteffect=1&aspectnaam=' . $_GET['aspectnaam'] . '">
                <button class="btn btn-block btn-primary">Effect aan aspect toevoegen</button>
            </a>';
            } ?>
        </div>
    </div>

    <div class="row">
        <div class="col-md-5">
            <div class="table-responsive marginTop">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                        <tr class="borderwhite">
                            <th>Aspect</th>
                        </tr>
                    </thead>
                    <?php

                    if (isset($_GET["insertAspect"])) {
                        echo '<form action="crd_aspect_effect.php?insertAspect=1" method="post">';
                        echo '<tr>';
                        echo '<td><input class="form-control" type="text" name="ASPECTNAAM"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                        echo '</tr>';
                        echo '</form>';
                    }
                    if (isset($_GET["editAspect"])) {
                        echo '<form action="crd_aspect_effect.php?edit=1" method="post">';
                        echo '<input type="hidden" value="' . $_GET["editAspect"] . '" name="ASPECTNAAMOUD"></td>';
                        echo '<tr>';

                        echo '<td><input type="text" value="' . $_GET["editAspect"] . '" name="ASPECTNAAMNEW">';
                        echo '<button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                        echo '</tr>';
                        echo '</form>';
                    }
                    if(isset($aspecten)){
                    foreach ($aspecten as $aspecten) {
                        echo '<tr>
                              <td><a href="crd_aspect_effect.php?aspectnaam='.$aspecten["ASPECTNAAM"].'"> '.$aspecten["ASPECTNAAM"].'</a>
                              <a href="?removeAspect='.$aspecten["ASPECTNAAM"].'&checkAspect=1"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                                <a href="?editAspect='.$aspecten["ASPECTNAAM"].'&"><span class="glyphicon glyphicon-pencil widintable"></span></a></td>
                              </tr>';
                    }
                  }
                  ?>

                </table>
            </div>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-5">
            <?php if (isset($_GET['aspectnaam'])){ ?>
            <div class="table-responsive marginTop">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                        <tr class="borderwhite">
                            <th>Effect</th>
                        </tr>
                    </thead>
                    <?php


                    $ASPECTNAAMKEUS = $_GET['aspectnaam'];
                    $i = 1;
                    if (isset($_GET["inserteffect"])) {
                        echo '<form action="crd_aspect_effect.php?control=1&aspectnaam=' . $_GET['aspectnaam'] . '" method="post">';
                        echo '<tr>';
                        echo '  <td><p><b>Effect toevoegen (kies):</b></p><select name="EFFECTNAAM" class="form-control">';
                        foreach ($alleEffecten as $effect) {
                            echo '  <option > ' . $effect['EFFECTNAAM'] . '</option>';
                        }
                        echo '  </select><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button> </td>';
                        echo '</tr>';
                        echo '</form>';
                    }



                    if (isset($_GET["inserteffect"])) {
                        echo '<form action="crd_aspect_effect.php?aspectnaam=' . $_GET['aspectnaam'] . '" method="post">';
                        echo '<tr>';
                        echo '<td><p><b>Effect toevoegen (nieuw):</b></p><input class="form-control" type="text" name="EFFECTNAAM"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                        echo '</tr>';
                        echo '</form>';

                    }

                    if (isset($_GET["editEffect"])) {
                        echo '<form action="crd_aspect_effect.php?edit=1" method="post">';
                        echo '<input type="hidden" value="' . $_GET["editEffect"] . '" name="EFFECTNAAMOUD"></td>';
                        echo '<tr>';
                        echo '<td><input class="form-control" type="text" value="' . $_GET["editEffect"] . '" name="EFFECTNAAMNEW">';
                        echo '<button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                        echo '</tr>';
                        echo '</form>';
                    }

                    foreach ($effecten as $effectnaam) {
                        ?>

                        <tr>
                            <td>
                                <?php echo $effectnaam["EFFECTNAAM"];
                              echo'  <a href="?removeEffect='.$effectnaam["EFFECTNAAM"].'&removeAspect='.$_GET["aspectnaam"].'&aspectnaam='.$_GET["aspectnaam"].'"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                                     <a href="?editEffect='.$effectnaam["EFFECTNAAM"].'&aspectnaam='.$_GET['aspectnaam'].'"><span class="glyphicon glyphicon-pencil widintable"></span></a></td>';
                              ?>
                            </td>

                        </tr>
                        <?php }
                    } ?>
                </table>
            </div>
        </div>
    </div>
</div>

<?php include_once('include/footer.php'); ?>
