<?php

namespace App\Enums;

use App\Traits\EnumEnhancements;
use Illuminate\Support\Str;

enum AccessbilityEntry: string
{
    use EnumEnhancements;

    // PATHS
    case PATHS_WELL_LIT = 'paths_well_lit';
    case PATHS_NO_STEPS_OR_ANGLES = 'paths_no_steps_or_angles';
    case PATHS_HAS_RAMP = 'paths_has_ramp';
    case PATHS_RAMP_FITS_TWO_WHEELCHAIRS = 'paths_ramp_fits_two_wheelchairs';
    case PATHS_RAMP_HAS_HANDLE = 'paths_ramp_has_handle';
    case PATHS_HARD_FLOORING = 'paths_hard_flooring';
    case PATHS_VISUAL_GUIDESYSTEM = 'paths_visual_guidesystem';
    case PATHS_HAPTIC_GUIDESYSTEM = 'paths_haptic_guidesystem';
    case PATHS_FITS_TWO_WHEELCHAIRS = 'paths_fits_two_wheelchairs';

    // DOORS
    case DOORS_DOORSTEP_HEIGHT = 'doors_doorstep_height';
    case DOORS_NO_TURNING_HANDLES = 'doors_no_turning_handles';
    case DOORS_AUTOMATIC_MAIN_ENTRANCE = 'doors_automatic_main_entrance';
    case DOORS_EXTRA_ENTRANCE = 'doors_extra_entrance';

    // STAIRS
    case STAIRS_HAVE_HANDLE = 'stairs_have_handle';
    case STAIRS_HAVE_CONTRAST_MARKINGS = 'stairs_have_contrast_markings';
    case STAIRS_NO_METAL_MESH = 'stairs_no_metal_mesh';
    case ELEVATORS_FREE_SPACE_IN_FRONT = 'elevators_free_space_in_front';
    case ELEVATORS_MIRROR_IN_BACK = 'elevators_mirror_in_back';
    case ELEVATORS_BUTTONS_REACHABLE = 'elevators_buttons_reachable';
    case ELEVATORS_BUTTONS_BRAILLE = 'elevators_buttons_braille';
    case ELEVATORS_ACOUSTIC_FEEDBACK = 'elevators_acoustic_feedback';

    // RESTROOMS
    case RESTROOMS_ACCESSIBLE = 'restrooms_accessible';
    case RESTROOMS_HAVE_HANDLES = 'restrooms_have_handles';
    case RESTROOMS_HAVE_ALARM = 'restrooms_have_alarm';
    case RESTROOMS_SOAP_ONE_HANDED = 'restrooms_soap_one_handed';

    // MOBILITY
    case MOBILITY_CLOSE_PUBLIC_TRANS = 'mobility_close_public_trans';
    case MOBILITY_OWN_ACCESSIBLE_PARKING = 'mobility_own_accessible_parking';
    case MOBILITY_PUBLIC_ACCESSIBLE_PARKING = 'mobility_public_accessible_parking';

    /**
     * Get the category of a specific entry statically.
     */
    public static function getCategory(null|string|self $entry): ?AccessbilityCategory
    {
        $string = strtoupper($entry?->value ?? $entry);
        if (Str::startsWith($string, 'PATHS')) {
            return AccessbilityCategory::PATHS;
        } elseif (Str::startsWith($string, 'DOORS')) {
            return AccessbilityCategory::DOORS;
        } elseif (Str::startsWith($string, 'STAIRS') || Str::startsWith($string, 'ELEVATORS')) {
            return AccessbilityCategory::STAIRS;
        } elseif (Str::startsWith($string, 'RESTROOMS')) {
            return AccessbilityCategory::RESTROOMS;
        } elseif (Str::startsWith($string, 'MOBILITY')) {
            return AccessbilityCategory::MOBILITY;
        } else {
            return null;
        }
    }

    /**
     * Get the category of the current entry.
     */
    public function toCategory(): ?AccessbilityCategory
    {
        return self::getCategory($this);
    }
}
