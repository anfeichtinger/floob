<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Location>
 */
class LocationFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'overpass_id' => fake()->biasedNumberBetween(1000000000, 9999999999),
            'latitude' => fake()->latitude(),
            'longitude' => fake()->longitude(),
            'name' => fake()->name(),
            'website' => fake()->url(),
        ];
    }
}
