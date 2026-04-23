<?php

namespace App\Models\Prestashop;

class ProductLang extends PrestashopModel
{
    protected $table = 'ps_product_lang';

    protected $primaryKey = null;

    public $incrementing = false;

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product', 'id_product');
    }
}
