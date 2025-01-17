import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<LocationBottomSheetController>
    locationBottomSheetControllerProvider =
    ChangeNotifierProvider<LocationBottomSheetController>(
        (Ref<LocationBottomSheetController> ref) {
  return LocationBottomSheetController();
});

class LocationBottomSheetController extends ChangeNotifier {
  LocationBottomSheetController() {
    controller ??= DraggableScrollableController();
  }

  DraggableScrollableController? controller;

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }
}
