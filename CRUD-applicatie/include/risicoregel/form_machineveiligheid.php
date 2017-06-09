<h2>Machineveiligheid</h2>
<div class="form-group">
    <label for="PID">PID</label>
    <input type="text" class="form-control" name="PID" value="<?php if(isset($result['PID'])) { echo $result['PID']; } ?>">
</div>
<div class="form-group">
    <label for="LIJN">Lijn</label>
    <input type="text" class="form-control" name="LIJN" value="<?php if(isset($result['LIJN'])) { echo $result['LIJN']; } ?>">
</div>
<div class="form-group">
    <label for="MACHINE_CODE">Machine code</label>
    <input type="text" class="form-control" name="MACHINE_CODE" value="<?php if(isset($result['MACHINE_CODE'])) { echo $result['MACHINE_CODE']; } ?>">
</div>
<div class="form-group">
    <label for="MACHINE">Machine</label>
    <input type="text" class="form-control" name="MACHINE" value="<?php if(isset($result['MACHINE'])) { echo $result['MACHINE']; } ?>">
</div>
<div class="form-group">
    <label for="MODEL_TYPE">Model type</label>
    <input type="text" class="form-control" name="MODEL_TYPE" value="<?php if(isset($result['MODEL_TYPE'])) { echo $result['MODEL_TYPE']; } ?>">
</div>
<div class="form-group">
    <label for="SERIENUMMER">Serienummer</label>
    <input type="text" class="form-control" name="SERIENUMMER" value="<?php if(isset($result['SERIENUMMER'])) { echo $result['SERIENUMMER']; } ?>">
</div>
<div class="form-group">
    <label for="LEVERANCIER">Leverancier</label>
    <input type="text" class="form-control" name="LEVERANCIER" value="<?php if(isset($result['LEVERANCIER'])) { echo $result['LEVERANCIER']; } ?>">
</div>
<div class="form-group">
    <label for="CE_MARKERING">CE Markering</label>
    <input type="text" class="form-control" name="CE_MARKERING" value="<?php if(isset($result['CE_MARKERING'])) { echo $result['CE_MARKERING']; } ?>">
</div>
<div class="form-group">
    <label for="CE_DOCUCHECK">CE Docucheck</label>
    <input type="text" class="form-control" name="CE_DOCUCHECK" value="<?php if(isset($result['CE_DOCUCHECK'])) { echo $result['CE_DOCUCHECK']; } ?>">
</div>
<div class="form-group">
    <label for="AANVULLENDE_OMSCHRIJVING">Aanvullende omschrijving</label>
    <input type="text" class="form-control" name="AANVULLENDE_OMSCHRIJVING" value="<?php if(isset($result['AANVULLENDE_OMSCHRIJVING'])) { echo $result['AANVULLENDE_OMSCHRIJVING']; } ?>">
</div>
<div class="form-group">
    <label for="TAKEN">Taken</label>
    <input type="text" class="form-control" name="TAKEN" value="<?php if(isset($result['TAKEN'])) { echo $result['TAKEN']; } ?>">
</div>
<label for="TRANSPORT">Transport</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TRANSPORT" <?php if(isset($result['TRANSPORT'])) { if(strcmp($result['TRANSPORT'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="MONTAGE">Montage</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="MONTAGE" <?php if(isset($result['MONTAGE'])) { if(strcmp($result['MONTAGE'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="IN_BEDRIJFSNAME">In bedrijfsname</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="IN_BEDRIJFSNAME" <?php if(isset($result['IN_BEDRIJFSNAME'])) { if(strcmp($result['IN_BEDRIJFSNAME'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="TIJDENS_PRODUCTIE">Tijdens productie</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TIJDENS_PRODUCTIE" <?php if(isset($result['TIJDENS_PRODUCTIE'])) { if(strcmp($result['TIJDENS_PRODUCTIE'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="TIJDENS_ONDERHOUD">Tijdens onderhoud</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TIJDENS_ONDERHOUD" <?php if(isset($result['TIJDENS_ONDERHOUD'])) { if(strcmp($result['TIJDENS_ONDERHOUD'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="TIJDENS_STORING">Tijdens storing</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TIJDENS_STORING" <?php if(isset($result['TIJDENS_STORING'])) { if(strcmp($result['TIJDENS_STORING'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="TIJDENS_REINIGEN">Tijdens reinigen</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TIJDENS_REINIGEN" <?php if(isset($result['TIJDENS_REINIGEN'])) { if(strcmp($result['TIJDENS_REINIGEN'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="TIJDENS_AFSTELLEN">Tijdens afstellen</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="TIJDENS_AFSTELLEN" <?php if(isset($result['TIJDENS_AFSTELLEN'])) { if(strcmp($result['TIJDENS_AFSTELLEN'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<label for="DEMONTAGE">Demontage</label>
<div class="form-group">
    <input type="checkbox" style="width: 34px; height: 34px;" rel="DEMONTAGE" <?php if(isset($result['DEMONTAGE'])) { if(strcmp($result['DEMONTAGE'], '1') == 0) { echo 'checked'; } } ?>>
</div>
<div class="form-group">
  <label for="ONTWERP">Ontwerp</label>
  <input type="text" class="form-control" name="ONTWERP" value="<?php if(isset($result['ONTWERP'])) { echo $result['ONTWERP']; } ?>">
</div>
<div class="form-group">
  <label for="AFSCHERMING">Afscherming</label>
  <input type="text" class="form-control" name="AFSCHERMING" value="<?php if(isset($result['AFSCHERMING'])) { echo $result['AFSCHERMING']; } ?>">
</div>
<div class="form-group">
  <label for="INSTRUCTIE">Instructie</label>
  <input type="text" class="form-control" name="INSTRUCTIE" value="<?php if(isset($result['INSTRUCTIE'])) { echo $result['INSTRUCTIE']; } ?>">
</div>
<div class="form-group">
    <label for="FREQUENTIE">Frequentie</label>
    <input type="text" class="form-control" name="FREQUENTIE" value="<?php if(isset($result['FREQUENTIE'])) { echo $result['FREQUENTIE']; } ?>">
    <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4, 5</small>
</div>
<div class="form-group">
    <label for="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS">Mogelijkheid optreden gevaarlijke gebeurtenis</label>
    <input type="text" class="form-control" name="MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS" value="<?php if(isset($result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS'])) { echo $result['MOGELIJKHEID_OPTREDEN_GEVAARLIJKE_GEBEURTENIS']; } ?>">
    <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4, 5</small>
</div>
<div class="form-group">
    <label for="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE">Mogelijkheid voorkomen of beperken schade</label>
    <input type="text" class="form-control" name="MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE" value="<?php if(isset($result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE'])) { echo $result['MOGELIJKHEID_VOORKOMEN_OF_BEPERKEN_SCHADE']; } ?>">
    <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 3, 5</small>
</div>
<div class="form-group">
    <label for="ERNST_VAN_DE_GEVOLGEN">Ernst van de gevolgen</label>
    <input type="text" class="form-control" name="ERNST_VAN_DE_GEVOLGEN" value="<?php if(isset($result['ERNST_VAN_DE_GEVOLGEN'])) { echo $result['ERNST_VAN_DE_GEVOLGEN']; } ?>">
    <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 1, 2, 3, 4</small>
</div>
<div class="form-group">
    <label for="CI">CI</label>
    <input type="text" class="form-control" name="CI" value="<?php if(isset($result['CI'])) { echo $result['CI']; } ?>" disabled>
</div>
