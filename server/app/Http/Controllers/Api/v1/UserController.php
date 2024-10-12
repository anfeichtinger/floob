<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\Resources\Json\JsonResource;

class UserController extends Controller
{
    /**
     * Get all: apply filters, sorts etc from request.
     */
    public function getUsers(Request $request): AnonymousResourceCollection
    {
        $users = User::forRequest($request)->get();

        return UserResource::collection($users);
    }

    /**
     * Paginate: apply filters, sorts etc from request.
     */
    public function paginateUsers(Request $request): AnonymousResourceCollection
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
    public function getUser(null|string|int $id = null): JsonResource
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json("User with id $id not found.", 404);
        }

        return UserResource::make($user);
    }
}
