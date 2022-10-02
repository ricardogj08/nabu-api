<?php

require __DIR__.'/../vendor/autoload.php';

require __DIR__.'/../routes/api.php';

PhpOrm\DB::config(__DIR__.'/../config/database.php');

/**
 * Inicia la ejecución del framework.
 */
Flight::start();
