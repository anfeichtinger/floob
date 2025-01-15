import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<BottomSheetControllerState>
    bottomSheetControllerProvider =
    ChangeNotifierProvider<BottomSheetControllerState>(
        (Ref<BottomSheetControllerState> ref) {
  return BottomSheetControllerState();
});

class BottomSheetControllerState extends ChangeNotifier {
  BottomSheetControllerState() {
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
