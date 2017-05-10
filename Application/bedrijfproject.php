<?php
include("header.php");

?>
<div class="container">
    <div class="page-header">
        <h1>Bedrijven en projecten beheren.</h1>
    </div>
    <div class="col-md-5">
        <input type="search" style="" value="vul een bedrijfsnaam in.">
        <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
        <div class="row">
        </div>
        <div class="row table-responsive">
            <table id="table" class="table table-striped table-bordered marginTop">
                <thead>
                    <tr>
                        <th>Bedrijf</th>
                        <th>Locatie</th>
                    </tr>
                </thead>
                <tr>
                    <td>Bedrijf</td>
                    <td>Locatie
                        <a href="?remove=1"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                        <a href="?edit=1"><span class="glyphicon glyphicon-pencil widintable"></span></a>
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
            <table id="table" class="table table-striped table-bordered marginTop">
                <thead>
                    <tr>
                        <th>Project</th>
                        <th>Omschrijving</th>
                    </tr>
                </thead>
                <tr>
                    <td>Project 1</td>
                    <td>Omschrijving 1
                        <a href="?remove=1"><span class="glyphicon glyphicon-remove widintable red"></span></a>
                        <a href="?edit=1"><span class="glyphicon glyphicon-pencil widintable"></span></a>
                    </td>
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
