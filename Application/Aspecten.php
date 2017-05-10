<?php include_once('header.php') ?>
<div class="container">
    <div class="page-header">
        <h1>Aspecten</h1>
    </div>

    <div class="row">
        <div class="col-md-5">
            <input type="search" style="">
            <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
            <div class="row">

            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Aspect</th>
                        </tr>
                    </thead>

                    <?php
            for ($i = 1; $i <= 8; $i++) {
              // hier komt query zooi
            ?>
                        <tr>
                            <td class="numberwidth">
                                <?php echo $i; ?>
                            </td>
                            <td>Brandrisico</td>
                        </tr>
                        <?php } ?>
                </table>
            </div>
        </div>
        <div class="col-md-1">
        </div>
        <div class="col-md-5">
            <input type="search" style="">
            <button href="?new=1" class="btn btn-justified btn-right">Toevoegen</button>
            <div class="row">
            </div>
            <div class="row table-responsive">
                <table id="table" class="table table-striped table-bordered">
                    <thead>
                        <tr class="borderwhite">
                            <th>Nr.</th>
                            <th>Effect</th>
                        </tr>
                    </thead>

                    <?php
              // hier komt query zooi
            for ($i = 1; $i <= 8; $i++) {
                ?>

                        <tr>
                            <td class="numberwidth">
                                <?php echo $i; ?>
                            </td>
                            <td>Verbranding</td>
                        </tr>
                        <?php } ?>


                </table>
            </div>
        </div>
    </div>
</div>

<?php include_once('footer.php');?>
