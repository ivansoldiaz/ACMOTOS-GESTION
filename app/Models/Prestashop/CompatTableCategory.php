<?php

namespace App\Models\Prestashop;

use App\Services\Prestashop\LanguageService;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

/**
 * ps_ac_compat_tables_category
 *
 * Categorías que muestran el botón "Ver tabla de compatibilidad" en el
 * frontend del PrestaShop. FK -> ps_category con ON DELETE CASCADE.
 */
class CompatTableCategory extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'ps_ac_compat_tables_category';

    protected $primaryKey = 'id_compat_cat';

    protected $fillable = [
        'id_category',
    ];

    protected $casts = [
        'id_category' => 'integer',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['id_category'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    public function categoryLang(): HasOne
    {
        return $this->hasOne(CategoryLang::class, 'id_category', 'id_category')
            ->where('id_lang', LanguageService::LANG_ES)
            ->where('id_shop', LanguageService::ID_SHOP);
    }
}
