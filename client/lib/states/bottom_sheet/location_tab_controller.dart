import 'package:floob/config/style.dart';
import 'package:floob/states/map/bottom_navigation_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<LocationTabState> locationTabControllerProvider =
    ChangeNotifierProvider<LocationTabState>((Ref<LocationTabState> ref) {
  return LocationTabState(ref);
});

class LocationTabState extends ChangeNotifier {
  LocationTabState(this.ref);

  Ref<LocationTabState> ref;
  TabController? controller;

  void init(TickerProvider vsync) {
    controller ??= TabController(length: 4, vsync: vsync);
  }

  void update(BuildContext context, int index) {
    controller?.animateTo(index);

    // Show the report wrong data button at accessibility tab
    ref.read(bottomNavigationBarControllerProvider).update(index == 1
        ? Container(
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(Style.notImplementedSnackbar);
                },
                child: const Text('Falsche Daten melden'),
              ),
            ),
          )
        : null);

    notifyListeners();
  }
}
