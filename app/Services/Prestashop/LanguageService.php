<?php

namespace App\Services\Prestashop;

class LanguageService
{
    public const LANG_ES = 1;

    public const LANG_EN = 3;

    public const ID_SHOP = 1;

    public static function all(): array
    {
        return [
            self::LANG_ES => 'Español',
            self::LANG_EN => 'English',
        ];
    }

    public static function name(int $idLang): ?string
    {
        return self::all()[$idLang] ?? null;
    }
}
