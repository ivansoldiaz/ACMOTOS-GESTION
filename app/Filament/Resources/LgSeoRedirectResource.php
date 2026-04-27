<?php

namespace App\Filament\Resources;

use App\Filament\Resources\LgSeoRedirectResource\Pages;
use App\Models\Prestashop\LgSeoRedirect;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;

class LgSeoRedirectResource extends Resource
{
    protected static ?string $model = LgSeoRedirect::class;

    protected static ?string $navigationIcon = 'heroicon-o-link';

    protected static ?string $navigationGroup = 'SEO / Redirecciones';

    protected static ?string $navigationLabel = 'Gestionar redirecciones';

    protected static ?string $modelLabel = 'Redirección';

    protected static ?string $pluralModelLabel = 'Redirecciones';

    protected static ?int $navigationSort = 20;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('url_old')
                    ->label('URL antigua')
                    ->placeholder('/es/slug-producto-viejo')
                    ->required()
                    ->maxLength(2048)
                    // Tabla cualificada con la conexión para que Laravel
                    // valide contra prestashop.ps_lgseoredirect, no contra
                    // la conexión default mysql/gestion_acm.
                    ->unique(
                        table: 'prestashop.ps_lgseoredirect',
                        column: 'url_old',
                        ignoreRecord: true,
                    )
                    ->helperText('Path relativo de la URL que se quiere redirigir. Ejemplo: /es/cascos-shoei-nxr')
                    ->columnSpanFull(),

                Forms\Components\TextInput::make('url_new')
                    ->label('URL nueva')
                    ->placeholder('https://acmotos.com/es/cascos')
                    ->required()
                    ->url()
                    ->maxLength(2048)
                    ->default('https://acmotos.com/')
                    ->helperText('URL absoluta a la que se redirigirá. En la mayoría de casos https://acmotos.com/... — para otros dominios, sustituye el prefijo.')
                    ->columnSpanFull(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('#')
                    ->sortable(),

                Tables\Columns\TextColumn::make('url_old')
                    ->label('URL antigua')
                    ->searchable()
                    ->sortable()
                    ->copyable()
                    ->limit(60)
                    ->tooltip(fn ($record): ?string => $record?->url_old),

                Tables\Columns\TextColumn::make('url_new')
                    ->label('URL nueva')
                    ->searchable()
                    ->sortable()
                    ->copyable()
                    ->limit(60)
                    ->tooltip(fn ($record): ?string => $record?->url_new),

                Tables\Columns\TextColumn::make('redirect_type')
                    ->label('Tipo')
                    ->badge()
                    ->color(fn (string $state): string => $state === '301' ? 'success' : 'warning'),

                Tables\Columns\TextColumn::make('update')
                    ->label('Última modificación')
                    ->dateTime('Y-m-d H:i')
                    ->sortable(),
            ])
            ->defaultSort('update', 'desc')
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
            'index' => Pages\ListLgSeoRedirects::route('/'),
            'create' => Pages\CreateLgSeoRedirect::route('/create'),
            'edit' => Pages\EditLgSeoRedirect::route('/{record}/edit'),
        ];
    }
}
