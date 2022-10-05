<?php

require __DIR__ . '/../vendor/autoload.php';

PhpOrm\DB::config(__DIR__ . '/../config/database.php');

require __DIR__ . '/../app/Exceptions.php';
require __DIR__ . '/../routes/api.php';

/**
 * Inicia la ejecución del framework.
 */
Flight::start();
