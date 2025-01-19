<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;

enum AccessibilityCategory: string
{
    use EnumEnhancements;

    case PATHS = 'paths';
    case DOORS = 'doors';
    case STAIRS = 'stairs';
    case RESTROOMS = 'restrooms';
    case MOBILITY = 'mobility';

    /**
     * Creates an array where the keys are the categories and
     * the respective entries are the values.
     */
    public static function withEntries(): array
    {
        $result = [];
        foreach (AccessibilityEntry::cases() as $entry) {
            $result[$entry->toCategory()?->value ?? 'unknown'][] = $entry->value;
        }

        return $result;
    }
}
