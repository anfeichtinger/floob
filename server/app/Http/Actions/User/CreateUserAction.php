<?php

namespace App\Http\Actions\User;

use App\Http\DTOs\UserData;
use App\Models\User;

class CreateUserAction
{
    public static function handle(UserData $data): User
    {
        $user = new User;
        $user->name = $data->name;
        $user->email = $data->email;
        $user->email_verified_at = $data->email_verified_at;
        $user->password = bcrypt($data->password);
        $user->remember_token = $data->remember_token;
        $user->save();

        $user->markEmailAsVerified();

        return $user;
    }
}
