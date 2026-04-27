<?php

namespace App\Filament\Pages;

use App\Services\Prestashop\PuigCompatTableUpdaterService;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;

class PuigCompatTableUpdater extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-bolt';

    protected static ?string $navigationGroup = 'Tablas de compatibilidad';

    protected static ?string $navigationLabel = 'Asignar compat. Puig';

    protected static ?string $title = 'Asignar compatibilidades a productos Puig por referencia';

    protected static ?int $navigationSort = 50;

    protected static string $view = 'filament.pages.puig-compat-table-updater';

    public ?array $data = [];

    /**
     * Resultado de la última ejecución, para renderizar en la vista.
     *
     * @var array{summary:array<string,int>,details:array<int,array<string,mixed>>}|null
     */
    public ?array $lastRun = null;

    public function mount(): void
    {
        $this->form->fill();
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Textarea::make('input_data')
                    ->label('Referencias Puig (canónicas)')
                    ->placeholder("20442N\n6826N 6831N\n9420V;9421V")
                    ->rows(15)
                    ->required()
                    ->autosize(false)
                    ->extraInputAttributes(['style' => 'font-family: ui-monospace, monospace; font-size: 0.85rem;'])
                    ->helperText('Separadores: comas, espacios, saltos de línea, tabs y punto y coma. Las refs ambiguas (que coincidan con varios productos en ps_product) se procesan todas. Las equivalencias propagan la compat a los productos sombra automáticamente.'),
            ])
            ->statePath('data');
    }

    public function process(PuigCompatTableUpdaterService $service): void
    {
        $data = $this->form->getState();
        $rawInput = (string) ($data['input_data'] ?? '');

        $references = $service->parseInput($rawInput);

        if ($references === []) {
            Notification::make()
                ->title('No se proporcionaron referencias válidas.')
                ->danger()
                ->send();

            return;
        }

        $result = $service->process($references);
        $this->lastRun = $result;

        activity('proceso')
            ->causedBy(auth()->user())
            ->event('asignar_compat_puig')
            ->withProperties([
                'input_raw' => $rawInput,
                'references' => $references,
                'summary' => $result['summary'],
                'details' => $result['details'],
            ])
            ->log('Asignación de compatibilidades Puig por referencia');

        $s = $result['summary'];
        $message = sprintf(
            '%d refs en input · %d encontradas en Puig · %d sin entrada Puig · %d sin producto · %d canónicos · %d sombras propagadas · %d filas insertadas',
            $s['input_count'],
            $s['refs_found_in_puig'],
            $s['refs_not_in_puig'],
            $s['refs_not_in_product'],
            $s['canonicals_updated'],
            $s['shadows_propagated'],
            $s['compat_rows_inserted'],
        );

        Notification::make()
            ->title('Proceso completado')
            ->body($message)
            ->success()
            ->send();
    }
}
