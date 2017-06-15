<h2>Risicoregel</h2>
<div class="form-group">
    <label for="ARBO_ONDERWERP">Arbo onderwerp</label>
    <input type="text" class="form-control" name="ARBO_ONDERWERP"
           value="<?php if (isset($result['ARBO_ONDERWERP'])) {
               echo $result['ARBO_ONDERWERP'];
           } ?>">
</div>
<div class="form-group">
    <label for="ASPECT">Aspect</label>
    <select class="form-control" name="ASPECTNAAM" id="selectcat">
        <?php for ($i = 0; $i < sizeof($aspecten); $i++) {
            echo "<option id='$i' value='$aspecten[$i]'";
            if (isset($result['ASPECTNAAM']) && $aspecten[$i] == $result['ASPECTNAAM']) {
                $id = $i;
                echo "selected";
            }
            echo ">" . $aspecten[$i] . "</option>";
        } ?>
    </select>
</div>
<div class="form-group">
    <label for="EFFECT">Effect</label>
    <select class="form-control" name="EFFECTNAAM" id="selectprod">
        <?php
        for ($i = 0; $i < sizeof($effecten); $i++) {
            for ($j = 0; $j < sizeof($effecten[$i]); $j++) {
                echo "<option value='" . $effecten[$i][$j] . "' id='$i' ";
                if (isset($result['EFFECTNAAM']) && $effecten[$i][$j] == $result['EFFECTNAAM']) {
                    echo "selected";
                }
                echo ">" . $effecten[$i][$j] . "</option>";
            }
        } ?>
    </select>
</div>
<div class="form-group">
    <label for="RISICO_OMSCHRIJVING_OF_BEVINDING">Risico omschrijving of bevinding</label>
    <textarea class="form-control" rows="2"
              name="RISICO_OMSCHRIJVING_OF_BEVINDING"><?php if (isset($result['RISICO_OMSCHRIJVING_OF_BEVINDING'])) {
            echo $result['RISICO_OMSCHRIJVING_OF_BEVINDING'];
        } ?></textarea>
</div>
<div class="form-group">
    <label for="HUIDIGE_BEHEERSMAATREGEL">Huidige beheersmaatregel</label>
    <textarea class="form-control" rows="2"
              name="HUIDIGE_BEHEERSMAATREGEL"><?php if (isset($result['HUIDIGE_BEHEERSMAATREGEL'])) {
            echo $result['HUIDIGE_BEHEERSMAATREGEL'];
        } ?></textarea>
</div>
<h3>Risico voor maatregelen</h3>
<div class="form-group">
    <label for="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL">Voorgestelde actie ter uitvoering</label>
    <textarea class="form-control" rows="2"
              name="VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL"><?php if (isset($result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'])) {
            echo $result['VOORGESTELDE_ACTIE_OF_VERBETERINGSMAATREGEL'];
        } ?></textarea>
</div>
<h4>Fine en Kinney</h4>
<div class="form-group">
    <label for="VOOR_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
    <input type="text" class="form-control" name="VOOR_ERNST_VAN_ONGEVAL"
           value="<?php if (isset($result['VOOR_ERNST_VAN_ONGEVAL'])) {
               echo $result['VOOR_ERNST_VAN_ONGEVAL'];
           } ?>">
    <small id="VOOR_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
</div>
<div class="form-group">
    <label for="VOOR_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
    <input type="text" class="form-control" name="VOOR_KANS_OP_BLOOTSTELLING"
           value="<?php if (isset($result['VOOR_KANS_OP_BLOOTSTELLING'])) {
               echo $result['VOOR_KANS_OP_BLOOTSTELLING'];
           } ?>">
    <small id="VOOR_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0.5</small>
</div>
<div class="form-group">
    <label for="VOOR_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
    <input type="text" class="form-control" name="VOOR_KANS_OP_WAARSCHIJNLIJKHEID"
           value="<?php if (isset($result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'])) {
               echo $result['VOOR_KANS_OP_WAARSCHIJNLIJKHEID'];
           } ?>">
    <small id="VOOR_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2
    </small>
