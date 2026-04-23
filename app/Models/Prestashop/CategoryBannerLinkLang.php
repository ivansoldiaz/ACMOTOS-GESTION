<?php

namespace App\Models\Prestashop;

use Illuminate\Database\Eloquent\Relations\BelongsTo;

class CategoryBannerLinkLang extends PrestashopModel
{
    protected $table = 'ps_ac_category_banners_links_lang';

    protected $primaryKey = null;

    public $incrementing = false;

    protected $fillable = [
        'id_link',
        'id_lang',
        'anchor_text',
    ];

    protected $casts = [
        'id_link' => 'integer',
        'id_lang' => 'integer',
    ];

    public function link(): BelongsTo
    {
        return $this->belongsTo(CategoryBannerLink::class, 'id_link', 'id_link');
    }
}
