import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<BottomNavigationBarController>
    bottomNavigationBarControllerProvider =
    ChangeNotifierProvider<BottomNavigationBarController>(
        (Ref<BottomNavigationBarController> ref) {
  return BottomNavigationBarController();
});

class BottomNavigationBarController extends ChangeNotifier {
  BottomNavigationBarController();

  Widget? widget;

  void update(Widget? widget) {
    this.widget = widget;
    notifyListeners();
  }

  @override
  void dispose() {
    widget = null;
    super.dispose();
  }
}
