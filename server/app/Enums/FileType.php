<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;

enum FileType: string
{
    use EnumEnhancements;

    case AVATAR = 'avatar';

    // TODO: F-98
}
