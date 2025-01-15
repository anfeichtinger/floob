<?php

namespace App\Services\OpenStreetMap\Models;

use ArrayAccess;
use Illuminate\Support\Collection;
use Spatie\LaravelData\Data;

class OverpassResponse extends Data
{
    public function __construct(
        public ?LatLng $point = null,
        public Collection|ArrayAccess|array $elements = [],
    ) {
        // Ensure $elements is a Collection
        if (!($elements instanceof Collection)) {
            $this->elements = Collection::make($elements);
        }

        // Parse the elements to objects
        foreach ($this->elements as $index => $element) {
            $this->elements[$index] = OverpassData::fromOverpassResponseElement($element, point: $this->point);
        }
    }
}
