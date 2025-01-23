import 'package:floob/data/models/location.dart';
import 'package:floob/ui/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class LocationMediaTab extends ConsumerStatefulWidget {
  const LocationMediaTab({required this.location, super.key});

  final Location location;

  @override
  LocationMediaTabState createState() => LocationMediaTabState();
}

// TODO actually try loading media
class LocationMediaTabState extends ConsumerState<LocationMediaTab> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 36),
        Center(
          child: EmptyState(
            icon: UniconsLine.image_slash,
            iconSize: 64,
            title: 'Keine Medien vorhanden',
            subtitle: 'Bilder, Videos und Audiodateien werden hier angezeigt.',
          ),
        ),
      ],
    );
  }
}
