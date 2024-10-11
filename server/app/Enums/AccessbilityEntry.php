<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;

enum AccessbilityEntry: string
{
    use EnumEnhancements;

    // DOORS
    case DOORSTEP_HEIGHT = 'doorstep_height';
    case NO_TURNING_HANDLES = 'no_turning_handles';
    case AUTOMATIC_MAIN_ENTRANCE = 'automatic_main_entrance';
    case EXTRA_ENTRANCE = 'extra_entrance';

    // TODO
}
