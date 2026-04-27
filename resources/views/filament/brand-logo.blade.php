{{-- Logo de ACMOTOS para el panel Filament. --}}
{{-- Filament aplica dark/light vía clase 'dark' en <html>; con Tailwind --}}
{{-- mostramos la versión negra en light y la blanca en dark. La altura --}}
{{-- la fija ->brandLogoHeight() en AdminPanelProvider; los <img> heredan --}}
{{-- height: 100% del wrapper y el ancho se calcula por aspect ratio. --}}

<img src="{{ asset('images/logotipo-acmotos.svg') }}"
     alt="ACMOTOS"
     class="block h-full w-auto dark:hidden">
<img src="{{ asset('images/logotipo-acmotos-blanco.svg') }}"
     alt="ACMOTOS"
     class="hidden h-full w-auto dark:block">
