<?php include_once('include/header.php') ?>

<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $query = "EXEC dbo.SP_UPDATE_PLAN_VAN_AANPAK
             :PROJECTNUMMER,
             :RAPPORTNUMMER,
             :REGELNUMMER,
             :UITGEVOERD_DOOR,
             :EINDVERANTWOORDELIJKE,
             :DATUM_GEREED_GEPLAND,
             :PBM,
             :VOORLICHTING,
             :WERKINSTRUCTIE_PROCEDURE,
             :TRA,
             :CONTRACT_LIJST_";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
    $stmt->bindParam(':UITGEVOERD_DOOR', $_POST['UITGEVOERD_DOOR']);
    $stmt->bindParam(':EINDVERANTWOORDELIJKE', $_POST['EINDVERANTWOORDELIJKE']);
    $stmt->bindParam(':DATUM_GEREED_GEPLAND', $_POST['DATUM_GEREED_GEPLAND']);
    $stmt->bindParam(':PBM', $_POST['PBM']);
    $stmt->bindParam(':VOORLICHTING', $_POST['VOORLICHTING']);
    $stmt->bindParam(':WERKINSTRUCTIE_PROCEDURE', $_POST['WERKINSTRUCTIE_PROCEDURE']);
    $stmt->bindParam(':TRA', $_POST['TRA']);
    $stmt->bindParam(':CONTRACT_LIJST_', $_POST['CONTRACT_LIJST_']);


    try {
        $stmt->execute();

        $meldingStatus = true;
        $melding = "Plan van aanpak geüpdatet.";
    } catch (PDOException $e) {
        $meldingStatus = false;
        $melding = "Plan van aanpak niet geüpdatet. Foutmelding: " . $e->getMessage();


        $result['UITGEVOERD_DOOR'] = $_POST['UITGEVOERD_DOOR'];
        $result['EINDVERANTWOORDELIJKE'] = $_POST['EINDVERANTWOORDELIJKE'];
        $result['PBM'] = $_POST['PBM'];
        $result['VOORLICHTING'] = $_POST['VOORLICHTING'];
        $result['WERKINSTRUCTIE_PROCEDURE'] = $_POST['WERKINSTRUCTIE_PROCEDURE'];
        $result['TRA'] = $_POST['TRA'];
        $result['CONTRACT_LIJST_'] = $_POST['CONTRACT_LIJST_'];
    }
}
try {
    $query = "SELECT *
              FROM PLAN_VAN_AANPAK
              WHERE PROJECTNUMMER = :PROJECTNUMMER
              AND RAPPORTNUMMER = :RAPPORTNUMMER
              AND REGELNUMMER = :REGELNUMMER";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);

    $stmt->execute();
    $result = $stmt->fetch();

} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Plan van aanpak niet opgeslagen. Foutmelding: " . $e->getMessage();
}


try {
    $query = "SELECT *
              FROM PERIODIEKE_BEOORDELING
              WHERE PROJECTNUMMER = :PROJECTNUMMER
              AND RAPPORTNUMMER = :RAPPORTNUMMER
              AND REGELNUMMER = :REGELNUMMER";
    $stmt = $dbh->prepare($query);
    $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
    $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
    $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);

    $stmt->execute();
    $periodieke_beoordelingen = $stmt->fetchAll();

} catch (PDOException $e) {
    $meldingStatus = false;
    $melding = "Periodieke beoordelingen niet kunnen ophalen. Foutmelding: " . $e->getMessage();
}
$query = "SELECT PROJECTNUMMER, RAPPORTNUMMER, REGELNUMMER, UITGEVOERD_DOOR, EINDVERANTWOORDELIJKE,
          DATUM_GEREED_GEPLAND, PBM, VOORLICHTING, WERKINSTRUCTIE_PROCEDURE, TRA, CONTRACT_LIJST_, GEBRUIKER, DATUM, ACTIE
          FROM PLAN_VAN_AANPAK_HISTORY
          WHERE PROJECTNUMMER = :PROJECTNUMMER
          AND RAPPORTNUMMER = :RAPPORTNUMMER
          AND REGELNUMMER = :REGELNUMMER";
          $stmt = $dbh->prepare($query);
          $stmt->bindParam(':PROJECTNUMMER', $_GET['projectnummer']);
          $stmt->bindParam(':RAPPORTNUMMER', $_GET['rapportnummer']);
          $stmt->bindParam(':REGELNUMMER', $_GET['regelnummer']);
          $history = null;
          try{
          $stmt->execute();
          $history = $stmt->fetchall();
        }
        catch (PDOException $e) {
            $meldingStatus = false;
            $melding = "Periodieke beoordeling niet kunnen ophalen. Foutmelding: " . $e->getMessage();
        }
