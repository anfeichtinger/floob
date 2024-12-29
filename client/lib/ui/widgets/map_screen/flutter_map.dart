import 'package:cached_network_image/cached_network_image.dart';
import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:floob/states/controllers/open_street_map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends ConsumerStatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends ConsumerState<MapWidget> {
  final MapController mapController = MapController();

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WidgetRef ref = context as WidgetRef;
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: const LatLng(47.0690121, 15.4062616), // FH Joanneum Graz
        initialZoom: 18,
        onTap: (TapPosition tapPosition, LatLng point) async {
          final List<OverpassData> result = await ref
              .read(openStreetMapControllerProvider)
              .fetchFeatures(point);

          print('\n\nNearby places:');
          for (OverpassData data in result) {
            print(data.name);
          }
        },
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const <String>['a', 'b', 'c'],
          tileProvider: AppMapTileProvider(),
        ),
      ],
    );
  }
}

class AppMapTileProvider extends TileProvider {
  @override
  Map<String, String> get headers => <String, String>{
        'User-Agent': 'floob',
      };

  @override
  ImageProvider<Object> getImage(
      TileCoordinates coordinates, TileLayer options) {
    String tileUrl = getTileUrl(coordinates, options);
    return CachedNetworkImageProvider(tileUrl, headers: headers);
  }
}
