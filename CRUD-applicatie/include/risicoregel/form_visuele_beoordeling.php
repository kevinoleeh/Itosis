<h2>Visuele beoordeling</h2>
<div class="form-group">
    <label for="PROCES">Proces</label>
    <input type="text" class="form-control" name="PROCES" value="<?php if(isset($result['PROCES'])) { echo $result['PROCES']; } ?>">
</div>
<div class="form-group">
    <label for="AFDELING">Afdeling</label>
    <input type="text" class="form-control" name="AFDELING" value="<?php if(isset($result['AFDELING'])) { echo $result['AFDELING']; } ?>">
</div>
<div class="form-group">
    <label for="MACHINE_ONDERDEEL">Machine(onderdeel)</label>
    <input type="text" class="form-control" name="MACHINE_ONDERDEEL" value="<?php if(isset($result['MACHINE_ONDERDEEL_'])) { echo $result['MACHINE_ONDERDEEL_']; } ?>">
</div>