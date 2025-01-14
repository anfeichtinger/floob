<?php

namespace App\Services\OpenStreetMap\Models;

class LatLng
{
    public function __construct(public float $latitude, public float $longitude)
    {
        //
    }
}
