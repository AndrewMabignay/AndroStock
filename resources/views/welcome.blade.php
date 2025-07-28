<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>

    @php
        $manifest = json_decode(file_get_contents(public_path('build/manifest.json')), true);
    @endphp
    <link rel="stylesheet" href="{{ asset('build/assets/' . $manifest['resources/css/app.css']['file']) }}">
    <script type="module" src="{{ asset('build/assets/' . $manifest['resources/js/app.js']['file']) }}"></script>

</head>
<body>
    <h1 class="bg-blue-500">Testing</h1>

    <p>Testing</p>
</body>
</html>