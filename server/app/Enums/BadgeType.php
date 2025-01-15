<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;

enum BadgeType: string
{
    use EnumEnhancements;

    // Write reviews
    case REVIEW_1 = 'review_1';
    case REVIEW_5 = 'review_5';
    case REVIEW_10 = 'review_10';

    // Enter accessibility data for location
    case DATA_ENTRY_1 = 'data_entry_1';
    case DATA_ENTRY_5 = 'data_entry_5';
    case DATA_ENTRY_10 = 'data_entry_10';

    // TODO: F-97
}
