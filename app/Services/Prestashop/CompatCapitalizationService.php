<?php

namespace App\Services\Prestashop;

use App\Models\Prestashop\CompatTableReplace;

class CompatCapitalizationService
{
    /**
     * Capitaliza un texto en estilo "Title Case" respetando UTF-8.
     *
     * Reemplaza al ucwords(strtolower()) del script PHP legacy
     * (que no manejaba multibyte y dejaba mayúsculas en Ñ/Á/É/...).
     */
    public function capitalize(string $text): string
    {
        return mb_convert_case(mb_strtolower($text, 'UTF-8'), MB_CASE_TITLE, 'UTF-8');
    }

    /**
     * Devuelve el diccionario [text_to_replace => capitalized_text]
     * ordenado por LENGTH(text_to_replace) DESC, para que las entradas
     * multi-palabra ganen la sustitución sobre las simples
     * (p.ej. "TIGER 850 SPORT" antes que "TIGER" suelto).
     */
    public function getDictionarySorted(): array
    {
        return CompatTableReplace::query()
            ->orderByRaw('LENGTH(text_to_replace) DESC')
            ->pluck('capitalized_text', 'text_to_replace')
            ->all();
    }

    /**
     * Aplica el diccionario a un TSV pegado desde Excel/Sheets.
     *
     * - Normaliza saltos de línea a \n.
     * - Si la primera línea contiene "marca" o "modelo" (case-insensitive),
     *   se preserva tal cual como cabecera.
     * - Cada celda separada por TAB se sustituye independientemente.
     * - Devuelve un TSV con saltos de línea \r\n (igual que el script viejo).
     */
    public function applyToTsv(string $rawInput): string
    {
        $dictionary = $this->getDictionarySorted();
        $search = array_keys($dictionary);
        $replace = array_values($dictionary);

        $normalized = str_replace(["\r\n", "\r"], "\n", $rawInput);
        $lines = explode("\n", trim($normalized));

        $outputRows = [];
        $first = true;

        foreach ($lines as $line) {
            if (trim($line) === '') {
                continue;
            }

            if ($first) {
                $first = false;
                $lower = mb_strtolower($line, 'UTF-8');
                if (str_contains($lower, 'marca') || str_contains($lower, 'modelo')) {
                    $outputRows[] = $line;

                    continue;
                }
            }

            $cells = explode("\t", $line);
            $converted = [];
            foreach ($cells as $cell) {
                $cell = trim($cell);
                $converted[] = str_replace($search, $replace, $cell);
            }
            $outputRows[] = implode("\t", $converted);
        }

        return implode("\r\n", $outputRows);
    }
}
