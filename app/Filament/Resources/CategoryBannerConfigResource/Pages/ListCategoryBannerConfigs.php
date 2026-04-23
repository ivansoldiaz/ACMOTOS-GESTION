<?php

namespace App\Filament\Resources\CategoryBannerConfigResource\Pages;

use App\Filament\Resources\CategoryBannerConfigResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListCategoryBannerConfigs extends ListRecords
{
    protected static string $resource = CategoryBannerConfigResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
