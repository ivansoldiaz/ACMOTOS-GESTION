<?php

namespace App\Services\Prestashop;

use Illuminate\Support\Facades\DB;

/**
 * Reemplazo de custom-scripts/redireccionar-productos-por-id-producto.php
 *
 * Para cada producto identificado (por id o por reference):
 *  1. Localiza id_category_default y los link_rewrite ES (1) y EN (3) del
 *     producto y de su categoría por defecto.
 *  2. Para cada idioma, INSERTA en ps_lgseoredirect una redirect 301
 *     /<lang>/<product_link_rewrite>  →  https://acmotos.com/<lang>/<category_link_rewrite>
 *     SI no existe ya una entrada con el mismo url_old para ese id_shop.
 *  3. Desactiva el producto en ps_product y ps_product_shop.
 *
 * Todo dentro de una transacción sobre la conexión 'prestashop'.
 */
class ProductRedirectService
{
    public const IDENTIFIER_ID = 'id';

    public const IDENTIFIER_REFERENCE = 'reference';

    public const REDIRECT_BASE_URL = 'https://acmotos.com';

    public const REDIRECT_TYPE = 301;

    /** @var array<int,string> */
    public const LANGUAGES = [
        LanguageService::LANG_ES => 'es',
        LanguageService::LANG_EN => 'en',
    ];

    /**
     * Divide un texto pegado por el usuario en items individuales.
     * Acepta separadores: comas, espacios, saltos de línea, tabs, punto y coma.
     * Mantiene el orden y deduplica preservando la primera aparición.
     *
     * @return array<int,string>
     */
    public function parseInput(string $raw): array
    {
        $normalized = preg_replace('/[\s,;]+/u', "\n", trim($raw));
        if ($normalized === null || $normalized === '') {
            return [];
        }

        $items = explode("\n", $normalized);
        $items = array_map('trim', $items);
        $items = array_filter($items, static fn (string $v): bool => $v !== '');

        // Dedup preservando orden
        return array_values(array_unique($items));
    }

    /**
     * Procesa el batch completo. Devuelve estructura con summary + details.
     *
     * @param  array<int,string>  $items  IDs (numéricos en string) o referencias.
     * @return array{
     *     summary: array{processed:int,redirects_created:int,redirects_skipped:int,products_deactivated:int,errors:int},
     *     details: array<int,array<string,mixed>>
     * }
     */
    public function process(string $identifierMode, array $items): array
    {
        $details = [];
        $summary = [
            'processed' => 0,
            'redirects_created' => 0,
            'redirects_skipped' => 0,
            'products_deactivated' => 0,
            'errors' => 0,
        ];

        DB::connection('prestashop')->transaction(function () use ($identifierMode, $items, &$details, &$summary): void {
            foreach ($items as $item) {
                $resolution = $this->resolveProductIds($identifierMode, $item);

                if ($resolution['error'] !== null) {
                    $details[] = [
                        'input' => $item,
                        'status' => 'error',
                        'message' => $resolution['error'],
                    ];
                    $summary['errors']++;

                    continue;
                }

                foreach ($resolution['ids'] as $idProduct) {
                    $result = $this->processSingleProduct($idProduct, $item);
                    $details[] = $result;
                    $summary['processed']++;
                    $summary['redirects_created'] += $result['redirects_created'];
                    $summary['redirects_skipped'] += $result['redirects_skipped'];
                    if ($result['deactivated']) {
                        $summary['products_deactivated']++;
                    }
                    if ($result['status'] === 'error') {
                        $summary['errors']++;
                    }
                }
            }
        });

        return [
            'summary' => $summary,
            'details' => $details,
        ];
    }

    /**
     * Resuelve el input crudo a uno o varios id_product.
     *
     * @return array{ids:array<int,int>,error:?string}
     */
    private function resolveProductIds(string $identifierMode, string $item): array
    {
        if ($identifierMode === self::IDENTIFIER_ID) {
            if (! ctype_digit($item)) {
                return ['ids' => [], 'error' => "ID inválido: \"{$item}\" no es un entero."];
            }

            return ['ids' => [(int) $item], 'error' => null];
        }

        // Reference
        $matches = DB::connection('prestashop')
            ->table('ps_product')
            ->where('reference', $item)
            ->pluck('id_product')
            ->all();

        if (count($matches) === 0) {
            return ['ids' => [], 'error' => "Referencia \"{$item}\" no encontrada en ps_product."];
        }

        if (count($matches) > 1) {
            $list = implode(', ', $matches);

            return [
                'ids' => [],
                'error' => "Referencia \"{$item}\" ambigua: matchea " . count($matches) . " productos (id_product: {$list}). Skip.",
            ];
        }

        return ['ids' => [(int) $matches[0]], 'error' => null];
    }

