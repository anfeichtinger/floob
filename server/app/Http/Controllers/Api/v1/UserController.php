<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Actions\User\CreateUserAction;
use App\Http\Controllers\Controller;
use App\Http\DTOs\UserData;
use App\Http\Resources\UserResource;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function register(Request $request): mixed
    {
        // Validation rules
        $validator = Validator::make($request->all(), [
            'name' => ['required', 'string', 'between:2,255'],
            'email' => ['required', 'email', 'unique:users'],
            'password' => ['required', 'string', 'min:8'],
        ]);

        // Valiation errors
        if ($validator->fails()) {
            return response()->json($validator->errors(), Response::HTTP_BAD_REQUEST);
        }

        // Register new user - automatically confirm email
        $user = CreateUserAction::handle(new UserData(
            name: $request->name ?? null,
            email: $request->email ?? null,
            email_verified_at: Carbon::now(),
            password: $request->password ?? null,
            remember_token: $request->rememberToken ?? null,
        ));

        return UserResource::make($user);
    }

    public function login(Request $request): mixed
    {
        // Validation rules
        $validator = Validator::make($request->all(), [
            'email' => ['required', 'email'],
            'password' => ['required', 'string'],
        ]);

        // Valiation errors
        if ($validator->fails()) {
            return response()->json($validator->errors(), Response::HTTP_BAD_REQUEST);
        }

        // Return user when credentials are correct
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password], true)) {
            return UserResource::make(Auth::user());
        }

        // Notify wrong credentials
        return response()->json(['password' => trans('validation.current_password')], Response::HTTP_BAD_REQUEST);
    }

    public function logout(Request $request): mixed
    {
        $user = User::where('remember_token', $request->rememberToken ?? 'invalid')->first();

        if ($user) {
            $user->remember_token = null;
            $user->save();

            Auth::logout($user);

            return response()->json(['message' => 'Logout successful.'], Response::HTTP_OK);
        }

        return response()->json(['message' => 'Not logged in.'], Response::HTTP_BAD_REQUEST);
    }

    /**
     * Get all: apply filters, sorts etc from request.
     */
    public function getUsers(Request $request): mixed
    {
        $users = User::forRequest($request)->get();

        return UserResource::collection($users);
    }

    /**
     * Paginate: apply filters, sorts etc from request.
     */
    public function paginateUsers(Request $request): mixed
    {
        $users = User::forRequest($request)->paginate(
            perPage: $request?->perPage ?? 10,
            columns: $request?->columns ?? ['*'],
            pageName: $request?->pageName ?? 'page',
            page: $request?->page ?? 1,
        );

        return UserResource::collection($users);
    }

    /**
     * Get by id.
     */
    public function getUser(null|string|int $id = null): mixed
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['message' => "User with id $id not found."], Response::HTTP_NOT_FOUND);
        }

        return UserResource::make($user);
    }
}
