import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<OverPassResultsState> overpassResultsProvider =
    ChangeNotifierProvider<OverPassResultsState>(
        (Ref<OverPassResultsState> ref) {
  return OverPassResultsState();
});

class OverPassResultsState extends ChangeNotifier {
  OverPassResultsState();

  List<OverpassData> results = List<OverpassData>.empty();

  void update(List<OverpassData> results) {
    this.results = results;
    notifyListeners();
  }
}
