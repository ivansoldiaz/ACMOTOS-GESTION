<?php

namespace App\Filament\Resources\PuigCompatEquivalenceResource\Pages;

use App\Filament\Resources\PuigCompatEquivalenceResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListPuigCompatEquivalences extends ListRecords
{
    protected static string $resource = PuigCompatEquivalenceResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make()
                ->label('Nueva equivalencia'),
        ];
    }
}
