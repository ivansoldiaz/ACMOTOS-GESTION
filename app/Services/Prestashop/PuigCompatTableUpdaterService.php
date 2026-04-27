<?php

namespace App\Services\Prestashop;

use App\Models\Prestashop\CompatTableReplace;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\DB;

/**
 * Reemplazo de custom-scripts/puig-compat-table-updater.php
 *
 * Para cada referencia canónica de Puig:
 *  1. Busca filas (Marca/Modelo/Years) en py_puig_compat_tables.
 *  2. Resuelve los id_product en ps_product que tienen esa reference.
 *  3. Aplica el diccionario py_compat_tables_replaces (vía preg_replace
 *     con \b...\b/i) para capitalizar Marca y Modelo.
 *  4. Calcula el campo searchable = lowercase(brand+model) sin
 *     espacios/guiones/underscores.
 *  5. Para cada producto canónico, busca productos sombra en
 *     py_compat_tables_equivalences (replicates_product_id = canónico).
 *  6. Dentro de una transacción:
 *     a. DELETE FROM ps_ac_compat_tables_product las filas previas de
 *        TODOS los productos afectados (canónicos + sombras). Esto es un
 *        fix frente al script viejo, que solo borraba las de canónicos
 *        y dejaba las sombras acumuladas como duplicados.
 *     b. INSERT en bulk de las nuevas filas (canónicos + sombras
 *        replicadas), troceado para no reventar max_allowed_packet.
 */
class PuigCompatTableUpdaterService
{
    /**
     * Tamaño de chunk para los INSERTs en bulk. Cada fila pesa pocos
     * cientos de bytes, así que 500 está muy lejos del límite por defecto
     * de max_allowed_packet (16-64 MB en MariaDB).
     */
    private const INSERT_CHUNK_SIZE = 500;

    /**
     * Divide un texto pegado en items individuales.
     * Acepta separadores: comas, espacios, saltos de línea, tabs y ;.
     *
     * @return array<int,string>
     */
    public function parseInput(string $raw): array
    {
        $normalized = preg_replace('/[\s,;]+/u', "\n", trim($raw));
        if ($normalized === null || $normalized === '') {
            return [];
        }

        $items = array_map('trim', explode("\n", $normalized));
        $items = array_filter($items, static fn (string $v): bool => $v !== '');

        return array_values(array_unique($items));
    }

