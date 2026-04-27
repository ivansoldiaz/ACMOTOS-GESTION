<x-filament-panels::page>
    <p class="text-sm text-gray-600 dark:text-gray-300">
        Pega una tabla con columnas <strong>Marca</strong> y <strong>Modelo</strong>
        (separadas por tabulador, como desde Excel). Se descargará el mismo fichero
        con los textos capitalizados según el diccionario de sustitución.
    </p>

    <form wire:submit="process" class="space-y-4">
        {{ $this->form }}

        <div class="flex flex-wrap items-center gap-3">
            <x-filament::button type="submit" icon="heroicon-o-arrow-down-tray">
                Descargar TSV capitalizado
            </x-filament::button>

            <span class="text-sm text-gray-500 dark:text-gray-400">
                Diccionario cargado:
                <strong>{{ number_format($this->getDictionaryCount(), 0, ',', '.') }}</strong>
                entradas.
            </span>
        </div>
    </form>
</x-filament-panels::page>
