import 'package:floob/config/style.dart';
import 'package:floob/data/enums/accessibility_category.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
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
            UniconsLine.check_circle,
            color: Colors.red,
          ),
          title: Text('Bedinung nicht erfüllt'),
        ),
        const ListTileX(
          leading: Icon(
            UniconsLine.check_circle,
            color: Colors.grey,
          ),
          title: Text('Weiß nicht/keine Angabe'),
        ),
        const SizedBox(height: 36),
        ..._renderExpansionTiles(context, ref)
      ],
    );
  }

  List<Widget> _renderExpansionTiles(BuildContext context, WidgetRef ref) {
    List<Widget> result = List<Widget>.empty();

    for (AccessibilityCategory category in AccessibilityCategory.values) {
      print(category);
      // Todo Build based on enums
    }

    return [
      ExpansionTile(
        initiallyExpanded: true,
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Wege (7/9)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const <Widget>[
          ListTile(title: Text('Todo')),
        ],
      ),
      const SizedBox(height: 36),
      ExpansionTile(
        initiallyExpanded: true,
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Türen (2/4)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const <Widget>[
          ListTile(title: Text('Todo')),
        ],
      ),
      const SizedBox(height: 36),
      ExpansionTile(
        initiallyExpanded: true,
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Treppen & Aufzüge (6/8)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const <Widget>[
          ListTile(title: Text('Todo')),
        ],
      ),
      const SizedBox(height: 36),
      ExpansionTile(
        initiallyExpanded: true,
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'WC (4/5)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const <Widget>[
          ListTile(title: Text('Todo')),
        ],
      ),
      const SizedBox(height: 36),
      ExpansionTile(
        initiallyExpanded: true,
        collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Style.radiusMd)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        collapsedBackgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Mobilität (2/3)',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: const <Widget>[
          ListTile(title: Text('Todo')),
        ],
      ),
    ];
  }
}
