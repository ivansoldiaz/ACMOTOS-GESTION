<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CategoryBannerConfigResource\Pages;
use App\Filament\Resources\CategoryBannerConfigResource\RelationManagers\LinksRelationManager;
use App\Models\Prestashop\Category;
use App\Models\Prestashop\CategoryBannerConfig;
use App\Services\Prestashop\LanguageService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;

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

                        return Category::query()
                            ->whereNotIn('ps_category.id_category', $usedIds)
                            ->join('ps_category_lang as cl', function ($join) {
                                $join->on('cl.id_category', '=', 'ps_category.id_category')
                                    ->where('cl.id_lang', LanguageService::LANG_ES);
                            })
                            ->where('cl.name', 'like', "%{$search}%")
                            ->orderBy('cl.name')
                            ->limit(50)
                            ->pluck('cl.name', 'ps_category.id_category')
                            ->all();
                    })
                    ->getOptionLabelUsing(function ($value): ?string {
                        return Category::query()
                            ->join('ps_category_lang as cl', function ($join) {
                                $join->on('cl.id_category', '=', 'ps_category.id_category')
                                    ->where('cl.id_lang', LanguageService::LANG_ES);
                            })
                            ->where('ps_category.id_category', $value)
                            ->value('cl.name');
                    }),

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
            ->modifyQueryUsing(fn (Builder $q) => $q
                ->addSelect([
                    'category_name' => Category::query()
                        ->join('ps_category_lang as cl', function ($join) {
                            $join->on('cl.id_category', '=', 'ps_category.id_category')
                                ->where('cl.id_lang', LanguageService::LANG_ES);
                        })
                        ->whereColumn('ps_category.id_category', 'ps_ac_category_banners_config.id_category')
                        ->select('cl.name')
                        ->limit(1),
                ])
                ->withCount('links')
            )
            ->columns([
                Tables\Columns\TextColumn::make('id_category')
                    ->label('ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('category_name')
                    ->label('Categoría')
                    ->searchable(query: function (Builder $query, string $search): Builder {
                        $ids = Category::query()
                            ->join('ps_category_lang as cl', function ($join) {
                                $join->on('cl.id_category', '=', 'ps_category.id_category')
                                    ->where('cl.id_lang', LanguageService::LANG_ES);
                            })
                            ->where('cl.name', 'like', "%{$search}%")
                            ->pluck('ps_category.id_category')
                            ->all();

                        return $query->whereIn('id_category', $ids);
                    }),

                Tables\Columns\TextColumn::make('template')
                    ->label('Template')
                    ->badge(),

                Tables\Columns\TextColumn::make('links_count')
                    ->label('Banners')
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
