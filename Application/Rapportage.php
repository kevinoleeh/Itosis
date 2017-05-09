<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Euratex</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>

    <![endif]-->
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                    data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Euratex</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li><a href="#">Bedrijven</a></li>
                <li><a href="#">Aspecten</a></li>
                <li><a href="#">Beheer</a></li>
            </ul>

            <!--      <ul class="nav navbar-nav navbar-right">-->
            <!--        <li><a href="#">Link</a></li>-->
            <!--        <li class="dropdown">-->
            <!--          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Dropdown <span class="caret"></span></a>-->
            <!--          <ul class="dropdown-menu">-->
            <!--            <li><a href="#">Action</a></li>-->
            <!--            <li><a href="#">Another action</a></li>-->
            <!--            <li><a href="#">Something else here</a></li>-->
            <!--            <li role="separator" class="divider"></li>-->
            <!--            <li><a href="#">Separated link</a></li>-->
            <!--          </ul>-->
            <!--        </li>-->
            <!--      </ul>-->
        </div><!-- /.navbar-collapse -->
    </div><!-- /.container-fluid -->
</nav>

<div class="container">

    <div class="page-header">
        <h1>Rapportage</h1>
    </div>

    <div class="row">
        <div class="col-md-3">
            <div class="input-group">
                <span class="input-group-addon">Projectnr.</span>
                <input type="text" class="form-control" placeholder="1" aria-describedby="basic-addon1">
            </div>
        </div>
        <div class="col-md-4">
            <div class="input-group">
                <span class="input-group-addon">Projectomschrijving</span>
                <input type="text" class="form-control" placeholder="Username" aria-describedby="basic-addon1">
            </div>
        </div>
        <div class="col-md-4 pull right">
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
</div>

<footer class="footer navbar-fixed-bottom">
    <div class="container">
        <p class="text-muted">© Euratex 2017</p>
    </div>
</footer>


<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="js/bootstrap.min.js"></script>
</body>
</html>