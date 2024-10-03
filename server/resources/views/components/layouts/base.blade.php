<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=2.0, viewport-fit=cover">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    {{-- Title --}}
    @hasSection('title')
        <title>@yield('title') - {{ config('app.name') }}</title>
    @else
        <title>{{ config('app.name') }}</title>
    @endif

    {{-- Favicon settings --}}
    <link rel="shortcut icon" href="{{ url(asset('favicon.ico')) }}">

    {{-- CSRF Token --}}
    <meta name="csrf-token" content="{{ csrf_token() }}">

    {{-- Vite --}}
    @vite(['resources/sass/app.scss', 'resources/js/app.js'])

    @stack('head')
</head>

<body class="bg-base-200 relative min-h-screen flex flex-col antialiased">
    {{-- Content --}}
    @isset($slot)
        {{ $slot }}
    @endisset

    {{--  Toast --}}
    <x-toast />
</body>

@stack('scripts')

@if (count(session('mary.toast') ?? []))
    <script>
        document.addEventListener('livewire:init', () => {
            setTimeout(() => {
                toast({
                    toast: @json(session('mary.toast'))
                });
            }, 100);
        });
    </script>
@endif

</html>
