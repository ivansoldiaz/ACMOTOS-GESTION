<?php

namespace App\Filament\Resources\LgSeoRedirectResource\Pages;

use App\Filament\Resources\LgSeoRedirectResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditLgSeoRedirect extends EditRecord
{
    protected static string $resource = LgSeoRedirectResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
