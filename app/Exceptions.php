<?php

/**
 * Personaliza mensajes de errores y excepciones.
 */

use PH7\JustHttp\StatusCode;

Flight::map(
    'error',
    static function ($exc, $code = StatusCode::INTERNAL_SERVER_ERROR) {
        $descr = 'Internal server error';

        if ($exc instanceof Respect\Validation\Exceptions\NestedValidationException) {
            $descr = $exc->getMessages();
        } elseif ($exc instanceof Exception) {
            $descr = [
                'exception' => $exc->getMessage(),
                'code'      => $exc->getCode(),
                'file'      => $exc->getFile(),
                'line'      => $exc->getLine(),
                'trace'     => $exc->getTrace(),
            ];
        }

        Flight::json(
            [
                'data'    => null,
                'message' => [
                    'type'        => 'error',
                    'code'        => $code,
                    'description' => $descr,
                ],
            ],
            $code
        );

        exit();
    }
);

Flight::map(
    'notFound',
    static function () {
        $code = StatusCode::NOT_FOUND;

        Flight::json(
            [
                'data'    => null,
                'message' => [
                    'type'        => 'error',
                    'code'        => $code,
                    'description' => 'Not found',
                ],
            ],
            $code
        );
    }
);
