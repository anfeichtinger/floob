<?php

namespace App\Services\OpenStreetMap\Models;

use App\Http\DTOs\AddressData;
use Spatie\LaravelData\Data;

class OverpassData extends Data
{
    public function __construct(
        public ?int $id = null,
        public ?float $lat = null,
        public ?float $lon = null,
        public ?string $name = null,
        public ?string $website = null,
        public ?AddressData $address = null,
    ) {}

    public static function fromOverpassResponseElement(array $data, ?LatLng $point = null): self
    {
        // Prepare some data for the Address
        $street = $data['tags']['addr:street'] ?? null;
        $houseNumber = $data['tags']['addr:housenumber'] ?? null;
        if ($street && $houseNumber) {
            $street .= " $houseNumber";
        }

        // Build the Address
        $address = new AddressData(
            country: $data['tags']['addr:country'] ?? null,
            state: null,
            city: $data['tags']['addr:city'] ?? null,
            post_code: $data['tags']['addr:postcode'] ?? null,
            street: $street,
        );

        // Build the final object
        return new self(
            id: $data['id'] ?? null,
            lat: array_key_exists('lat', $data) ? floatval($data['lat'] ?? null) : $point?->latitude ?? null,
            lon: array_key_exists('lon', $data) ? floatval($data['lon'] ?? null) : $point?->longitude ?? null,
            name: $data['tags']['name'] ?? $address?->format() ?? null,
            website: $data['tags']['website'] ?? null,
            address: $address
        );
    }
}
