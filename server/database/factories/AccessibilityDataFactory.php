<?php

namespace Database\Factories;

use App\Enums\AccessibilityCategory;
use App\Enums\AccessibilityEntry;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\AccessibilityData>
 */
class AccessibilityDataFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'category' => fake()->randomElement(AccessibilityCategory::toArray()),
            'entry' => fake()->randomElement(AccessibilityEntry::toArray()),
            'value' => fake()->boolean(75),
        ];
    }
}
