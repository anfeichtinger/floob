import 'package:easy_localization/easy_localization.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/states/bottom_sheet/current_location_controller.dart';
import 'package:floob/states/bottom_sheet/location_bottom_sheet_controller.dart';
import 'package:floob/states/bottom_sheet/location_tab_controller.dart';
import 'package:floob/ui/widgets/map_screen/location_tabs/location_accessibility_tab.dart';
import 'package:floob/ui/widgets/map_screen/location_tabs/location_media_tab.dart';
import 'package:floob/ui/widgets/map_screen/location_tabs/location_overview_tab.dart';
import 'package:floob/ui/widgets/map_screen/location_tabs/location_ratings_tab.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floob/config/style.dart';
import 'package:floob/ui/widgets/bottom_sheet_handle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationBottomSheet extends ConsumerStatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  LocationTabViewState createState() => LocationTabViewState();
}

class LocationTabViewState extends ConsumerState<LocationBottomSheet>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    ref.read(locationTabControllerProvider).init(this);
  }

  @override
  Widget build(BuildContext context) {
    // To controll the bottom sheet size
    final DraggableScrollableController locationSheetController =
        ref.read(locationBottomSheetControllerProvider).controller!;

    // Listener to reset the tab controller on close
    locationSheetController.addListener(() {
      if (locationSheetController.pixels <= 2) {
        ref.read(locationTabControllerProvider).update(context, 0);
      }
    });

    // The location to show
    final Location? location = ref.watch(currentLocationProvider).location;

    return DraggableScrollableSheet(
      controller: locationSheetController,
      expand: true,
      snap: true,
      snapSizes: const <double>[0, .25, .93, 1],
      shouldCloseOnMinExtent: false,
      initialChildSize: 0,
      minChildSize: 0,
      builder: (BuildContext context, ScrollController scrollController) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context)
              .copyWith(dragDevices: <PointerDeviceKind>{
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          }),
          child: SingleChildScrollView(
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
                  const BottomSheetHandle(),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 54,
                    ),
                    child: _renderHeader(context, location),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _renderHeader(BuildContext context, Location? location) {
    if (location == null) {
      return const Text('No location given...');
    }

    final LocationTabState tabControllerProvider =
        ref.watch(locationTabControllerProvider);

    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Header
            Expanded(
              child: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Text(
                  location.name!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            // const SizedBox(width: 24),
            // IconButton(
            //   onPressed: () {},
            //   icon: const Icon(
            //     UniconsLine.location_arrow,
            //     color: Colors.black,
            //     size: 30.0,
            //   ),
            //   style: ButtonStyle(
            //     backgroundColor:
            //         WidgetStateProperty.all<Color>(const Color(0xFFE0E0E0)),
            //     padding: WidgetStateProperty.all<EdgeInsets>(
            //       const EdgeInsets.all(10.0),
            //     ),
            //     shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            //       RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 4),

        // Tabs
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height,
            minWidth: 0,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: <Widget>[
                TabBar(
                  controller: tabControllerProvider.controller!,
                  onTap: (int index) {
                    tabControllerProvider.update(context, index);
                  },
                  tabAlignment: TabAlignment.start,
                  labelPadding: const EdgeInsets.all(12),
                  isScrollable: true,
                  tabs: <Widget>[
                    Text(tr('location_overview_title')),
                    Text(tr('location_accessibility_title')),
                    Text(tr('location_ratings_title')),
                    Text(tr('location_media_title')),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabControllerProvider.controller!,
                    physics: const RangeMaintainingScrollPhysics(),
                    children: <Widget>[
                      LocationOverviewTab(location: location),
                      LocationAccessibilityTab(location: location),
                      LocationRatingsTab(location: location),
                      LocationMediaTab(location: location),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
