import 'package:floob/data/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationOverviewTab extends ConsumerWidget {
  const LocationOverviewTab({required this.location, super.key});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 24),
        Text('Allgemein', style: Theme.of(context).textTheme.titleMedium),
        Text('TODO for ${location.name}'),
        const SizedBox(height: 64),
        Text('Merkmale', style: Theme.of(context).textTheme.titleMedium),
        Text('TODO for ${location.name}'),
        const SizedBox(height: 64),
        Text('Erfahrungsberichte',
            style: Theme.of(context).textTheme.titleMedium),
        Text('TODO for ${location.name}'),
        const SizedBox(height: 64),
        Text('Medien', style: Theme.of(context).textTheme.titleMedium),
        Text('TODO for ${location.name}'),
      ],
    );
  }
}
