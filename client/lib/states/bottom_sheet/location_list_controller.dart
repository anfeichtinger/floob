import 'package:floob/data/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<LocationListState> locationListProvider =
    ChangeNotifierProvider<LocationListState>((Ref<LocationListState> ref) {
  return LocationListState();
});

class LocationListState extends ChangeNotifier {
  LocationListState();

  List<Location> results = List<Location>.empty();

  void update(List<Location> results) {
    this.results = results;
    notifyListeners();
  }
}
