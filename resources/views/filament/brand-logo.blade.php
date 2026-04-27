{{-- Logo de ACMOTOS para el panel Filament. --}}
{{-- El SVG usa fill="currentColor" y se inlinea en HTML para que pueda --}}
{{-- heredar el color del wrapper. text-gray-950 / dark:text-white sí --}}
{{-- están en el CSS precompilado de Filament (las usa por todo el panel), --}}
{{-- así que el logo cambia automáticamente al activar dark mode. --}}

<div class="text-gray-950 dark:text-white">
    {!! file_get_contents(public_path('images/logotipo-acmotos.svg')) !!}
</div>
