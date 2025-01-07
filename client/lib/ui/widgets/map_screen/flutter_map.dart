import 'package:cached_network_image/cached_network_image.dart';
import 'package:floob/config/style.dart';
import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:floob/states/controllers/open_street_map_controller.dart';
import 'package:floob/ui/widgets/map_screen/location_list_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:unicons/unicons.dart';

class MapWidget extends ConsumerStatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends ConsumerState<MapWidget> {
  final MapController mapController = MapController();
  List<Marker> markers = <Marker>[];

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

          // Add Popup with nearby places in GUI
          Marker onTapMarker = _buildOnTapMarker(point, result);
          // Do as little code as possible in the setState function!
          setState(() {
            markers = <Marker>[onTapMarker];
          });
        },
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const <String>['a', 'b', 'c'],
          tileProvider: AppMapTileProvider(),
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  // The popover that is rendered when tapping the map. Shows the nearby places.
  Marker _buildOnTapMarker(LatLng point, List<OverpassData> elements) {
    return Marker(
      point: point,
      alignment: Alignment.bottomCenter,
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: <Widget>[
          Transform(
            transform: Matrix4.identity()..scale(1.0, -.8),
            child: Icon(
              UniconsSolid.triangle,
              color: Theme.of(context).colorScheme.surfaceContainer,
              size: 36,
            ),
          ),
          Positioned(
            bottom: 48,
            width: clampDouble(MediaQuery.of(context).size.width / 4, 304, 999),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Style.radiusMd),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  // Divider between results
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(height: 1);
                  },
                  itemCount: elements.isEmpty ? 1 : elements.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Empty state
                    if (elements.isEmpty) {
                      return const ListTile(
                        title: Text('Nothing here...'),
                      );
                    }

                    return LocationListTile(location: elements[index]);
                  }),
            ),
          ),
        ],
      ),
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
