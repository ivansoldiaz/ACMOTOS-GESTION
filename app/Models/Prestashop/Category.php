<?php

namespace App\Models\Prestashop;

class Category extends PrestashopModel
{
    protected $table = 'ps_category';

    protected $primaryKey = 'id_category';

    public function langs()
    {
        return $this->hasMany(CategoryLang::class, 'id_category', 'id_category');
    }
}