</div>
<div class="form-group">
    <label>Risico</label>
    <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($result['VOOR_PRIORITEIT']); } ?>" value="<?php if (isset($result['VOOR_RISICO'])) { echo $result['VOOR_RISICO']; } ?>" disabled>
    <small class="form-text text-muted">Automatisch berekend</small>
</div>
<div class="form-group">
    <label>Prioriteit</label>
    <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($result['VOOR_PRIORITEIT']); } ?>" value="<?php if (isset($result['VOOR_PRIORITEIT'])) { echo $result['VOOR_PRIORITEIT']; } ?>" disabled>
    <small class="form-text text-muted">Automatisch berekend</small>
</div>
<h3>Risico na maatregelen</h3>
<h4>Fine en Kinney</h4>
<div class="form-group">
    <label for="NA_ERNST_VAN_ONGEVAL">Ernst van ongeval</label>
    <input type="text" class="form-control" name="NA_ERNST_VAN_ONGEVAL"
           value="<?php if (isset($result['NA_ERNST_VAN_ONGEVAL'])) {
               echo $result['NA_ERNST_VAN_ONGEVAL'];
           } ?>">
    <small id="NA_ERNST_VAN_ONGEVAL" class="form-text text-muted">Keuze uit 100, 40, 15, 7, 3 of 1</small>
</div>
<div class="form-group">
    <label for="NA_KANS_OP_BLOOTSTELLING">Kans op blootstelling</label>
    <input type="text" class="form-control" name="NA_KANS_OP_BLOOTSTELLING"
           value="<?php if (isset($result['NA_KANS_OP_BLOOTSTELLING'])) {
               echo $result['NA_KANS_OP_BLOOTSTELLING'];
           } ?>">
    <small id="NA_KANS_OP_BLOOTSTELLING" class="form-text text-muted">Keuze uit 10, 6, 3, 2, 1 of 0,5</small>
</div>
<div class="form-group">
    <label for="NA_KANS_OP_WAARSCHIJNLIJKHEID">Kans op waarschijnlijkheid</label>
    <input type="text" class="form-control" name="NA_KANS_OP_WAARSCHIJNLIJKHEID"
           value="<?php if (isset($result['NA_KANS_OP_WAARSCHIJNLIJKHEID'])) {
               echo $result['NA_KANS_OP_WAARSCHIJNLIJKHEID'];
           } ?>">
    <small id="NA_KANS_OP_WAARSCHIJNLIJKHEID" class="form-text text-muted">Keuze uit 10, 6, 3, 1, 0.5 of 0.2
    </small>
</div>
<div class="form-group">
    <label>Risico</label>
    <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($result['NA_PRIORITEIT']); } ?>" value="<?php if (isset($result['NA_RISICO'])) { echo $result['NA_RISICO']; } ?>" disabled>
    <small class="form-text text-muted">Automatisch berekend</small>
</div>
<div class="form-group">
    <label>Prioriteit</label>
    <input type="text" class="form-control" style="<?php if (isset($result['VOOR_PRIORITEIT'])) { echo getPrioriteitStyle($result['NA_PRIORITEIT']); } ?>" value="<?php if (isset($result['NA_PRIORITEIT'])) { echo $result['NA_PRIORITEIT']; } ?>" disabled>
    <small class="form-text text-muted">Automatisch berekend</small>
</div>
<div class="form-group">
    <label for="AFWIJKENDE_ACTIE_TER_UITVOERING">Afwijkende actie ter uitvoering</label>
    <textarea class="form-control" rows="2"
              name="AFWIJKENDE_ACTIE_TER_UITVOERING"><?php if (isset($result['AFWIJKENDE_ACTIE_TER_UITVOERING'])) {
            echo $result['AFWIJKENDE_ACTIE_TER_UITVOERING'];
        } ?></textarea>
</div>
<div class="form-group">
    <label for="RESTRISICO">Rest risico</label>
    <textarea class="form-control" rows="2" name="RESTRISICO"><?php if (isset($result['RESTRISICO'])) {
            echo $result['RESTRISICO'];
        } ?></textarea>
</div>