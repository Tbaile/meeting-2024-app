<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ShoppingListController;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/phpinfo', function () {
    phpinfo();
});

Route::resource('shopping-list', ShoppingListController::class)->only([
    'index', 'store', 'destroy'
])->parameters([
    'shopping-list' => 'shopping_item'
]);
