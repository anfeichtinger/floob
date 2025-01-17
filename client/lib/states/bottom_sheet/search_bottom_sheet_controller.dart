import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SearchBottomSheetController>
    searchBottomSheetControllerProvider =
    ChangeNotifierProvider<SearchBottomSheetController>(
        (Ref<SearchBottomSheetController> ref) {
  return SearchBottomSheetController();
});

class SearchBottomSheetController extends ChangeNotifier {
  SearchBottomSheetController() {
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
