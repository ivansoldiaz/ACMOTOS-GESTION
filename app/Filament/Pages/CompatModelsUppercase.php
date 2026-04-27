<?php

namespace App\Filament\Pages;

use App\Models\Prestashop\CompatTableReplace;
use App\Services\Prestashop\CompatCapitalizationService;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Pages\Page;

class CompatModelsUppercase extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-arrow-down-tray';

    protected static ?string $navigationGroup = 'Tablas de compatibilidad';

    protected static ?string $navigationLabel = 'Capitalizar modelos';

    protected static ?string $title = 'Capitalizar tabla de modelos';

    protected static ?int $navigationSort = 20;

    protected static string $view = 'filament.pages.compat-models-uppercase';

    public ?array $data = [];

    public function mount(): void
    {
        $this->form->fill();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Textarea::make('input_data')
                    ->label('Datos de entrada (TSV)')
                    ->placeholder("Marca\tModelo\nTRIUMPH\tTIGER 850 SPORT\nBMW\tR NINE T PURE\nBENELLI\tTRK 502 X")
                    ->rows(15)
                    ->required()
                    ->autosize(false)
                    ->extraInputAttributes(['style' => 'font-family: ui-monospace, monospace; font-size: 0.85rem;'])
                    ->helperText('Pega celdas directamente desde Excel/Sheets. La primera línea de cabecera (Marca/Modelo) se conserva tal cual.'),
            ])
            ->statePath('data');
    }

    public function process(CompatCapitalizationService $service)
    {
        $data = $this->form->getState();
        $input = (string) ($data['input_data'] ?? '');

        $output = $service->applyToTsv($input);

        activity('proceso')
            ->causedBy(auth()->user())
            ->event('capitalizar_modelos_tsv')
            ->withProperties([
                'input_bytes' => strlen($input),
                'output_bytes' => strlen($output),
                'input_lines' => substr_count(trim($input), "\n") + 1,
            ])
            ->log('Capitalización de modelos: TSV procesado');

        return response()->streamDownload(
            function () use ($output): void {
                echo $output;
            },
            'modelos_capitalizados.tsv',
            ['Content-Type' => 'text/tab-separated-values; charset=utf-8'],
        );
    }

    public function getDictionaryCount(): int
    {
        return CompatTableReplace::query()->count();
    }
}
