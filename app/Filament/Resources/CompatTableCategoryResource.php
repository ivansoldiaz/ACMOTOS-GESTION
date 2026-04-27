<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CompatTableCategoryResource\Pages;
use App\Models\Prestashop\CategoryLang;
use App\Models\Prestashop\CompatTableCategory;
use App\Services\Prestashop\LanguageService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CompatTableCategoryResource extends Resource
{
    protected static ?string $model = CompatTableCategory::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    protected static ?string $navigationGroup = 'Tablas de compatibilidad';

    protected static ?string $navigationLabel = 'Categorías con tabla de compat.';

    protected static ?string $modelLabel = 'Categoría con tabla';

    protected static ?string $pluralModelLabel = 'Categorías con tabla de compatibilidad';

    protected static ?int $navigationSort = 40;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_category')
                    ->label('Categoría')
                    ->required()
                    ->searchable()
                    ->getSearchResultsUsing(function (string $search) {
                        // En Create, ocultamos las ya asignadas. En Edit dejamos
                        // ver todas (puede que la actual esté en la lista de
                        // "asignadas" — la incluimos vía la lógica del label).
                        $usedIds = CompatTableCategory::query()->pluck('id_category')->all();

                        return CategoryLang::query()
                            ->where('id_lang', LanguageService::LANG_ES)
                            ->where('id_shop', LanguageService::ID_SHOP)
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
                        ->where('id_shop', LanguageService::ID_SHOP)
                        ->value('name')
                    )
                    // Tabla cualificada con la conexión para que la rule unique
                    // vaya contra la DB de prestashop, no contra gestion_acm.
                    ->unique(
                        table: 'prestashop.ps_ac_compat_tables_category',
                        column: 'id_category',
                        ignoreRecord: true,
                    )
                    ->helperText('Categoría que mostrará el botón "Ver tabla de compatibilidad" en el frontend.'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn ($query) => $query->with('categoryLang'))
            ->columns([
                Tables\Columns\TextColumn::make('id_compat_cat')
                    ->label('#')
                    ->sortable(),

                Tables\Columns\TextColumn::make('id_category')
                    ->label('ID categoría')
                    ->sortable(),

                Tables\Columns\TextColumn::make('categoryLang.name')
                    ->label('Nombre categoría')
                    ->searchable()
                    ->sortable(),
            ])
            ->defaultSort('categoryLang.name')
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

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListCompatTableCategories::route('/'),
            'create' => Pages\CreateCompatTableCategory::route('/create'),
            'edit' => Pages\EditCompatTableCategory::route('/{record}/edit'),
        ];
    }
}
