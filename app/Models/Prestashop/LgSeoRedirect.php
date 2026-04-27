<?php

namespace App\Models\Prestashop;

use App\Services\Prestashop\LanguageService;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

/**
 * Tabla del módulo lg_seo_redirect (no es PS core).
 *
 * Schema flat (id, url_old, url_new, redirect_type, update, id_shop) sin
 * hooks ni reindex ni multishop real. La admin del módulo edita esta tabla
 * directamente, así que un Resource Filament hace exactamente lo mismo.
 */
class LgSeoRedirect extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'ps_lgseoredirect';

    protected $primaryKey = 'id';

    /**
     * La columna 'update' es un nombre raro pero válido como atributo
     * Eloquent. PHP distingue $model->update (acceso a atributo) de
     * $model->update($attrs) (llamada al método heredado de Model::update),
     * así que no colisiona.
     */
    protected $fillable = [
        'url_old',
        'url_new',
        'redirect_type',
        'update',
        'id_shop',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['url_old', 'url_new', 'redirect_type', 'id_shop'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    protected static function booted(): void
    {
        static::saving(function (self $model): void {
            // Política del panel: todas las redirects creadas/editadas desde
            // gestion son 301. Si quisieras 302 en el futuro, descomenta el
            // campo en el form y quita esta línea.
            $model->redirect_type = '301';

            // Auto-rellenar columna 'update' como timestamp de última
            // modificación (lo que hace la admin del módulo).
            $model->update = now()->format('Y-m-d H:i:s');

            // id_shop por defecto si llega vacío
            if (empty($model->id_shop)) {
                $model->id_shop = LanguageService::ID_SHOP;
            }
        });
    }
}
