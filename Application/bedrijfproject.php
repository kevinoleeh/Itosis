<?php
include("header.php");

?>
<div class="container">
    <div class="page-header">
        <h1>Bedrijven en projecten beheren.</h1>
    </div>
    <div class="col-md-5">
        <input type="search" style="">
        <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
        <div class="row">
        </div>
        <div class="row table-responsive">
            <table id="table" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Bedrijf</th>
                        <th>Locatie</th>
                    </tr>
                </thead>
                <tr>
                    <td>Bedrijf</td>
                    <td>Locatie
                        <span class="glyphicon glyphicon-remove widInTable"></span>
                        <span class="glyphicon glyphicon-pencil widInTable"></span>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div class="col-md-2">
    </div>
    <div class="col-md-5">
        <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
        <div class="row">
        </div>
        <div class="row table-responsive">
            <table id="table" class="table table-striped table-bordered">
                <thead>
                    <tr>
                        <th>Bedrijf</th>
                        <th>Locatie</th>
                    </tr>
                </thead>
                <tr>
                    <td>Bedrijf</td>
                    <td>Locatie</td>
                </tr>
                <tfoot>
                </tfoot>
            </table>
        </div>
    </div>
</div>

<form method="GET" id="bedrijfForm" action="Zoeken">
    <input type="hidden" id="inputBedrijf" name="bedrijf" />
</form>
