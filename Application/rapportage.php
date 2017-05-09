<?php include_once('header.php') ?>

    <div class="page-header">
        <h1>Rapportage</h1>
    </div>

    <div class="row">
        <div class=" col-sm-2 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">Projectnr.</span>
                <input type="text" class="form-control" placeholder="1" aria-describedby="basic-addon1" disabled>
            </div>
        </div>
        <div class=" col-sm-2 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">Projectomschrijving</span>
                <input type="text" class="form-control" placeholder="Inspectie HAN" aria-describedby="basic-addon1">
            </div>
        </div>
        <div class="col-sm-2 col-md-4 pull right">
            <div class="input-group">
                <span class="input-group-addon">Projecttemplate</span>
                <select class="form-control">
                    <option>Visuele beoordeling</option>
                    <option>RIE</option>
                    <option>HAZOP</option>
                    <option>Atex</option>
                </select>

            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col-md-6">
            <div class="btn-group btn-group-justified" role="group" aria-label="...">
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-default">Regel toevoegen</button>
                </div>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-default">PvA toevoegen</button>
                </div>
                <div class="btn-group" role="group">
                    <button type="button" class="btn btn-default">F&K toevoegen</button>
                </div>
            </div>
        </div>
    </div>


    <hr>

    <div class="row table-responsive">
        <table id="table" class="table table-striped table-bordered">
            <thead>
            <tr>
                <th>Regelnummer</th>
                <th>Aspect</th>
                <th>Effect</th>
                <th>Proces</th>
                <th>Machineonderdeel</th>
                <th>Huidige beheersmaatregel</th>
                <th>Voorgestelde actie/maatregel</th>
                <th>Afwijkende actie ter uitvoering</th>
                <th>Rest Risico</th>
            </tr>
            </thead>

            <?php
            //even als dummydata 8 rows geprint
            for ($i = 1; $i <= 8; $i++) {
                ?>
                <tr>
                    <td><?php echo $i; ?></td>
                    <td>Arbobeleid</td>
                    <td>Risicobeheersing</td>
                    <td>-</td>
                    <td>-</td>
                    <td>Geen bijzonderheden</td>
                    <td>Stel Arbobeleid op</td>
                    <td>n.v.t.</td>
                    <td>Geen</td>
                </tr>
            <?php } ?>

            <tfoot>
            <tr>
                <th>Regelnummer</th>
                <th>Aspect</th>
                <th>Effect</th>
                <th>Proces</th>
                <th>Machineonderdeel</th>
                <th>Huidige beheersmaatregel</th>
                <th>Voorgestelde actie/maatregel</th>
                <th>Afwijkende actie ter uitvoering</th>
                <th>Rest Risico</th>
            </tr>
            </tfoot>
        </table>
    </div>
    <div class="row">
        <ul class="pagination">
            <li class="active"><a href="#">1</a></li>
            <li><a href="#">2</a></li>
            <li><a href="#">3</a></li>
            <li><a href="#">4</a></li>
            <li><a href="#">5</a></li>
        </ul>
    </div>

<?php include_once('footer.php');