import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  final MapController mapController = MapController();

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: const MapOptions(
        initialCenter: LatLng(30.3753, 69.3451),
        initialZoom: 5,
      ),
      children: [
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
