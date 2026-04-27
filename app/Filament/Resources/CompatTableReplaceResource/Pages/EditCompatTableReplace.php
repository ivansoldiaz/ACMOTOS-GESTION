<?php

namespace App\Filament\Resources\CompatTableReplaceResource\Pages;

use App\Filament\Resources\CompatTableReplaceResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditCompatTableReplace extends EditRecord
{
    protected static string $resource = CompatTableReplaceResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
