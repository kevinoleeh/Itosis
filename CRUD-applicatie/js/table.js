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
$("#table tbody tr").click(function(){
    $(this).addClass('info').siblings().removeClass('info');

    //dit is de waarde die gehaald wordt uit de geselecteerde row, in dit geval de eerste kolom; regelnummer
    var regelnummer=$(this).find('td:first').html();


    document.getElementById("regelopenenbutton").href = "regels_redirect.php?projectnummer="+projectnummer+"&rapportnummer="+rapportnummer+"&regelnummer="+regelnummer;

});
