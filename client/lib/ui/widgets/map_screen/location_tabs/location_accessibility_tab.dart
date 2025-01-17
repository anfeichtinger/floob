import 'package:floob/data/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        Text('TODO for ${location.name}'),
      ],
    );
  }
}
