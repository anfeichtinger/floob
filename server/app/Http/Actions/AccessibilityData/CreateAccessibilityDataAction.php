<?php

namespace App\Http\Actions\AccessibilityData;

use App\Models\AccessibilityData;

class CreateAccessibilityDataAction
{
    public static function handle(array $data): AccessibilityData
    {
        $accessibility = new AccessibilityData;
        $accessibility->location()->associate($data['location_id'] ?? 0);
        $accessibility->user()->associate($data['user_id'] ?? 0);
        $accessibility->category = $data['category']?->value;
        $accessibility->entry = $data['entry']?->value;
        $accessibility->value = ($data['value'] ?? 'false') === 'true';
        $accessibility->save();

        return $accessibility;
    }
}
