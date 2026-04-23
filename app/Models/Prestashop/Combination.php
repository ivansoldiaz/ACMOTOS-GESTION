<?php

namespace App\Models\Prestashop;

class Combination extends PrestashopModel
{
    protected $table = 'ps_product_attribute';

    protected $primaryKey = 'id_product_attribute';

    public function product()
    {
        return $this->belongsTo(Product::class, 'id_product', 'id_product');
    }
}
