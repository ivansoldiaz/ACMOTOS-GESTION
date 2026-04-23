<?php

namespace App\Models\Prestashop;

use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Spatie\Activitylog\LogOptions;
use Spatie\Activitylog\Traits\LogsActivity;

class CategoryBannerConfig extends PrestashopModel
{
    use LogsActivity;

    protected $table = 'ps_ac_category_banners_config';

    protected $primaryKey = 'id_config';

    protected $fillable = [
        'id_category',
        'template',
    ];

    public function getActivitylogOptions(): LogOptions
    {
        return LogOptions::defaults()
            ->logOnly(['id_category', 'template'])
            ->logOnlyDirty()
            ->dontSubmitEmptyLogs();
    }

    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'id_category', 'id_category');
    }

    public function links(): HasMany
    {
        return $this->hasMany(CategoryBannerLink::class, 'id_config', 'id_config')
            ->orderBy('position');
    }
}