    /**
     * Procesa el batch completo.
     *
     * @param  array<int,string>  $references
     * @return array{
     *     summary: array{
     *         input_count:int,
     *         refs_found_in_puig:int,
     *         refs_not_in_puig:int,
     *         refs_not_in_product:int,
     *         canonicals_updated:int,
     *         shadows_propagated:int,
     *         compat_rows_inserted:int,
     *     },
     *     details: array<int,array<string,mixed>>
     * }
     */
    public function process(array $references): array
    {
        $details = [];
        $summary = [
            'input_count' => count($references),
            'refs_found_in_puig' => 0,
            'refs_not_in_puig' => 0,
            'refs_not_in_product' => 0,
            'canonicals_updated' => 0,
            'shadows_propagated' => 0,
            'compat_rows_inserted' => 0,
        ];

        if ($references === []) {
            return ['summary' => $summary, 'details' => $details];
        }

        DB::connection('prestashop')->transaction(function () use ($references, &$details, &$summary): void {
            $dictionary = $this->loadDictionary();

            // 1. Cargar filas Puig agrupadas por Referencia
            $puigRowsByRef = DB::connection('prestashop')
                ->table('py_puig_compat_tables')
                ->whereIn('Referencia', $references)
                ->get(['Referencia', 'Marca', 'Modelo', 'Years'])
                ->groupBy('Referencia');

            // 2. Resolver id_product de ps_product agrupados por reference
            $productsByRef = DB::connection('prestashop')
                ->table('ps_product')
                ->whereIn('reference', $references)
                ->get(['id_product', 'reference'])
                ->groupBy('reference');

            // 3. Recolectar todos los id canónicos
            $canonicalIds = [];
            foreach ($productsByRef as $ref => $products) {
                foreach ($products as $p) {
                    $canonicalIds[] = (int) $p->id_product;
                }
            }
            $canonicalIds = array_values(array_unique($canonicalIds));

            // 4. Buscar sombras (productos que replican de los canónicos)
            $shadowsByCanonical = [];
            if ($canonicalIds !== []) {
                DB::connection('prestashop')
                    ->table('py_compat_tables_equivalences')
                    ->whereIn('replicates_product_id', $canonicalIds)
                    ->get(['id_product', 'replicates_product_id'])
                    ->each(function ($row) use (&$shadowsByCanonical): void {
                        $canonical = (int) $row->replicates_product_id;
                        $shadow = (int) $row->id_product;
                        $shadowsByCanonical[$canonical][] = $shadow;
                    });
            }

            $allShadowIds = Arr::flatten($shadowsByCanonical);
            $allAffectedIds = array_values(array_unique(array_merge($canonicalIds, $allShadowIds)));

            // 5. DELETE limpio (canónicos + sombras): fix del bug del legacy
            //    que dejaba duplicados acumulados en sombras
            if ($allAffectedIds !== []) {
                DB::connection('prestashop')
                    ->table('ps_ac_compat_tables_product')
                    ->whereIn('id_product', $allAffectedIds)
                    ->delete();
            }

            // 6. Construir filas a insertar
            $rowsToInsert = [];

            foreach ($references as $ref) {
                $puigRows = $puigRowsByRef->get($ref);
                $products = $productsByRef->get($ref);

                if ($puigRows === null || $puigRows->isEmpty()) {
                    $details[] = [
                        'reference' => $ref,
                        'status' => 'not_in_puig',
                        'message' => "Referencia \"{$ref}\" no encontrada en py_puig_compat_tables.",
                    ];
                    $summary['refs_not_in_puig']++;

                    continue;
                }

                $summary['refs_found_in_puig']++;

                if ($products === null || $products->isEmpty()) {
                    $details[] = [
                        'reference' => $ref,
                        'status' => 'not_in_product',
                        'message' => "Referencia \"{$ref}\" no encontrada en ps_product.",
                        'puig_rows_count' => $puigRows->count(),
                    ];
                    $summary['refs_not_in_product']++;

                    continue;
                }

                $canonicalsForRef = [];
                $shadowsForRef = [];
                $rowsForRef = 0;

                foreach ($products as $product) {
                    $idCanonical = (int) $product->id_product;
                    $canonicalsForRef[] = $idCanonical;
                    $shadowsForCanonical = $shadowsByCanonical[$idCanonical] ?? [];
                    foreach ($shadowsForCanonical as $sid) {
                        $shadowsForRef[] = $sid;
                    }

                    foreach ($puigRows as $puigRow) {
                        $brand = $this->applyDictionary((string) $puigRow->Marca, $dictionary);
                        $model = $this->applyDictionary((string) $puigRow->Modelo, $dictionary);
                        $years = (string) ($puigRow->Years ?? '');
                        $searchable = $this->buildSearchable($brand, $model);

                        // Canonical
                        $rowsToInsert[] = [
                            'id_product' => $idCanonical,
                            'brand' => $brand,
                            'model' => $model,
                            'years' => $years,
                            'searchable' => $searchable,
                        ];
                        $rowsForRef++;

                        // Shadows
                        foreach ($shadowsForCanonical as $idShadow) {
                            $rowsToInsert[] = [
                                'id_product' => $idShadow,
                                'brand' => $brand,
                                'model' => $model,
                                'years' => $years,
                                'searchable' => $searchable,
                            ];
                            $rowsForRef++;
                        }
                    }

                    $summary['canonicals_updated']++;
                }

                $summary['shadows_propagated'] += count(array_unique($shadowsForRef));

                $details[] = [
                    'reference' => $ref,
                    'status' => 'ok',
                    'message' => sprintf(
                        '%d filas compat × %d productos canónicos × (1 + %d sombras).',
                        $puigRows->count(),
                        count($canonicalsForRef),
                        count(array_unique($shadowsForRef)),
                    ),
                    'puig_rows_count' => $puigRows->count(),
                    'canonical_ids' => array_values(array_unique($canonicalsForRef)),
                    'shadow_ids' => array_values(array_unique($shadowsForRef)),
                    'rows_inserted' => $rowsForRef,
                ];
            }

            // 7. Bulk INSERT troceado
            foreach (array_chunk($rowsToInsert, self::INSERT_CHUNK_SIZE) as $chunk) {
                DB::connection('prestashop')
                    ->table('ps_ac_compat_tables_product')
                    ->insert($chunk);
            }

            $summary['compat_rows_inserted'] = count($rowsToInsert);
        });

        return ['summary' => $summary, 'details' => $details];
    }

    /**
     * Carga el diccionario py_compat_tables_replaces como patrones regex.
     *
     * @return array{patterns:array<int,string>,replaces:array<int,string>}
     */
    private function loadDictionary(): array
    {
        $patterns = [];
        $replaces = [];

        foreach (CompatTableReplace::query()->get(['text_to_replace', 'capitalized_text']) as $row) {
            $escaped = preg_quote((string) $row->text_to_replace, '/');
            $patterns[] = '/\b' . $escaped . '\b/i';
            $replaces[] = (string) $row->capitalized_text;
        }

        return ['patterns' => $patterns, 'replaces' => $replaces];
    }

    /**
     * @param  array{patterns:array<int,string>,replaces:array<int,string>}  $dictionary
     */
    private function applyDictionary(string $text, array $dictionary): string
    {
        if ($dictionary['patterns'] === []) {
            return $text;
        }

        return (string) preg_replace($dictionary['patterns'], $dictionary['replaces'], $text);
    }

    /**
     * Replica buildSearchable() del script legacy: brand+model en
     * minúscula, sin espacios, guiones ni underscores.
     */
    private function buildSearchable(string $brand, string $model): string
    {
        return str_replace(
            [' ', '-', '_'],
            '',
            mb_strtolower($brand . $model, 'UTF-8'),
        );
    }
}
