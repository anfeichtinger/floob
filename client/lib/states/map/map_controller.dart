import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<MapControllerState> mapControllerProvider =
    ChangeNotifierProvider<MapControllerState>((Ref<MapControllerState> ref) {
  return MapControllerState();
});

class MapControllerState extends ChangeNotifier {
  MapControllerState() {
    controller ??= MapController();
  }

  MapController? controller;

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }
}
