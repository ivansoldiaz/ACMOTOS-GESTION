<?php

namespace App\Filament\Resources;

use App\Filament\Resources\CompatTableReplaceResource\Pages;
use App\Models\Prestashop\CompatTableReplace;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class CompatTableReplaceResource extends Resource
{
    protected static ?string $model = CompatTableReplace::class;

    protected static ?string $navigationIcon = 'heroicon-o-language';

    protected static ?string $navigationGroup = 'Tablas de compatibilidad';

    protected static ?string $navigationLabel = 'Diccionario';

    protected static ?string $modelLabel = 'Entrada de diccionario';

    protected static ?string $pluralModelLabel = 'Diccionario de capitalización';

    protected static ?int $navigationSort = 10;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('text_to_replace')
                    ->label('Texto en mayúsculas')
                    ->placeholder('TEXTO EN MAYÚSCULAS')
                    ->required()
                    ->maxLength(255)
                    ->unique(ignoreRecord: true)
                    ->disabledOn('edit')
                    ->helperText('Texto tal y como llega desde Excel. No se puede cambiar tras crear la entrada.'),

                Forms\Components\TextInput::make('capitalized_text')
                    ->label('Texto capitalizado')
                    ->maxLength(255)
                    ->helperText('Si lo dejas vacío al guardar, se autocompleta a partir del texto en mayúsculas.'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('#')
                    ->sortable(),

                Tables\Columns\TextColumn::make('text_to_replace')
                    ->label('Texto en mayúsculas')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('capitalized_text')
                    ->label('Texto capitalizado')
                    ->searchable()
                    ->sortable(),
            ])
            ->defaultSort('text_to_replace')
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
            'index' => Pages\ListCompatTableReplaces::route('/'),
            'create' => Pages\CreateCompatTableReplace::route('/create'),
            'edit' => Pages\EditCompatTableReplace::route('/{record}/edit'),
        ];
    }
}
