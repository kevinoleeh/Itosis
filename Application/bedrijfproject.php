<?php
include_once("header.php");
?>
<div class="col-md-1">
</div>
<h1>Bedrijven en projecten beheren.</h1>
    <div class="col-md-12">
        <div class="col-md-6">
          <table class="table table-responsive  table-hover">
            <!--?php foreach ($balies as $balie) { ?> -->
            <tr onClick="goToBalie('<?= $balie->balienummer ?>')">
              <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
              <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
            </tr>
            <!--?php } ?> -->
          </table>
      </div>
      <div class="col-md-6">
        <table class="table table-responsive table-hover">
          <!--?php foreach ($balies as $balie) { ?> -->
          <tr onClick="goToBalie('<?= $balie->balienummer ?>')">
            <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
            <td ><b>Bedrijf<!--?= $balie->balienummer ?>--></b></td>
          </tr>
          <!--?php } ?> -->
        </table>
      </div>
    </div>


<form method="GET" id="bedrijfForm" action="Zoeken">
  <input type="hidden" id="inputBedrijf" name="bedrijf" />
</form>
<?php
include_once("footer.php");
?>