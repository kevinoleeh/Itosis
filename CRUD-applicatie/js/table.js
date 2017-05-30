$("#table tbody tr").click(function(){
    $(this).addClass('info').siblings().removeClass('info');

    //dit is de waarde die gehaald wordt uit de geselecteerde row, in dit geval de eerste kolom; regelnummer
    var regelnummer=$(this).find('td:first').html();


    document.getElementById("regelopenenbutton").href = "risicoregel.php?projectnummer="+projectnummer+"&rapportnummer="+rapportnummer+"&regelnummer="+regelnummer;

});

