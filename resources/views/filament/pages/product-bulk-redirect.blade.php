<x-filament-panels::page>
    <p class="text-sm text-gray-600 dark:text-gray-300">
        Para cada producto identificado, se crea una redirección 301
        <code>/{idioma}/&lt;slug-producto&gt;</code> →
        <code>https://acmotos.com/{idioma}/&lt;slug-categoría-default&gt;</code>
        en español e inglés, y el producto queda desactivado en
        <code>ps_product</code> y <code>ps_product_shop</code>.
        Si la redirección ya existía para esa URL, se omite.
    </p>

    <form wire:submit="process" class="space-y-4">
        {{ $this->form }}

        <x-filament::button type="submit" icon="heroicon-o-arrows-right-left">
            Crear redirecciones y desactivar productos
        </x-filament::button>
    </form>

    @if ($lastRun)
        @php
            $s = $lastRun['summary'];
            $details = $lastRun['details'];
        @endphp

        <div class="mt-8 space-y-4">
            <h2 class="text-base font-semibold text-gray-950 dark:text-white">Resultado de la última ejecución</h2>

            <div class="grid grid-cols-2 gap-2 sm:grid-cols-5 text-sm">
                <div class="rounded-lg bg-gray-50 dark:bg-gray-800 p-3">
                    <div class="text-gray-500 dark:text-gray-400">Procesados</div>
                    <div class="text-xl font-semibold">{{ $s['processed'] }}</div>
                </div>
                <div class="rounded-lg bg-green-50 dark:bg-green-900/30 p-3">
                    <div class="text-green-700 dark:text-green-300">Redirects creadas</div>
                    <div class="text-xl font-semibold text-green-700 dark:text-green-300">{{ $s['redirects_created'] }}</div>
                </div>
                <div class="rounded-lg bg-yellow-50 dark:bg-yellow-900/30 p-3">
                    <div class="text-yellow-700 dark:text-yellow-300">Redirects ya existían</div>
                    <div class="text-xl font-semibold text-yellow-700 dark:text-yellow-300">{{ $s['redirects_skipped'] }}</div>
                </div>
                <div class="rounded-lg bg-blue-50 dark:bg-blue-900/30 p-3">
                    <div class="text-blue-700 dark:text-blue-300">Productos desactivados</div>
                    <div class="text-xl font-semibold text-blue-700 dark:text-blue-300">{{ $s['products_deactivated'] }}</div>
                </div>
                <div class="rounded-lg bg-red-50 dark:bg-red-900/30 p-3">
                    <div class="text-red-700 dark:text-red-300">Errores</div>
                    <div class="text-xl font-semibold text-red-700 dark:text-red-300">{{ $s['errors'] }}</div>
                </div>
            </div>

            <div class="overflow-x-auto rounded-lg border border-gray-200 dark:border-gray-700">
                <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700 text-sm">
                    <thead class="bg-gray-50 dark:bg-gray-800">
                        <tr>
                            <th class="px-3 py-2 text-left">Input</th>
                            <th class="px-3 py-2 text-left">id_product</th>
                            <th class="px-3 py-2 text-left">Estado</th>
                            <th class="px-3 py-2 text-left">Detalle</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200 dark:divide-gray-700 font-mono">
                        @foreach ($details as $row)
                            <tr class="@if ($row['status'] === 'error') bg-red-50/40 dark:bg-red-900/20 @endif">
                                <td class="px-3 py-2 align-top">{{ $row['input'] }}</td>
                                <td class="px-3 py-2 align-top">{{ $row['id_product'] ?? '—' }}</td>
                                <td class="px-3 py-2 align-top">
                                    @if ($row['status'] === 'ok')
                                        <span class="text-green-700 dark:text-green-300">ok</span>
                                    @else
                                        <span class="text-red-700 dark:text-red-300">error</span>
                                    @endif
                                </td>
                                <td class="px-3 py-2 align-top whitespace-pre-line">
                                    @if (isset($row['messages']))
                                        {{ implode("\n", $row['messages']) }}
                                    @elseif (isset($row['message']))
                                        {{ $row['message'] }}
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
