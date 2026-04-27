<?php

namespace App\Models\Prestashop;

use App\Services\Prestashop\CompatCapitalizationService;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class CompatTableReplace extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'py_compat_tables_replaces';

    protected $primaryKey = 'id';

    protected $fillable = [
        'text_to_replace',
        'capitalized_text',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['text_to_replace', 'capitalized_text'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    protected static function booted(): void
    {
        // Si se guarda con capitalized_text vacío, autocompletar a partir
        // de text_to_replace (replicando el comportamiento del script legacy
        // tablas-compatibilidad-modelos-mayusculas.php).
        static::saving(function (self $model): void {
            if ($model->capitalized_text === null || trim((string) $model->capitalized_text) === '') {
                $model->capitalized_text = app(CompatCapitalizationService::class)
                    ->capitalize((string) $model->text_to_replace);
            }
        });
    }
}