?>

    <div class="container" xmlns="http://www.w3.org/1999/html">
        <div class="page-header">
            <h1>Plan van aanpak wijzigen </h1>
            <h4>Projectnummer
                <?= $_GET['projectnummer'] ?>, rapportnummer
                    <?= $_GET['rapportnummer'] ?>, regelnummer
                        <?= $_GET['regelnummer'] ?>
            </h4>
        </div>
        <?php include_once('include/melding.php') ?>

        <div class="row">
            <div class="col-md-12">
                <form action="u_plan_van_aanpak.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['regelnummer'] ?> " method="post">
                    <h3>Plan van aanpak</h3>
                    <div class="form-group">
                        <label for="UITGEVOERD_DOOR">Uitgevoerd door:</label>
                        <input type="text" class="form-control" name="UITGEVOERD_DOOR" value="<?php if (isset($result['UITGEVOERD_DOOR'])) {
                           echo $result['UITGEVOERD_DOOR'];
                       } ?>">
                    </div>
                    <div class="form-group">
                        <label for="EINDVERANTWOORDELIJKE">Eindverantwoordelijke</label>
                        <input type="text" class="form-control" name="EINDVERANTWOORDELIJKE" value="<?php if (isset($result['EINDVERANTWOORDELIJKE'])) {
                           echo $result['EINDVERANTWOORDELIJKE'];
                       } ?>">
                    </div>
                    <div class="form-group">
                        <label for="DATUM_GEREED_GEPLAND">Datum gereed gepland</label>
                        <input type="date" class="form-control" name="DATUM_GEREED_GEPLAND" value="<?php if (isset($result['DATUM_GEREED_GEPLAND'])) {
                           echo strftime('%Y-%m-%d', strtotime($result['DATUM_GEREED_GEPLAND']));
                       } ?>">
                    </div>
                    <div class="form-group">
                        <label for="PBM">PBM</label>
                        <textarea class="form-control" rows="2" name="PBM"><?php if (isset($result['PBM'])) {
                        echo $result['PBM'];
                    } ?></textarea>
                    </div>
                    <div class="form-group">
                        <label for="VOORLICHTING">Voorlichting</label>
                        <textarea class="form-control" rows="2" name="VOORLICHTING"><?php if (isset($result['VOORLICHTING'])) {
                        echo $result['VOORLICHTING'];
                    } ?></textarea>
                    </div>
                    <div class="form-group">
                        <label for="WERKINSTRUCTIE_PROCEDURE">Werkinstructie procedure</label>
                        <textarea class="form-control" rows="2" name="WERKINSTRUCTIE_PROCEDURE"><?php if (isset($result['WERKINSTRUCTIE_PROCEDURE'])) {
                        echo $result['WERKINSTRUCTIE_PROCEDURE'];
                    } ?></textarea>
                    </div>
                    <div class="form-group">
                        <label for="TRA">TRA</label>
                        <textarea class="form-control" rows="2" name="TRA"><?php if (isset($result['TRA'])) {
                        echo $result['TRA'];
                    } ?></textarea>
                    </div>
                    <div class="form-group">
                        <label for="CONTRACT_LIJST_">Controlelijst</label>
                        <textarea class="form-control" rows="2" name="CONTRACT_LIJST_"><?php if (isset($result['CONTRACT_LIJST_'])) {
                        echo $result['CONTRACT_LIJST_'];
                    } ?></textarea>
                    </div>

                    <button class="btn btn-block btn-primary" name="submit" type="submit">Plan van aanpak wijzigen</button>
                </form>

            </div>
          </div>

            <h3>Periodieke beoordelingen</h3>
            <div class="row">
                <div class="col-md-12">
                    <a class="btn btn-block btn-primary" href="c_periodieke_beoordeling.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $_GET['regelnummer'] ?>">Periodieke
                beoordeling toevoegen</a>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">

                    <br>

                    <table id="table" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Datum beoordeling</th>
                                <th>Inspectie uitgevoerd</th>
                                <th>Opmerkingen s.v.z.</th>
                                <th>Stand van zaken</th>
                                <th>Score</th>
                                <th>Wijzigen</th>

                            </tr>
                        </thead>
                        <tbody>
                            <?php foreach ($periodieke_beoordelingen as &$value) { ?>
                            <tr>
                                <td>
                                    <?php echo strftime('%d-%m-%Y', strtotime($value['DATUM_BEOORDELING'])); ?>
                                </td>
                                <td>
                                    <?php if ($value['INSPECTIE_IS_DE_ACTIE_UITGEVOERD'] == 0) {
                                        echo 'Nee';
                                    } else {
                                        echo 'Ja';
                                    }; ?>
                                </td>
                                <td>
                                    <?= $value['OPMERKING_STAND_VAN_ZAKEN'] ?>
                                </td>
                                <td>
                                    <?= $value['STAND_VAN_ZAKEN'] ?>
                                </td>
                                <td>
                                    <?= $value['SCORE'] ?>
                                </td>
                                </div>
                                <td>
                                    <a id="periodiekebutton" style="padding: 0 12px;" href="u_periodieke_beoordeling.php?projectnummer=<?= $_GET['projectnummer'] ?>&rapportnummer=<?= $_GET['rapportnummer'] ?>&regelnummer=<?= $value['REGELNUMMER'] ?>&datum=<?= $value['DATUM_BEOORDELING']; ?>" class="btn btn-block btn-primary">Wijzigen</a>
                                </td>
                            </tr>
                            <?php } ?>
                        </tbody>
                    </table>
                  <button class="btn btn-block btn-default" onclick="ShowDiv()">Versiegeschiedenis weergeven</button>

                  <div style="display: none;" id="versiebeheer">
                      <br>
                      <h1>Versiegeschiedenis</h1>
                      <div style="overflow: auto;">
                          <?php if(count($history) > 0) { ?>
                          <table class="table table-striped table-bordered" style="margin: 0; padding: 0;">
                              <thead>
                                  <tr>
                                      <th>Datum</th>
                                      <th>Gebruiker</th>
                                      <th>Actie</th>
                                      <th>Projectnummer</th>
                                      <th>Rapportnummer</th>
                                      <th>Regelnummer</th>
                                      <th>Uitgevoerd door</th>
                                      <th>Eindverantwoordelijke</th>
                                      <th>Datum gereed gepland</th>
                                      <th>PBM</th>
                                      <th>Voorlichting</th>
                                      <th>Werkinstructie procedure</th>
                                      <th>TRA</th>
                                      <th>Contract lijst</th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <?php foreach ($history as $value) { ?>
                                  <tr>
                                      <td><?= $value['DATUM'] ?></td>
                                      <td>
                                          <?= $value['GEBRUIKER'] ?>
                                      </td>
                                      <td>
                                          <?= $value['ACTIE'] ?>
                                      </td>
                                      <td>
                                          <?= $value['PROJECTNUMMER'] ?>
                                      </td>
                                      <td>
                                          <?= $value['RAPPORTNUMMER'] ?>
                                      </td>
                                      <td>
                                          <?= $value['REGELNUMMER'] ?>
                                      </td>
                                      <td>
                                          <?= $value['UITGEVOERD_DOOR'] ?>
                                      </td>
                                      <td>
                                          <?= $value['EINDVERANTWOORDELIJKE'] ?>
                                      </td>
                                      <td>
                                          <?= $value['DATUM_GEREED_GEPLAND'] ?>
                                      </td>
                                      <td>
                                          <?= $value['PBM'] ?>
                                      </td>
                                      <td>
                                          <?= $value['VOORLICHTING'] ?>
                                      </td>
                                      <td>
                                          <?= $value['WERKINSTRUCTIE_PROCEDURE'] ?>
                                      </td>
                                      <td>
                                          <?= $value['TRA'] ?>
                                      </td>
                                      <td>
                                          <?= $value['CONTRACT_LIJST_'] ?>
                                      </td>
                                  </tr>
                                  <?php } ?>
                              </tbody>
                          </table>
                          <?php } else { ?>
                          <p>Er zijn geen oudere versies.</p>
                          <?php } ?>
                        </div>
</div>
        </div>
      </div>
    </div>

    <br>
    <script type="text/javascript">
        var projectnummer = "<?= $_GET['projectnummer'] ?>";
        var rapportnummer = "<?= $_GET['rapportnummer'] ?>";
        function ShowDiv() {
            document.getElementById("versiebeheer").style.display = "";
        }
    </script>

    <?php include_once('include/footer.php'); ?>
