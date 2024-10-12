<?php

use App\Http\Controllers\Api\v1\UserController;
use Illuminate\Support\Facades\Route;

#region Users
Route::controller(UserController::class)->prefix('/users')->group(function () {
    // Todo - Implement here or make AuthController
    // Route::post('/register', 'register');
    // Route::post('/login', 'login');
    // Route::post('/logout', 'logout');

    Route::get('/', 'getUsers');
    Route::get('/paginate', 'paginateUsers');
    Route::get('/{id}', 'getUser');
});
#endregion Users
