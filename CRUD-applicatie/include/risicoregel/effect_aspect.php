<?php

$rs = $dbh->query('SELECT ASPECTNAAM, EFFECTNAAM FROM ASPECT_EFFECT GROUP BY ASPECTNAAM, EFFECTNAAM ORDER BY ASPECTNAAM');
$effectaspecten = $rs->fetchAll();
global $effecten;
foreach ($effectaspecten as $row) {
    if(!isset($aspecten)){
        $effectrow = 0;
        $number = 0;
        $aspecten[$number] = $row[0];
        $aspectlast = $row[0];
    }
    $effecten[$number][$effectrow]= $row[1];
    if($aspectlast != $row[0]){
        $effectrow = 0;
        $number ++;
        $aspecten[$number] = $row[0];
        $aspectlast = $row[0];
    }
    else{
        $effectrow ++ 	;
    }
}
echo var_dump($aspecten);

?>
