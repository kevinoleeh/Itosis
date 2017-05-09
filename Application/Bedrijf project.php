<?php
include("header.php");

?>
<div class="navbar">
  
    </div>

        <h1>Bedrijven en projecten.</h2>
        <table class="table table-responsive  table-hover">
            <!--?php foreach ($balies as $balie) { ?> -->
            <tr onClick="goToBalie('<?= $balie->balienummer ?>')">
                <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
                <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
            </tr>
            <!--?php } ?> -->
        </table>


<form method="GET" id="bedrijfForm" action="Zoeken">
  <input type="hidden" id="inputBedrijf" name="bedrijf" />
</form>
