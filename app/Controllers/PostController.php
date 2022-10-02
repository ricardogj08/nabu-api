<?php

namespace App\Controllers;

use Flight;
use PH7\JustHttp\StatusCode;

class PostController
{
    public static function index()
    {
        Flight::json([
            'message' => [
                'type' => 'success',
                'code' => StatusCode::OK,
                'description' => 'Posts list.',
            ],
        ]);
    }

    public static function store()
    {
        Flight::json([
            'message' => [
                'type' => 'success',
                'code' => StatusCode::CREATED,
                'description' => 'Post registered.',
            ],
        ]);
    }

    public static function show($slug)
    {
        Flight::json([
            'data' => [
                'slug' => $slug,
            ],
            'message' => [
                'type' => 'success',
                'code' => StatusCode::OK,
                'description' => 'Show post.',
            ],
        ]);
    }

    public static function update($slug)
    {
        Flight::json([
            'data' => [
                'slug' => $slug,
            ],
            'message' => [
                'type' => 'success',
                'code' => StatusCode::OK,
                'description' => 'Post updated.',
            ],
        ]);
    }

    public static function destroy($slug)
    {
        Flight::json([
            'data' => [
                'slug' => $slug,
            ],
            'message' => [
                'type' => 'success',
                'code' => StatusCode::OK,
                'description' => 'Post deleted.',
            ],
        ]);
    }
}
