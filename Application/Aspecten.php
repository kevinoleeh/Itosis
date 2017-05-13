<?php include_once('include/header.php');

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_GET["insertAspect"])) {
        $query = 'EXEC dbo.sp_insertAspect
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
        $query = 'EXEC dbo.sp_insertAspect_Effect_MetEffect
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
      if (isset($_GET["control"])){
        $query = 'EXEC dbo.sp_insertAspect_Effect
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

?>
<div class="container">
    <div class="page-header">
        <h1>Aspecten</h1>
    </div>
 <?php include_once('include/melding.php') ?>
    <div class="row">
        <div class="col-md-5">
            <a  href="?insertAspect=1">
                <button href="?insertAspect=1" class="btn btn-justified btn-right">Toevoegen</button>
            </a>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-5">
        <?php  if(isset($_GET['aspectnaam'])){
          echo'  <a class="no-link" href="?inserteffect=1&aspectnaam='.$_GET['aspectnaam'].'">
                <button class="btn btn-justified btn-right">Toevoegen</button>
            </a>';
            } ?>
        </div>

    </div>

    <div class="row">
        <div class="col-md-5">
            <div class="table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Aspect</th>
                        </tr>
                    </thead>
                    <?php

                        if (isset($_GET["insertAspect"])) {
                            echo '<form action="Aspecten.php?insertAspect=1" method="post">';
                            echo '<tr>';
                            echo '<th>Aspect toevoegen:</th>';
                            echo '<td><input class="form-control" type="text" name="ASPECTNAAM"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok"></button></td>';
                            echo '</tr>';
                            echo '</form>';
                        }

                    $rs = $dbh->query("SELECT * FROM ASPECT");
                    $aspecten = $rs->fetchAll();
                    $i = 1;
                      foreach ($aspecten as $aspecten) {
                                echo'<tr>';
                                echo'<td class="numberwidth">';
                                echo   $i++;
                                echo'  </td>';
                                echo' <td><a href="aspecten.php?aspectnaam='.$aspecten["ASPECTNAAM"].'"> '.$aspecten["ASPECTNAAM"].'</a></td>';
                                echo'  </tr>';
                      } ?>
                </table>
            </div>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-5">
        <?php  if(isset($_GET['aspectnaam'])){  ?>
            <div class="table-responsive">
                <table id="table" class="table table-striped table-bordered marginTop">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Effect</th>
                        </tr>
                    </thead>
                    <?php


                    $ASPECTNAAMKEUS = $_GET['aspectnaam'];
                    $stmt = $dbh->query("SELECT EFFECTNAAM FROM ASPECT_EFFECT WHERE ASPECTNAAM = '$ASPECTNAAMKEUS'");
                    $effecten = $stmt->fetchAll();

                    $rss = $dbh->query("SELECT * FROM EFFECT");
                    $alleEffecten = $rss->fetchAll();
                    $i = 1;

                    if (isset($_GET["inserteffect"])) {
                      echo '<form action="Aspecten.php?control=1&aspectnaam='.$_GET['aspectnaam'].'" method="post">';
                      echo '<tr>';
                      echo '<th>Effect toevoegen (kies):</th>';
                      echo'  <td>  <select name="EFFECTNAAM" class="form-control">';
                          foreach ($alleEffecten as $effect) {
                            echo'  <option > '.$effect['EFFECTNAAM'].'</option>';
                          }
                     echo'  </select><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button> </td>';
                      echo '</tr>';
                      echo '</form>';
                    }


                    if (isset($_GET["inserteffect"])) {
                      echo '<form action="Aspecten.php?aspectnaam='.$_GET['aspectnaam'].'" method="post">';
                      echo '<tr>';
                      echo '<th>Effect toevoegen (nieuw):</th>';
                      echo '<td><input class="form-control" type="text" name="EFFECTNAAM"><button class="buttonlink widintable" type="submit"><span class="glyphicon glyphicon-ok green"></button></td>';
                      echo '</tr>';
                      echo '</form>';

                    }

                      foreach ($effecten as $effectnaam) {
                ?>

                        <tr>
                            <td class="numberwidth">
                                <?php echo $i++; ?>
                            </td>
                            <td>
                                <?php echo $effectnaam["EFFECTNAAM"]?>
                            </td>
                        </tr>
                        <?php }} ?>
                </table>
            </div>
        </div>
    </div>
</div>

<?php include_once('include/footer.php');?>
