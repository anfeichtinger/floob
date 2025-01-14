<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class LocationResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $reviews = $this->whenLoaded('reviews');
        $reviewCount = $this->reviews->count() ?? 0;
        $reviewScore = $this->reviews->avg('score') ?? 0;

        return [
            'id' => $this->id,
            'overpass_id' => $this->overpass_id,
            'latitude' => $this->latitude,
            'longitude' => $this->longitude,
            'name' => $this->name,
            'website' => $this->website,
            'opening_times' => $this->opening_times,
            'overpass_data' => $this->overpass_data,
            'reviews' => $reviews,
            'review_count' => $reviewCount,
            'review_score' => $reviewScore,
        ];
    }
}
