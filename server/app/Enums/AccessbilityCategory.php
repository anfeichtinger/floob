<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;

enum AccessbilityCategory: string
{
    use EnumEnhancements;

    case PATHS = 'paths';
    case DOORS = 'doors';
    case STAIRS = 'stairs';
    case RESTROOMS = 'restrooms';
    case MOBILITY = 'mobility';
}
