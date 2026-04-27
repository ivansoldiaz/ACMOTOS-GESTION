<?php

namespace App\Filament\Resources\CompatTableReplaceResource\Pages;

use App\Filament\Resources\CompatTableReplaceResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListCompatTableReplaces extends ListRecords
{
    protected static string $resource = CompatTableReplaceResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
