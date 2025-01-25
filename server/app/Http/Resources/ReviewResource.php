<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ReviewResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'location_id' => $this->location_id,
            'location' => $this->whenLoaded('location', fn () => LocationResource::make($this->location), null),
            'user_id' => $this->user_id,
            'user' => UserResource::make($this->user),
            'score' => $this->score,
            'text' => $this->text,
            'created_at' => $this->created_at,
        ];
    }
}
