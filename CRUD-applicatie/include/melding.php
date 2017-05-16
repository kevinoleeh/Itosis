<?php if (isset($meldingStatus)) { ?>
    <div class="alert <?php if ($meldingStatus) {
        echo "alert-success";
    } else {
        echo "alert-danger";
    } ?> alert-dismissable">
        <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
        <?= $melding ?>
    </div>
<?php } ?>