<?php

namespace App\Services\OpenStreetMap;

use App\Services\OpenStreetMap\Models\LatLng;
use App\Services\OpenStreetMap\Models\OverpassResponse;
use Illuminate\Support\Facades\Http;

class OverpassApi
{
    public static string $baseUrl = 'https://overpass-api.de/api';

    public static function fetchFeatures(LatLng $point, int $radius = 20): ?OverpassResponse
    {
        $url = static::$baseUrl . '/interpreter';
        $query = "
        [out:json];
        (
          node[\"building\"](around:$radius, {$point->latitude}, {$point->longitude});
          way[\"building\"](around:$radius, {$point->latitude}, {$point->longitude});
          relation[\"building\"](around:$radius, {$point->latitude}, {$point->longitude});

          node[\"office\"](around:$radius, {$point->latitude}, {$point->longitude});
          way[\"office\"](around:$radius, {$point->latitude}, {$point->longitude});
          relation[\"office\"](around:$radius, {$point->latitude}, {$point->longitude});

          node[\"amenity\"](around:$radius, {$point->latitude}, {$point->longitude});
          way[\"amenity\"](around:$radius, {$point->latitude}, {$point->longitude});
          relation[\"amenity\"](around:$radius, {$point->latitude}, {$point->longitude});

          node[\"shop\"](around:$radius, {$point->latitude}, {$point->longitude});
          way[\"shop\"](around:$radius, {$point->latitude}, {$point->longitude});
          relation[\"shop\"](around:$radius, {$point->latitude}, {$point->longitude});
        );
        out body;
        ";

        $response = Http::timeout(10)->asForm()->post($url, ['data' => $query]);

        if ($response->successful()) {
            return new OverpassResponse(
                point: $point,
                elements: $response->json('elements') ?? [],
            );
        } else {
            return null;
        }
    }
}
