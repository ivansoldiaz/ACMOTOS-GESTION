<?php

namespace App\Models\Prestashop;

/**
 * ps_ac_compat_tables_product
 *
 * Una fila por (id_product, modelo de moto compatible). Una sola
 * referencia Puig genera N filas (una por moto en su tabla).
 *
 * Se escribe desde PuigCompatTableUpdaterService en bulk; no usamos
 * LogsActivity en este modelo porque el flujo escribe miles de filas por
 * batch — el log de la Page (con summary + details) ya cubre la trazabilidad.
 */
class CompatTableProduct extends PrestashopModel
{
    protected $table = 'ps_ac_compat_tables_product';

    protected $primaryKey = 'id_compat';

    protected $fillable = [
        'id_product',
        'brand',
        'model',
        'years',
        'searchable',
    ];

    protected $casts = [
        'id_product' => 'integer',
    ];
}
