<?php

function getPrioriteitStyle($prioriteit) {
    switch ($prioriteit) {
        case 'P 1':
            return 'color: #ff0000;';
            break;
        case 'P 2':
            return 'color: #ff5500;';
            break;
        case 'P 3':
            return 'color: #ffa000;';
            break;
        case 'P 4':
            return 'color: #ffc800;';
            break;
        case 'P 5':
            return 'color: #00a000;';
            break;
    }

    return '';
}

?>