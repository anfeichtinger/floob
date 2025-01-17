<?php

use App\Http\Controllers\Api\v1\LocationController;
use App\Http\Controllers\Api\v1\UserController;
use Illuminate\Support\Facades\Route;

#region Users
Route::controller(UserController::class)->prefix('/users')->group(function () {
    // Auth
    Route::post('/register', 'register');
    Route::post('/login', 'login');
    Route::post('/logout', 'logout');

    // Common
    Route::get('/', 'getUsers');
    Route::get('/paginate', 'paginateUsers');
    Route::get('/{id}', 'getUser');
});
#endregion Users

#region Locations
Route::controller(LocationController::class)->prefix('/locations')->group(function () {
    Route::get('/', 'getLocations');
    Route::get('/paginate', 'paginateLocations');
    Route::get('/latlng', 'getLocationsByLatLng');
    Route::get('/{id}', 'getLocation');
});
#endregion Locations
