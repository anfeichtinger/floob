import 'package:floob/data/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<CurrentLocationState> currentLocationProvider =
    ChangeNotifierProvider<CurrentLocationState>(
        (Ref<CurrentLocationState> ref) {
  return CurrentLocationState();
});

class CurrentLocationState extends ChangeNotifier {
  CurrentLocationState();

  Location? location;

  void update(Location newLocation) {
    location = newLocation;
    notifyListeners();
  }
}
