<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Http\Resources\LocationResource;
use App\Models\Location;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class LocationController extends Controller
{
    /**
     * Get all: apply filters, sorts etc from request.
     */
    public function getLocations(Request $request): mixed
    {
        $locations = Location::forRequest($request)->get();

        return LocationResource::collection($locations);
    }

    /**
     * Paginate: apply filters, sorts etc from request.
     */
    public function paginateLocations(Request $request): mixed
    {
        $locations = Location::forRequest($request)->paginate(
            perPage: $request?->perPage ?? 10,
            columns: $request?->columns ?? ['*'],
            pageName: $request?->pageName ?? 'page',
            page: $request?->page ?? 1,
        );

        return LocationResource::collection($locations);
    }

    /**
     * Get by id.
     */
    public function getLocation(null|string|int $id = null): mixed
    {
        $location = Location::find($id);

        if (!$location) {
            return response()->json(['message' => "Location with id $id not found."], Response::HTTP_NOT_FOUND);
        }

        return LocationResource::make($location);
    }
}
