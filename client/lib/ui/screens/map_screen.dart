import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/config/style.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/screens/menu/menu_screen.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/app_bar_gone.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/bottom_sheet_handle.dart';
import 'package:flutter_production_boilerplate_riverpod/utils/route_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapScreen extends ConsumerWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: const Stack(
        children: <Widget>[
          OpenStreetMapWidget(),
          BottomSheetWidget(),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

/// Placeholder for the OpenStreetMap
class OpenStreetMapWidget extends StatelessWidget {
  const OpenStreetMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      child: const Center(
        child: Text(
          'Open Street Map here',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

/// Bottom Sheet
class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      snap: true,
      snapSizes: const <double>[.15, .7, 1],
      shouldCloseOnMinExtent: false,
      // On mobile only show search bar. On others take more space as drag does not work.
      initialChildSize: Platform.isAndroid || Platform.isIOS ? 0.15 : 0.4,
      minChildSize: 0.15,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Card(
            elevation: 12.0,
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Style.radiusLg,
                topRight: Style.radiusLg,
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
              ),
            ),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: <Widget>[
                // Drag handle
                const BottomSheetHandle(),
                const SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // Search
                    Expanded(
                      child: TextFormField(
                        maxLines: 1,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'Search here',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Style.radiusMd),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Profile
                    SizedBox(
                      height: 64,
                      width: 64,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () {
                          // Navigate to MenuScreen
                          Navigator.of(context).push(animatedRoute(
                            const MenuScreen(),
                            type: RouteAnimationType.fromBottom,
                          ));
                        },
                        child: CircleAvatar(
                          radius: double.infinity,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: MediaQuery.of(context).size.height / 1.2,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Style.radiusMd),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
