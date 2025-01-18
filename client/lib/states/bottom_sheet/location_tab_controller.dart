import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<LocationTabState> locationTabControllerProvider =
    ChangeNotifierProvider<LocationTabState>((Ref<LocationTabState> ref) {
  return LocationTabState();
});

class LocationTabState extends ChangeNotifier {
  LocationTabState();

  TabController? controller;

  void init(TickerProvider vsync) {
    controller ??= TabController(length: 4, vsync: vsync);
  }

  void update(int index) {
    controller?.index = index;
    notifyListeners();
  }
}
