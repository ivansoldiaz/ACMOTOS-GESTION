<x-filament-panels::page>
    <p class="text-sm text-gray-600 dark:text-gray-300">
        Para cada referencia canónica de Puig, busca sus modelos compatibles en
        <code>py_puig_compat_tables</code>, los aplica al producto correspondiente
        en <code>ps_product</code> (vía <code>reference</code>), y propaga la
        misma tabla a los productos sombra definidos en
        <code>py_compat_tables_equivalences</code>.
        Antes de insertar, las filas previas de los productos afectados se
        borran para evitar duplicados.
    </p>

    <form wire:submit="process" class="space-y-4">
        {{ $this->form }}

        <x-filament::button type="submit" icon="heroicon-o-bolt">
            Asignar compatibilidades
        </x-filament::button>
    </form>

    @if ($lastRun)
        @php
            $s = $lastRun['summary'];
            $details = $lastRun['details'];
        @endphp

        <div class="mt-8 space-y-4">
            <h2 class="text-base font-semibold text-gray-950 dark:text-white">Resultado de la última ejecución</h2>

            <div class="grid grid-cols-2 gap-2 sm:grid-cols-4 lg:grid-cols-7 text-sm">
                <div class="rounded-lg bg-gray-50 dark:bg-gray-800 p-3">
                    <div class="text-gray-500 dark:text-gray-400">Refs input</div>
                    <div class="text-xl font-semibold">{{ $s['input_count'] }}</div>
                </div>
                <div class="rounded-lg bg-green-50 dark:bg-green-900/30 p-3">
                    <div class="text-green-700 dark:text-green-300">En Puig</div>
                    <div class="text-xl font-semibold text-green-700 dark:text-green-300">{{ $s['refs_found_in_puig'] }}</div>
                </div>
                <div class="rounded-lg bg-yellow-50 dark:bg-yellow-900/30 p-3">
                    <div class="text-yellow-700 dark:text-yellow-300">Sin Puig</div>
                    <div class="text-xl font-semibold text-yellow-700 dark:text-yellow-300">{{ $s['refs_not_in_puig'] }}</div>
                </div>
                <div class="rounded-lg bg-yellow-50 dark:bg-yellow-900/30 p-3">
                    <div class="text-yellow-700 dark:text-yellow-300">Sin producto</div>
                    <div class="text-xl font-semibold text-yellow-700 dark:text-yellow-300">{{ $s['refs_not_in_product'] }}</div>
                </div>
                <div class="rounded-lg bg-blue-50 dark:bg-blue-900/30 p-3">
                    <div class="text-blue-700 dark:text-blue-300">Canónicos</div>
                    <div class="text-xl font-semibold text-blue-700 dark:text-blue-300">{{ $s['canonicals_updated'] }}</div>
                </div>
                <div class="rounded-lg bg-blue-50 dark:bg-blue-900/30 p-3">
                    <div class="text-blue-700 dark:text-blue-300">Sombras</div>
                    <div class="text-xl font-semibold text-blue-700 dark:text-blue-300">{{ $s['shadows_propagated'] }}</div>
                </div>
                <div class="rounded-lg bg-green-50 dark:bg-green-900/30 p-3">
                    <div class="text-green-700 dark:text-green-300">Filas insertadas</div>
                    <div class="text-xl font-semibold text-green-700 dark:text-green-300">{{ $s['compat_rows_inserted'] }}</div>
                </div>
            </div>

            <div class="overflow-x-auto rounded-lg border border-gray-200 dark:border-gray-700">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                    <thead class="bg-gray-50 dark:bg-gray-800">
                        <tr>
                            <th class="px-3 py-2 text-left">Referencia</th>
                            <th class="px-3 py-2 text-left">Estado</th>
                            <th class="px-3 py-2 text-left">Detalle</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 dark:divide-gray-700 font-mono">
                        @foreach ($details as $row)
                            @php
                                $rowClass = match ($row['status']) {
                                    'ok' => '',
                                    'not_in_puig' => 'bg-yellow-50/40 dark:bg-yellow-900/20',
                                    'not_in_product' => 'bg-yellow-50/40 dark:bg-yellow-900/20',
                                    default => 'bg-red-50/40 dark:bg-red-900/20',
                                };
                                $statusLabel = match ($row['status']) {
                                    'ok' => 'ok',
                                    'not_in_puig' => 'sin entrada Puig',
                                    'not_in_product' => 'sin producto',
                                    default => $row['status'],
                                };
                                $statusColor = match ($row['status']) {
                                    'ok' => 'text-green-700 dark:text-green-300',
                                    default => 'text-yellow-700 dark:text-yellow-300',
                                };
                            @endphp
                            <tr class="{{ $rowClass }}">
                                <td class="px-3 py-2 align-top">{{ $row['reference'] }}</td>
                                <td class="px-3 py-2 align-top">
                                    <span class="{{ $statusColor }}">{{ $statusLabel }}</span>
                                </td>
                                <td class="px-3 py-2 align-top whitespace-pre-line">
                                    {{ $row['message'] ?? '' }}
                                    @if (! empty($row['canonical_ids']))
                                        <br>canónicos: {{ implode(', ', $row['canonical_ids']) }}
                                    @endif
                                    @if (! empty($row['shadow_ids']))
                                        <br>sombras: {{ implode(', ', $row['shadow_ids']) }}
                                    @endif
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    @endif
</x-filament-panels::page>
