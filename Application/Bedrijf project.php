<?php
$balies = $db->select('balie',['balienummer']);

?>
<head>
 <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
</head>
<div class="col-sm-"
<div class=" panel panel-primary">
    <div class="panel-heading">
        <h2 class="panel-title">Kies een bedrijf.</h2>
    </div>
  <div class="panel-body">
        <table class="table table-responsive table-hover">
            <!--<?php foreach ($balies as $balie) { ?> -->
            <tr onClick="goToBalie('<?= $balie->balienummer ?>')">
                <td ><b>Bedrijf<!--<?= $balie->balienummer ?>--></b></td>
            </tr>
            <!--<?php } ?> -->
        </table>
  </div>
</div>
<form method="GET" id="bedrijfForm" action="Zoeken">
  <input type="hidden" id="inputBedrijf" name="bedrijf" />
</form>
