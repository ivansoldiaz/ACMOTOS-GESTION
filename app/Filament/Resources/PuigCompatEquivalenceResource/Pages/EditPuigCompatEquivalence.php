<?php

namespace App\Filament\Resources\PuigCompatEquivalenceResource\Pages;

use App\Filament\Resources\PuigCompatEquivalenceResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPuigCompatEquivalence extends EditRecord
{
    protected static string $resource = PuigCompatEquivalenceResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
