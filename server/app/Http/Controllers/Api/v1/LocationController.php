<?php

namespace App\Http\Controllers\Api\v1;

use App\Http\Controllers\Controller;
use App\Http\Resources\LocationResource;
use App\Models\Location;
use App\Services\OpenStreetMap\Models\LatLng;
use App\Services\OpenStreetMap\OverpassApi;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Collection;

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

    /**
     * Get all locations by latitude and longitude with their respective Overpass API data.
     */
    public function getLocationsByLatLng(Request $request): mixed
    {
        // Validate the inputs
        try {
            $request->validate([
                'lat' => 'required|numeric|between:-90,90',
                'lng' => 'required|numeric|between:-180,180',
                'radius' => 'nullable|numeric|between:0,50',
            ]);
        } catch (Exception $e) {
            return response()->json(['message' => $e->getMessage()]);
        }

        // Parse coordinates
        $latitude = floatval($request->lat);
        $longitude = floatval($request->lng);
        $radius = intval($request->radius ?? 20);

        // Make request to Overpass
        $overpassResults = Collection::make(OverpassApi::fetchFeatures(new LatLng($latitude, $longitude), $radius)?->elements ?? []);

        // Prepare the initial response
        $query = Location::query();
        if ($request->withReviews === '1') {
            $query->with('reviews');
        }
        $locations = $query->whereIn('overpass_id', $overpassResults->pluck('id')->toArray())->get();
        $result = [];

        // Todo maybe merge locations with the same name.
        // E.g there are two different ids for 'FH Joanneum'.

        // When a matching location exists in the database, load the overpass data into it and remove it from elements
        foreach ($overpassResults as $overpassData) {
            // Don't show locations without a name
            if (stringNullOrEmpty($overpassData->name)) {
                continue;
            }

            if ($location = $locations->where('overpass_id', $overpassData->id)->first()) {
                // Update Location with current data from Overpass API
                $location->overpass_data = $overpassData->toArray();
                $location->save();
            } else {
                $location = Location::fromOverpassData($overpassData);
            }
            // Add location to the result
            array_push($result, $location);
        }

        return LocationResource::collection($result);
    }
}
