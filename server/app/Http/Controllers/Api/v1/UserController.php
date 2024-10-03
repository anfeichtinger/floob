<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;

class UserController extends Controller
{
    public function getUsers()
    {
        return UserResource::collection(User::get());
    }

    public function getUser(null|string|int $id = null)
    {
        $user = User::find($id);
        if (!$user) {
            return response()->json("User with id $id not found.", 404);
        }

        return UserResource::make($user);
    }
}
