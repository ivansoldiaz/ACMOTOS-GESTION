<?php

namespace App\Filament\Resources\CategoryBannerConfigResource\RelationManagers;

use App\Models\Prestashop\CategoryBannerLink;
use App\Models\Prestashop\CategoryLang;
use App\Services\Prestashop\LanguageService;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;

class LinksRelationManager extends RelationManager
{
    protected static string $relationship = 'links';

    protected static ?string $title = 'Banners de esta categoría';

    protected static ?string $modelLabel = 'Banner';

    protected static ?string $pluralModelLabel = 'Banners';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Select::make('id_target_category')
                    ->label('Categoría destino')
                    ->required()
                    ->searchable()
                    ->getSearchResultsUsing(fn (string $search) => CategoryLang::query()
                        ->where('id_lang', LanguageService::LANG_ES)
                        ->where('name', 'like', "%{$search}%")
                        ->orderBy('name')
                        ->limit(50)
                        ->pluck('name', 'id_category')
                        ->all()
                    )
                    ->getOptionLabelUsing(fn ($value) => CategoryLang::query()
                        ->where('id_category', $value)
                        ->where('id_lang', LanguageService::LANG_ES)
                        ->value('name')
                    ),

                Forms\Components\TextInput::make('anchor_text_es')
                    ->label('Texto enlace (ES)')
                    ->maxLength(255),

                Forms\Components\TextInput::make('anchor_text_en')
                    ->label('Texto enlace (EN)')
                    ->maxLength(255),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->reorderable('position')
            ->defaultSort('position')
            ->modifyQueryUsing(fn (Builder $q) => $q->with(['langs', 'targetCategoryLang']))
            ->columns([
                Tables\Columns\TextColumn::make('position')
                    ->label('#')
                    ->width(40)
                    ->alignCenter(),

                Tables\Columns\TextColumn::make('targetCategoryLang.name')
                    ->label('Categoría destino')
                    ->searchable(),

                Tables\Columns\TextColumn::make('anchor_text_es')
                    ->label('Texto ES')
                    ->limit(40),

                Tables\Columns\TextColumn::make('anchor_text_en')
                    ->label('Texto EN')
                    ->limit(40),
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()
                    ->label('Añadir banner')
                    ->using(function (array $data, string $model): Model {
                        $link = (new $model)->fill([
                            'id_config' => $this->getOwnerRecord()->getKey(),
                            'id_target_category' => $data['id_target_category'],
                            'position' => ((int) CategoryBannerLink::where('id_config', $this->getOwnerRecord()->getKey())->max('position')) + 1,
                        ]);
                        $link->save();

                        $link->setAnchorTextForLang(LanguageService::LANG_ES, $data['anchor_text_es'] ?? '');
                        $link->setAnchorTextForLang(LanguageService::LANG_EN, $data['anchor_text_en'] ?? '');

                        return $link;
                    }),
            ])
            ->actions([
                Tables\Actions\EditAction::make()
                    ->mutateRecordDataUsing(function (array $data, CategoryBannerLink $record): array {
                        $data['anchor_text_es'] = $record->anchor_text_es;
                        $data['anchor_text_en'] = $record->anchor_text_en;

                        return $data;
                    })
                    ->using(function (CategoryBannerLink $record, array $data): CategoryBannerLink {
                        $record->update([
                            'id_target_category' => $data['id_target_category'],
                        ]);

                        $record->setAnchorTextForLang(LanguageService::LANG_ES, $data['anchor_text_es'] ?? '');
                        $record->setAnchorTextForLang(LanguageService::LANG_EN, $data['anchor_text_en'] ?? '');

                        return $record;
                    }),

                Tables\Actions\DeleteAction::make()
                    ->before(function (CategoryBannerLink $record) {
                        $record->langs()->delete();
                    }),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make()
                        ->before(function ($records) {
                            foreach ($records as $record) {
                                $record->langs()->delete();
                            }
                        }),
                ]),
            ]);
    }
}
