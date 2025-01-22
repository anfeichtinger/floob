import 'package:floob/states/map/bottom_navigation_bar_controller.dart';
import 'package:floob/ui/widgets/map_screen/location_bottom_sheet.dart';
import 'package:floob/ui/widgets/map_screen/search_bottom_sheet.dart';
import 'package:floob/ui/widgets/map_screen/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget? bottomNavigationBar =
        ref.watch(bottomNavigationBarControllerProvider).widget;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: const Stack(
        children: <Widget>[
          MapWidget(),
          SearchBottomSheet(),
          LocationBottomSheet(),
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
