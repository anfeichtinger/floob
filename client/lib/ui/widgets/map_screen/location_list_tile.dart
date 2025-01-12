import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:flutter/material.dart';

class LocationListTile extends StatelessWidget {
  const LocationListTile({required this.location, super.key});

  final OverpassData location;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // Image
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Text('x'),
      ),
      // Title - name of the location
      title: Text(
        location.name ?? 'No name',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      // Todo: additional data and actions
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Additional data
          const Text('Todo'),
          // Actions - Todo: fix possibility to click buttons (layer issue)
          // https://github.com/rorystephenson/flutter_map_marker_popup
          Row(
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    print('Toto open in bottom sheet');
                  },
                  child: const Text('Details')),
              TextButton(
                  onPressed: () {
                    print('Todo navigate to new entry with data');
                  },
                  child: const Text('Neuer Eintrag')),
            ],
          ),
        ],
      ),
    );
  }
}
