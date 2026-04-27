<?php

namespace App\Models\Prestashop;

use App\Services\Prestashop\LanguageService;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Support\Facades\DB;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class CategoryBannerLink extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'ps_ac_category_banners_links';

    protected $primaryKey = 'id_link';

    protected $fillable = [
        'id_config',
        'id_target_category',
        'position',
    ];

    protected $casts = [
        'id_config' => 'integer',
        'id_target_category' => 'integer',
        'position' => 'integer',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['id_config', 'id_target_category', 'position'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    public function config(): BelongsTo
    {
        return $this->belongsTo(CategoryBannerConfig::class, 'id_config', 'id_config');
    }

    public function targetCategory(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'id_target_category', 'id_category');
    }

    public function targetCategoryLang(): HasOne
    {
        return $this->hasOne(CategoryLang::class, 'id_category', 'id_target_category')
            ->where('id_lang', LanguageService::LANG_ES);
    }

    public function langs(): HasMany
    {
        return $this->hasMany(CategoryBannerLinkLang::class, 'id_link', 'id_link');
    }

    public function getAnchorTextEsAttribute(): ?string
    {
        return $this->langs->firstWhere('id_lang', LanguageService::LANG_ES)?->anchor_text;
    }

    public function getAnchorTextEnAttribute(): ?string
    {
        return $this->langs->firstWhere('id_lang', LanguageService::LANG_EN)?->anchor_text;
    }

    public function setAnchorTextForLang(int $idLang, ?string $text): void
    {
        // La tabla _lang tiene PK compuesta (id_link, id_lang), sin auto_increment.
        // Eloquent::save() con $primaryKey=null genera un UPDATE con WHERE roto,
        // así que bajamos al query builder para tener el WHERE correcto.
        \Illuminate\Support\Facades\DB::connection('prestashop')
            ->table('ps_ac_category_banners_links_lang')
            ->updateOrInsert(
                ['id_link' => $this->getKey(), 'id_lang' => $idLang],
                ['anchor_text' => $text ?? ''],
            );
    }
}
