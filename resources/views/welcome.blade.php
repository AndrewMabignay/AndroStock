<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    {{-- @php
        $manifest = file_exists(public_path('build/manifest.json'))
            ? json_decode(file_get_contents(public_path('build/manifest.json')), true)
            : [];
    @endphp

    @if (isset($manifest['resources/css/app.css']['file']))
        <link rel="stylesheet" href="{{ asset('build/' . $manifest['resources/css/app.css']['file']) }}">
    @endif

    @if (isset($manifest['resources/js/app.js']['file']))
        <script type="module" src="{{ asset('build/' . $manifest['resources/js/app.js']['file']) }}"></script>
    @endif --}}

    @php
        $manifest = json_decode(file_get_contents(public_path('build/manifest.json')), true);
    @endphp

    <link rel="stylesheet" href="{{ secure_asset('build/' . $manifest['resources/css/app.css']['file']) }}">
    <script type="module" src="{{ secure_asset('build/' . $manifest['resources/js/app.js']['file']) }}"></script>



</head>
<body>
    <h1 class="bg-blue-500">Testing</h1>

    <p>Testing</p>
</body>
</html>