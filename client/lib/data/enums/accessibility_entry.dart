// ignore_for_file: constant_identifier_names

enum AccessibilityEntry {
  // PATHS
  paths_well_lit,
  paths_no_steps_or_angles,
  paths_has_ramp,
  paths_ramp_fits_two_wheelchairs,
  paths_ramp_has_handle,
  paths_hard_flooring,
  paths_visual_guidesystem,
  paths_haptic_guidesystem,
  paths_fits_two_wheelchairs,

  // DOORS
  doors_doorstep_height,
  doors_no_turning_handles,
  doors_automatic_main_entrance,
  doors_extra_entrance,

  // STAIRS
  stairs_have_handle,
  stairs_have_contrast_markings,
  stairs_no_metal_mesh,
  elevators_free_space_in_front,
  elevators_mirror_in_back,
  elevators_buttons_reachable,
  elevators_buttons_braille,
  elevators_acoustic_feedback,

  // RESTROOMS
  restrooms_accessible,
  restrooms_have_handles,
  restrooms_have_alarm,
  restrooms_soap_one_handed,

  // MOBILITY
  mobility_close_public_trans,
  mobility_own_accessible_parking,
  mobility_public_accessible_parking,
}