    /**
     * Procesa un único producto: crea redirects (skip si duplicado) y desactiva.
     *
     * @return array{
     *     input:string,
     *     id_product:int,
     *     status:string,
     *     redirects_created:int,
     *     redirects_skipped:int,
     *     deactivated:bool,
     *     messages:array<int,string>,
     * }
     */
    private function processSingleProduct(int $idProduct, string $rawInput): array
    {
        $messages = [];
        $redirectsCreated = 0;
        $redirectsSkipped = 0;
        $deactivated = false;

        $product = DB::connection('prestashop')
            ->table('ps_product')
            ->where('id_product', $idProduct)
            ->first(['id_product', 'id_category_default', 'reference']);

        if ($product === null) {
            return [
                'input' => $rawInput,
                'id_product' => $idProduct,
                'status' => 'error',
                'redirects_created' => 0,
                'redirects_skipped' => 0,
                'deactivated' => false,
                'messages' => ["Producto id_product={$idProduct} no existe en ps_product."],
            ];
        }

        $idCategoryDefault = (int) $product->id_category_default;

        $productLinks = DB::connection('prestashop')
            ->table('ps_product_lang')
            ->where('id_product', $idProduct)
            ->where('id_shop', LanguageService::ID_SHOP)
            ->whereIn('id_lang', array_keys(self::LANGUAGES))
            ->pluck('link_rewrite', 'id_lang')
            ->all();

        $categoryLinks = DB::connection('prestashop')
            ->table('ps_category_lang')
            ->where('id_category', $idCategoryDefault)
            ->where('id_shop', LanguageService::ID_SHOP)
            ->whereIn('id_lang', array_keys(self::LANGUAGES))
            ->pluck('link_rewrite', 'id_lang')
            ->all();

        // Verificar que tenemos los 4 link_rewrite (producto ES, producto EN, categoría ES, categoría EN)
        foreach (array_keys(self::LANGUAGES) as $idLang) {
            if (empty($productLinks[$idLang]) || empty($categoryLinks[$idLang])) {
                return [
                    'input' => $rawInput,
                    'id_product' => $idProduct,
                    'status' => 'error',
                    'redirects_created' => 0,
                    'redirects_skipped' => 0,
                    'deactivated' => false,
                    'messages' => [
                        "Falta link_rewrite del producto o de la categoría id_category_default={$idCategoryDefault} en id_lang={$idLang}. Skip.",
                    ],
                ];
            }
        }

        // Crear redirects (skip si ya existen)
        $now = now()->format('Y-m-d H:i:s');
        foreach (self::LANGUAGES as $idLang => $langCode) {
            $urlOld = '/' . $langCode . '/' . $productLinks[$idLang];
            $urlNew = self::REDIRECT_BASE_URL . '/' . $langCode . '/' . $categoryLinks[$idLang];

            $exists = DB::connection('prestashop')
                ->table('ps_lgseoredirect')
                ->where('url_old', $urlOld)
                ->where('id_shop', LanguageService::ID_SHOP)
                ->exists();

            if ($exists) {
                $redirectsSkipped++;
                $messages[] = "Redirect [{$langCode}] {$urlOld} ya existía → skip.";

                continue;
            }

            DB::connection('prestashop')
                ->table('ps_lgseoredirect')
                ->insert([
                    'url_old' => $urlOld,
                    'url_new' => $urlNew,
                    'redirect_type' => (string) self::REDIRECT_TYPE,
                    'update' => $now,
                    'id_shop' => LanguageService::ID_SHOP,
                ]);

            $redirectsCreated++;
            $messages[] = "Redirect [{$langCode}] {$urlOld} → {$urlNew} creada.";
        }

        // Desactivar producto (idempotente: si ya estaba inactivo, no pasa nada)
        $affectedProduct = DB::connection('prestashop')
            ->table('ps_product')
            ->where('id_product', $idProduct)
            ->update(['active' => 0]);

        $affectedShop = DB::connection('prestashop')
            ->table('ps_product_shop')
            ->where('id_product', $idProduct)
            ->where('id_shop', LanguageService::ID_SHOP)
            ->update(['active' => 0]);

        $deactivated = ($affectedProduct > 0) || ($affectedShop > 0);
        $messages[] = $deactivated
            ? "Producto id_product={$idProduct} desactivado en ps_product y ps_product_shop."
            : "Producto id_product={$idProduct} ya estaba inactivo, no requirió desactivación.";

        return [
            'input' => $rawInput,
            'id_product' => $idProduct,
            'status' => 'ok',
            'redirects_created' => $redirectsCreated,
            'redirects_skipped' => $redirectsSkipped,
            'deactivated' => $deactivated,
            'messages' => $messages,
        ];
    }
}
