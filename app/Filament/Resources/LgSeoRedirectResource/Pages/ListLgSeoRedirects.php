<?php

namespace App\Filament\Resources\LgSeoRedirectResource\Pages;

use App\Filament\Resources\LgSeoRedirectResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListLgSeoRedirects extends ListRecords
{
    protected static string $resource = LgSeoRedirectResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Nueva redirección'),
        ];
    }
}
