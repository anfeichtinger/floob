import 'dart:io';
import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:floob/states/bottom_sheet/bottom_sheet_controller.dart';
import 'package:floob/states/bottom_sheet/overpass_results_controller.dart';
import 'package:floob/states/bottom_sheet/search_text_controller.dart';
import 'package:floob/states/controllers/open_street_map_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floob/config/style.dart';
import 'package:floob/ui/screens/menu/menu_screen.dart';
import 'package:floob/ui/widgets/bottom_sheet_handle.dart';
import 'package:floob/utils/route_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class BottomSheetWidget extends ConsumerWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // To controll the bottom sheet size
    final DraggableScrollableController controller =
        ref.read(bottomSheetControllerProvider).controller!;

    // To controll the search text field
    final TextEditingController searchController =
        ref.watch(searchTextControllerProvider).controller!;

    // When the field is changed run the search again
    searchController
        .addListener(() => _onSearchChanged(searchController.text, ref));

    // The overpass results to show
    final List<OverpassData> results =
        ref.watch(overpassResultsProvider).results;

    return DraggableScrollableSheet(
      controller: controller,
      expand: true,
      snap: true,
      snapSizes: const <double>[.15, .7, 1],
      shouldCloseOnMinExtent: false,
      initialChildSize:
          !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? 0.15 : 0.4,
      minChildSize: 0.15,
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
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: searchController,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            hintText: 'Search here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Style.radiusMd),
                            ),
                          ),
                          onChanged: (String text) =>
                              _onSearchChanged(text, ref),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
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
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 128,
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 1);
                      },
                      itemCount: results.isEmpty ? 1 : results.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0 && results.isEmpty) {
                          return const Text('Keine Ergebnisse...');
                        }
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                height: 64,
                                width: 64,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      const BorderRadius.all(Style.radiusSm),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                results[index].name ?? 'Kein Name...',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      RatingBarIndicator(
                                        itemCount: 5,
                                        itemSize: 20,
                                        rating: 4,
                                        itemBuilder:
                                            (BuildContext context, _) =>
                                                const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      const Text('(4.0)'),
                                    ],
                                  ),
                                  const Text('geteilte Erfahrungen: 3'),
                                  Text('Barrierefreiheit: 96%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.green)),
                                ],
                              ),
                            ),
                            // Actions
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () => print('Todo details'),
                                  child: const Text('Details anzeigen'),
                                ),
                                TextButton(
                                  onPressed: () => print('Todo entry'),
                                  child: const Text('Neuer Eintrag'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSearchChanged(String text, WidgetRef ref) async {
    if (text.contains('°')) {
      // Prepare text
      text = text.replaceAll('°', '');
      List<String> split = text.split(',');

      // When there is only one coordinate search as words instead.
      if (split.length != 2) {
        _onSearchChanged(text, ref);
        return;
      }

      // Parse to LatLng
      final LatLng point = LatLng(
          double.tryParse(split[0]) ?? 0, double.tryParse(split[1]) ?? 0);

      // If the LatLng seems strange search as words instead.
      if (point.latitude == 0 || point.longitude == 0) {
        _onSearchChanged(text, ref);
        return;
      }

      // Fetch results
      final List<OverpassData> results =
          await ref.read(openStreetMapControllerProvider).fetchFeatures(point);

      // Set results
      ref.read(overpassResultsProvider).update(results);
    } else {
      print('Todo: Search by words');
    }
  }
}
