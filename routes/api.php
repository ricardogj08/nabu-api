<?php

/**
 * Registra todas las rutas y acciones de la aplicación.
 */
Flight::route('POST /v1/users', ['App\Controllers\UserController', 'store']);
Flight::route('GET /v1/posts', ['App\Controllers\PostController', 'index']);
Flight::route('POST /v1/posts', ['App\Controllers\PostController', 'store']);
Flight::route('GET /v1/posts/@slug', ['App\Controllers\PostController', 'show']);
Flight::route('PUT /v1/posts/@slug', ['App\Controllers\PostController', 'update']);
Flight::route('DELETE /v1/posts/@slug', ['App\Controllers\PostController', 'destroy']);
