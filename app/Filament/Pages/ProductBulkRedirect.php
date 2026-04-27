<?php

namespace App\Filament\Pages;

use App\Services\Prestashop\ProductRedirectService;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Form;
use Filament\Notifications\Notification;
use Filament\Pages\Page;

class ProductBulkRedirect extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-arrows-right-left';

    protected static ?string $navigationGroup = 'SEO / Redirecciones';

    protected static ?string $navigationLabel = 'Redirigir productos a su categoría';

    protected static ?string $title = 'Redirigir productos en bulk a su categoría por defecto';

    protected static ?int $navigationSort = 10;

    protected static string $view = 'filament.pages.product-bulk-redirect';

    public ?array $data = [];

    /**
     * Resultado de la última ejecución, para renderizar en la vista.
     *
     * @var array{summary:array<string,int>,details:array<int,array<string,mixed>>}|null
     */
    public ?array $lastRun = null;

    public function mount(): void
    {
        $this->form->fill([
            'identifier_mode' => ProductRedirectService::IDENTIFIER_ID,
        ]);
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Select::make('identifier_mode')
                    ->label('Identificar productos por')
                    ->required()
                    ->options([
                        ProductRedirectService::IDENTIFIER_ID => 'ID de producto',
                        ProductRedirectService::IDENTIFIER_REFERENCE => 'Referencia de producto',
                    ])
                    ->default(ProductRedirectService::IDENTIFIER_ID)
                    ->native(false)
                    ->live(),

                Textarea::make('input_data')
                    ->label(fn (callable $get): string => $get('identifier_mode') === ProductRedirectService::IDENTIFIER_REFERENCE
                        ? 'Referencias de producto'
                        : 'IDs de producto'
                    )
                    ->placeholder(fn (callable $get): string => $get('identifier_mode') === ProductRedirectService::IDENTIFIER_REFERENCE
                        ? "REF-001\nREF-002 REF-003\nREF-004;REF-005"
                        : "12345\n12346 12347\n12348;12349"
                    )
                    ->rows(15)
                    ->required()
                    ->autosize(false)
                    ->extraInputAttributes(['style' => 'font-family: ui-monospace, monospace; font-size: 0.85rem;'])
                    ->helperText('Separadores aceptados: comas, espacios, saltos de línea, tabs y punto y coma. Se deduplica preservando el orden.'),
            ])
            ->statePath('data');
    }

    public function process(ProductRedirectService $service): void
    {
        $data = $this->form->getState();
        $rawInput = (string) ($data['input_data'] ?? '');
        $mode = $data['identifier_mode'];

        $items = $service->parseInput($rawInput);

        if ($items === []) {
            Notification::make()
                ->title('No se proporcionaron entradas válidas.')
                ->danger()
                ->send();

            return;
        }

        $result = $service->process($mode, $items);
        $this->lastRun = $result;

        activity()
            ->causedBy(auth()->user())
            ->withProperties([
                'identifier_mode' => $mode,
                'input_raw' => $rawInput,
                'input_count' => count($items),
                'summary' => $result['summary'],
                'details' => $result['details'],
            ])
            ->log('Redirección bulk de productos a categoría por defecto');

        $s = $result['summary'];
        $message = sprintf(
            '%d productos procesados · %d redirects creadas · %d redirects ya existentes · %d productos desactivados · %d errores',
            $s['processed'],
            $s['redirects_created'],
            $s['redirects_skipped'],
            $s['products_deactivated'],
            $s['errors'],
        );

        Notification::make()
            ->title('Proceso completado')
            ->body($message)
            ->success()
            ->send();
    }
}
