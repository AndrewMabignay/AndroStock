<?php

use Illuminate\Support\Facades\Route;

Route::get('/manifest', function () {
    return file_exists(public_path('build/manifest.json'))
        ? json_decode(file_get_contents(public_path('build/manifest.json')), true)
        : 'No manifest';
});


Route::get('/', function () {
    return view('welcome');
});

Route::get('/products', function() {
    return view('product'); 
});