<?php

namespace App\Filament\Resources;

use App\Filament\Resources\PuigCompatEquivalenceResource\Pages;
use App\Models\Prestashop\Product;
use App\Models\Prestashop\PuigCompatEquivalence;
use Closure;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Forms\Get;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Model;

class PuigCompatEquivalenceResource extends Resource
{
    protected static ?string $model = PuigCompatEquivalence::class;

    protected static ?string $navigationIcon = 'heroicon-o-arrows-right-left';

    protected static ?string $navigationGroup = 'Tablas de compatibilidad';

    protected static ?string $navigationLabel = 'Equivalencias entre productos';

    protected static ?string $modelLabel = 'Equivalencia';

    protected static ?string $pluralModelLabel = 'Equivalencias entre productos';

    protected static ?int $navigationSort = 30;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_product')
                    ->label('Producto que replica (sombra)')
                    ->required()
                    ->searchable()
                    ->getSearchResultsUsing(static fn (string $search): array => self::searchProducts($search))
                    ->getOptionLabelUsing(static fn ($value): ?string => self::formatProductLabel((int) $value))
                    ->helperText('Producto que copiará la tabla de compatibilidad de otro.'),

                Forms\Components\Select::make('replicates_product_id')
                    ->label('Replica la compat. de (canónico)')
                    ->required()
                    ->searchable()
                    ->getSearchResultsUsing(static fn (string $search): array => self::searchProducts($search))
                    ->getOptionLabelUsing(static fn ($value): ?string => self::formatProductLabel((int) $value))
                    ->helperText('Producto canónico de Puig cuya compat será replicada.')
                    // Validamos a) no auto-equivalencia, b) par único, en el
                    // segundo campo porque ahí ya está disponible el primero
                    // vía Get.
                    ->rules([
                        static fn (Get $get, ?Model $record) => static function (string $attribute, $value, Closure $fail) use ($get, $record): void {
                            $idProduct = (int) ($get('id_product') ?? 0);
                            $replicatesId = (int) $value;

                            if ($idProduct === 0 || $replicatesId === 0) {
                                return; // los required ya marcan los vacíos
                            }

                            if ($idProduct === $replicatesId) {
                                $fail('No se puede replicar la compatibilidad de un producto sobre sí mismo.');

                                return;
                            }

                            $query = PuigCompatEquivalence::query()
                                ->where('id_product', $idProduct)
                                ->where('replicates_product_id', $replicatesId);

                            if ($record !== null) {
                                $query->where('id', '!=', $record->getKey());
                            }

                            if ($query->exists()) {
                                $fail('Esta equivalencia ya existe.');
                            }
                        },
                    ]),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('#')
                    ->sortable(),

                Tables\Columns\TextColumn::make('id_product')
                    ->label('ID producto')
                    ->sortable(),

                Tables\Columns\TextColumn::make('product_reference')
                    ->label('Referencia')
                    ->state(static fn (PuigCompatEquivalence $record): ?string => Product::query()
                        ->where('id_product', $record->id_product)
                        ->value('reference'),
                    )
                    ->searchable(query: static function ($query, string $search): void {
                        $query->whereIn('id_product', Product::query()
                            ->where('reference', 'like', "%{$search}%")
                            ->pluck('id_product'),
                        );
                    }),

                Tables\Columns\TextColumn::make('replicates_product_id')
                    ->label('Replica de ID')
                    ->sortable(),

                Tables\Columns\TextColumn::make('replicates_reference')
                    ->label('Referencia original')
                    ->state(static fn (PuigCompatEquivalence $record): ?string => Product::query()
                        ->where('id_product', $record->replicates_product_id)
                        ->value('reference'),
                    )
                    ->searchable(query: static function ($query, string $search): void {
                        $query->whereIn('replicates_product_id', Product::query()
                            ->where('reference', 'like', "%{$search}%")
                            ->pluck('id_product'),
                        );
                    }),
            ])
            ->defaultSort('id', 'desc')
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
            'index' => Pages\ListPuigCompatEquivalences::route('/'),
            'create' => Pages\CreatePuigCompatEquivalence::route('/create'),
            'edit' => Pages\EditPuigCompatEquivalence::route('/{record}/edit'),
        ];
    }

    /**
     * Busca productos por reference o id_product. Devuelve un array
     * id_product => "REFERENCE (id: N)" para alimentar Select::getSearchResultsUsing.
     *
     * @return array<int,string>
     */
    private static function searchProducts(string $search): array
    {
        $query = Product::query()
            ->where(function ($q) use ($search): void {
                $q->where('reference', 'like', "%{$search}%");
                if (ctype_digit($search)) {
                    $q->orWhere('id_product', (int) $search);
                }
            })
            ->limit(50);

        return $query->get(['id_product', 'reference'])
            ->mapWithKeys(static fn ($p): array => [
                (int) $p->id_product => "{$p->reference} (id: {$p->id_product})",
            ])
            ->all();
    }

    private static function formatProductLabel(int $idProduct): ?string
    {
        $p = Product::query()->find($idProduct, ['id_product', 'reference']);

        return $p === null ? null : "{$p->reference} (id: {$p->id_product})";
    }
}
