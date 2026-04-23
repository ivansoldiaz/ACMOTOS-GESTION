<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CategoryBannerConfigResource\Pages;
use App\Filament\Resources\CategoryBannerConfigResource\RelationManagers\LinksRelationManager;
use App\Models\Prestashop\CategoryBannerConfig;
use App\Models\Prestashop\CategoryLang;
use App\Services\Prestashop\LanguageService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CategoryBannerConfigResource extends Resource
{
    protected static ?string $model = CategoryBannerConfig::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-group';

    protected static ?string $navigationGroup = 'Contenidos web';

    protected static ?string $modelLabel = 'Banner de categoría';

    protected static ?string $pluralModelLabel = 'Banners de categorías';

    protected static ?int $navigationSort = 10;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_category')
                    ->label('Categoría')
                    ->required()
                    ->searchable()
                    ->disabledOn('edit')
                    ->helperText('Categoría que mostrará los banners. No se puede cambiar tras crearla.')
                    ->getSearchResultsUsing(function (string $search) {
                        $usedIds = CategoryBannerConfig::query()->pluck('id_category')->all();

                        return CategoryLang::query()
                            ->where('id_lang', LanguageService::LANG_ES)
                            ->whereNotIn('id_category', $usedIds)
                            ->where('name', 'like', "%{$search}%")
                            ->orderBy('name')
                            ->limit(50)
                            ->pluck('name', 'id_category')
                            ->all();
                    })
                    ->getOptionLabelUsing(fn ($value) => CategoryLang::query()
                        ->where('id_category', $value)
                        ->where('id_lang', LanguageService::LANG_ES)
                        ->value('name')
                    ),

                Forms\Components\Select::make('template')
                    ->label('Template')
                    ->required()
                    ->options(config('banners.templates'))
                    ->native(false),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id_category')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('categoryLang.name')
                    ->label('Categoría')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('template')
                    ->label('Template')
                    ->badge(),

                Tables\Columns\TextColumn::make('links_count')
                    ->label('Banners')
                    ->counts('links')
                    ->alignCenter()
                    ->badge()
                    ->color(fn (int $state) => $state > 0 ? 'success' : 'gray'),
            ])
            ->defaultSort('id_category')
            ->filters([
                Tables\Filters\SelectFilter::make('template')
                    ->options(config('banners.templates')),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            LinksRelationManager::class,
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCategoryBannerConfigs::route('/'),
            'create' => Pages\CreateCategoryBannerConfig::route('/create'),
            'edit' => Pages\EditCategoryBannerConfig::route('/{record}/edit'),
        ];
    }
}
