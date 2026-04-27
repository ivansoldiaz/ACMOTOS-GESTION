<?php

namespace App\Models\Prestashop;

use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

/**
 * py_compat_tables_equivalences
 *
 * "El producto id_product replica la compat de replicates_product_id."
 *
 * Se usa en PuigCompatTableUpdaterService: al asignar compat a un producto
 * canónico (replicates_product_id), las filas se copian también a todos
 * los id_product que apunten a él (productos sombra, p.ej. 20442N+9420V
 * que sigue a 20442N).
 */
class PuigCompatEquivalence extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'py_compat_tables_equivalences';

    protected $primaryKey = 'id';

    protected $fillable = [
        'id_product',
        'replicates_product_id',
    ];

    protected $casts = [
        'id_product' => 'integer',
        'replicates_product_id' => 'integer',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['id_product', 'replicates_product_id'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }
}
