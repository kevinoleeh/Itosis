<?php
echo "<script type='text/javascript'>
$(document).ready(function () {
    $('#selectprod option').hide()
    var classN = $('#selectcat option:selected').attr('id');
    $('#selectprod option#' + classN).show();
    $('#selectcat').change(function () {
        $('#selectprod option').hide()
        $('#selectprod option:selected').removeAttr('selected');
        var classN = $('#selectcat option:selected').attr('id');
        $('#selectprod option#' + classN).show();
        $('#selectprod option#' + classN).attr('selected', 'selected');
    });
});
</script>";
?>
