<?php

namespace Database\Seeders;

use App\Models\Location;
use App\Models\Review;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        $users = User::factory(3)->create();

        // Create a real location
        $location = Location::factory(1)->create([
            'overpass_id' => 37064372,
            'latitude' => 47.0690121,
            'longitude' => 15.4062616,
            'name' => 'FH Joanneum',
            'website' => 'https://www.fh-joanneum.at/',
        ]);

        // Create some reviews for the location
        // Todo - Write some real text for the reviews.
        $review1 = Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
        ]);
        $review2 = Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
        ]);
        $review3 = Review::factory(1)->create([
            'location_id' => $location->first()->id,
            'user_id' => $users->random()->id,
        ]);
    }
}
