<?php

namespace App\Filament\Resources\CompatTableCategoryResource\Pages;

use App\Filament\Resources\CompatTableCategoryResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListCompatTableCategories extends ListRecords
{
    protected static string $resource = CompatTableCategoryResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Añadir categoría'),
        ];
    }
}
