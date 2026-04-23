<?php

namespace App\Models\Prestashop;

use Illuminate\Database\Eloquent\Model;

abstract class PrestashopModel extends Model
{
    protected $connection = 'prestashop';

    public $timestamps = false;

    protected static function booted(): void
    {
        static::saving(function () {
            throw new \RuntimeException(
                'Los modelos Prestashop son readonly por defecto. '
                .'Si necesitas escribir en ps_* o py_*, usa DB::connection(\'prestashop\') explícitamente.'
            );
        });

        static::deleting(function () {
            throw new \RuntimeException(
                'Los modelos Prestashop son readonly por defecto.'
            );
        });
    }
}
