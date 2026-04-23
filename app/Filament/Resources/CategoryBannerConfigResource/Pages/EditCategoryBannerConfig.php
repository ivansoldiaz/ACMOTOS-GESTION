<?php

namespace App\Filament\Resources\CategoryBannerConfigResource\Pages;

use App\Filament\Resources\CategoryBannerConfigResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditCategoryBannerConfig extends EditRecord
{
    protected static string $resource = CategoryBannerConfigResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
