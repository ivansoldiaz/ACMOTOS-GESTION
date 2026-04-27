<?php

namespace App\Filament\Resources\CompatTableCategoryResource\Pages;

use App\Filament\Resources\CompatTableCategoryResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditCompatTableCategory extends EditRecord
{
    protected static string $resource = CompatTableCategoryResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
