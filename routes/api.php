<?php

/**
 * Registra todas las rutas y acciones de la aplicación.
 */
Flight::route('GET /posts', ['App\Controllers\PostController', 'index']);
Flight::route('POST /posts', ['App\Controllers\PostController', 'store']);
Flight::route('GET /posts/@slug', ['App\Controllers\PostController', 'show']);
Flight::route('PUT /posts/@slug', ['App\Controllers\PostController', 'update']);
Flight::route('DELETE /posts/@slug', ['App\Controllers\PostController', 'destroy']);
