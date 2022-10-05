<?php

namespace App\Controllers;

use Flight;
use PH7\JustHttp\StatusCode;
use Respect\Validation\Exceptions\NestedValidationException;
use Respect\Validation\Validator as v;

class UserController
{
    public static function store()
    {
        $data = Flight::request()->data;

        try {
            v::attribute('username')
                ->attribute('email')
                ->attribute('password')
                ->assert($data);
        } catch (NestedValidationException $exc) {
            Flight::error($exc, StatusCode::BAD_REQUEST);
        }

        Flight::json(
            [
                'data'    => $data,
                'message' => [
                    'type'        => 'success',
                    'code'        => StatusCode::CREATED,
                    'description' => 'Registered user',
                ],
            ]
        );
    }
}
