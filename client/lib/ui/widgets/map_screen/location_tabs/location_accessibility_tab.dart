import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/data/enums/accessibility_category.dart';
import 'package:floob/data/enums/accessibility_entry.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/ui/widgets/list_tile_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class LocationAccessibilityTab extends ConsumerWidget {
  const LocationAccessibilityTab({required this.location, super.key});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
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
        const SizedBox(height: 36),
        ..._renderExpansionTiles(context, ref),
        const SizedBox(height: 256),
      ],
    );
  }

  List<Widget> _renderExpansionTiles(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    // Possible icons - remove for random
    List<Icon> icons = <Icon>[
      const Icon(UniconsLine.question_circle, color: Colors.grey),
      const Icon(UniconsLine.check_circle, color: Colors.green),
      const Icon(UniconsLine.times_circle, color: Colors.red),
    ];

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
        int iconIndex = 0;
        switch (location.accessibility?[entry.name]?['value']) {
          case null:
            iconIndex = 0;
          case true:
            iconIndex = 1;
            categoryCount++;
          case false:
            iconIndex = 2;
        }

        categoryTiles.add(ListTile(
          leading: icons[iconIndex],
          title: Text(tr('accessibility_entry_${entry.name}')),
          subtitle: location.accessibility?[entry.name]?['trusted'] == false
              ? Text(
                  'Unzuverlässig!',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.colorScheme.primary),
                )
              : null,
        ));
      }

      result.add(
        ExpansionTile(
          initiallyExpanded: true,
          collapsedShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Style.radiusMd)),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Style.radiusMd)),
          backgroundColor: theme.colorScheme.surface,
          collapsedBackgroundColor: theme.colorScheme.surface,
          title: Text(
            '${tr("accessibility_category_${category.name}")} ($categoryCount/${entries.length})',
            style: theme.textTheme.titleMedium,
          ),
          children: categoryTiles,
        ),
      );
      result.add(const SizedBox(height: 36));
    }

    return result;
  }
}
