<?php

namespace App\Models\Prestashop;

use Illuminate\Database\Eloquent\Model;

/**
 * Base model para tablas que viven en la DB de PrestaShop.
 *
 * Regla:
 * - Tablas custom ACMOTOS (ps_ac_*, py_*): CRUD completo desde Filament.
 * - Tablas nativas PS (ps_product, ps_order, etc.): NUNCA un Filament Resource.
 *   Escrituras solo desde App\Services\Prestashop\* con operaciones acotadas y logueadas.
 */
abstract class PrestashopModel extends Model
{
    protected $connection = 'prestashop';

    public $timestamps = false;
}
