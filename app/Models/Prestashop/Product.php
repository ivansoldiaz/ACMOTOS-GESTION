<?php

namespace App\Models\Prestashop;

class Product extends PrestashopModel
{
    protected $table = 'ps_product';

    protected $primaryKey = 'id_product';

    public function langs()
    {
        return $this->hasMany(ProductLang::class, 'id_product', 'id_product');
    }

    public function category()
    {
        return $this->belongsTo(Category::class, 'id_category_default', 'id_category');
    }

    public function manufacturer()
    {
        return $this->belongsTo(Manufacturer::class, 'id_manufacturer', 'id_manufacturer');
    }
}
