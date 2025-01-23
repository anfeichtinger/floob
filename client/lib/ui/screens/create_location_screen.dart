import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/data/enums/accessibility_category.dart';
import 'package:floob/data/enums/accessibility_entry.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/states/bottom_sheet/current_location_controller.dart';
import 'package:floob/states/bottom_sheet/location_bottom_sheet_controller.dart';
import 'package:floob/states/bottom_sheet/search_bottom_sheet_controller.dart';
import 'package:floob/states/bottom_sheet/search_text_controller.dart';
import 'package:floob/states/controllers/location_controller.dart';
import 'package:floob/states/map/map_controller.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:floob/ui/widgets/list_tile_x.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_map/src/map/controller/map_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:unicons/unicons.dart';

class CreateLocationScreen extends ConsumerStatefulWidget {
  const CreateLocationScreen({required this.location, super.key});

  final Location location;

  @override
  CreateLocationScreenState createState() => CreateLocationScreenState();
}

class CreateLocationScreenState extends ConsumerState<CreateLocationScreen> {
  Map<String, String> accessibility = <String, String>{};
  CurrentLocationState? currentLocationState;
  bool isPopping = false;

  @override
  void initState() {
    super.initState();

    Map<String, String> initAccessibility = <String, String>{
      for (AccessibilityEntry entry in AccessibilityEntry.values)
        entry.name: 'null',
    };

    setState(() {
      accessibility = initAccessibility;
    });
  }

  @override
  Widget build(BuildContext context) {
    currentLocationState = ref.watch(currentLocationProvider);

    const TextStyle textStyle = TextStyle(
        fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.bold);

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: Stack(
        children: <Widget>[
          // ===============================
          // |           Content           |
          // ===============================
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Header(
                text: widget.location.name ?? 'Unbekannter Ort',
                hasBackAction: true,
              ),
              // Legend
              Text(
                'Bewertung nach Kategorien',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              const ListTileX(
                leading: Icon(
                  UniconsLine.check_circle,
                  color: Colors.green,
                ),
                title: Text('Bedinung erfüllt'),
              ),
              const ListTileX(
                before: SizedBox(height: 6),
                after: SizedBox(height: 6),
                leading: Icon(
                  UniconsLine.times_circle,
                  color: Colors.red,
                ),
                title: Text('Bedinung nicht erfüllt'),
              ),
              const ListTileX(
                leading: Icon(
                  UniconsLine.question_circle,
                  color: Colors.grey,
                ),
                title: Text('Weiß nicht/keine Angabe'),
              ),
              // Expansion Tiles
              const SizedBox(height: 24),
              ..._renderExpansionTiles(context, ref),
              const SizedBox(height: 256),
            ],
          ),
          // ===============================
          // |         Save button         |
          // ===============================
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: FilledButton(
                onPressed: () async {
                  final Location? result = await ref
                      .read(locationControllerProvider)
                      .putAccessibilityEntries(widget.location, accessibility);

                  if (mounted) {
                    setState(() {
                      if (result != null) {
                        // Set the current location to the saved one
                        currentLocationState!.update(result);
                        // To control the location bottom sheet
                        Navigator.of(context).pop();
                        ref
                            .read(locationBottomSheetControllerProvider)
                            .controller!
                            .animateTo(
                              .93,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear,
                            );
                        ref
                            .read(searchBottomSheetControllerProvider)
                            .controller!
                            .animateTo(
                              .000000001,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.linear,
                            );
                        ref
                            .read(searchTextControllerProvider)
                            .controller!
                            .text = '°${result.latitude},°${result.longitude}';

                        MapController? mapController =
                            ref.read(mapControllerProvider).controller;

                        mapController?.rotate(0);
                        mapController?.move(
                            LatLng(result.latitude!, result.longitude!), 19,
                            offset: Offset(
                                0, MediaQuery.of(context).size.height / -3));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ein Fehler ist aufgetreten')),
                        );
                      }
                    });
                  }
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(
                    const Size(double.infinity, 54),
                  ),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Style.radiusSm),
                    ),
                  ),
                ),
                child: Text(
                  'Speichern',
                  style: textStyle.copyWith(
                    fontSize: textStyle.fontSize! + 2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }

  // ===============================
  // |       Expansion Tiles       |
  // ===============================
  List<Widget> _renderExpansionTiles(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);

    // Build results
    List<Widget> result = List<Widget>.empty(growable: true);
    for (AccessibilityCategory category in AccessibilityCategory.values) {
      int categoryCount = 0;
      List<AccessibilityEntry> entries = AccessibilityEntry.values
          .where((AccessibilityEntry entry) =>
              entry.name.startsWith(category.name))
          .toList();

      List<Widget> categoryTiles = List<Widget>.empty(growable: true);

      for (AccessibilityEntry entry in entries) {
        if (accessibility[entry.name] == 'true') {
          categoryCount++;
        }
        if (categoryTiles.isNotEmpty) {
          categoryTiles.add(
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Divider(
                indent: 16,
                endIndent: 16,
                thickness: .5,
              ),
            ),
          );
        }
        categoryTiles.add(ListTileX(
          title: Text(tr('accessibility_entry_${entry.name}')),
          trailingPadding: const EdgeInsets.only(right: 8),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    accessibility[entry.name] = 'true';
                  });
                },
                icon: const Icon(UniconsLine.check_circle),
                color: accessibility[entry.name] == 'true'
                    ? Colors.green
                    : theme.colorScheme.onSurface.withValues(alpha: .25),
                padding: const EdgeInsets.all(2),
                constraints: const BoxConstraints(
                  maxWidth: 36,
                  maxHeight: 36,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    accessibility[entry.name] = 'false';
                  });
                },
                icon: const Icon(UniconsLine.times_circle),
                color: accessibility[entry.name] == 'false'
                    ? Colors.red
                    : theme.colorScheme.onSurface.withValues(alpha: .25),
                padding: const EdgeInsets.all(2),
                constraints: const BoxConstraints(
                  maxWidth: 36,
                  maxHeight: 36,
                ),
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  setState(() {
                    accessibility[entry.name] = 'null';
                  });
                },
                icon: const Icon(UniconsLine.question_circle),
                color: accessibility[entry.name] == 'null'
                    ? theme.colorScheme.onSurface.withValues(alpha: .75)
                    : theme.colorScheme.onSurface.withValues(alpha: .25),
                padding: const EdgeInsets.all(2),
                constraints: const BoxConstraints(
                  maxWidth: 36,
                  maxHeight: 36,
                ),
              ),
            ],
          ),
        ));
      }

      result.add(
        ExpansionTile(
          initiallyExpanded: false,
          collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Style.radiusMd)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Style.radiusMd)),
          backgroundColor: theme.colorScheme.surfaceContainer,
          collapsedBackgroundColor: theme.colorScheme.surfaceContainer,
          title: Text(
            '${tr("accessibility_category_${category.name}")} ($categoryCount/${entries.length})',
            style: theme.textTheme.titleMedium,
          ),
          children: categoryTiles,
        ),
      );
      result.add(const SizedBox(height: 24));
    }

    return result;
  }
}
