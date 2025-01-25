<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Review>
 */
class ReviewFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'score' => fake()->randomFloat(0, 1, 5),
            'text' => fake()->realText(),
            'created_at' => fake()->dateTimeBetween('2024-12-01', '2025-01-29'),
        ];
    }
}
