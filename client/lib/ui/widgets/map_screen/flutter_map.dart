import 'package:cached_network_image/cached_network_image.dart';
import 'package:floob/states/bottom_sheet/search_text_controller.dart';
import 'package:floob/states/bottom_sheet/bottom_sheet_controller.dart';
import 'package:floob/states/map/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends ConsumerStatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends ConsumerState<MapWidget> {
  final PopupController _popupLayerController = PopupController();
  List<Marker> markers = <Marker>[];

  @override
  void dispose() {
    _popupLayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final WidgetRef ref = context as WidgetRef;
    final MapController controller =
        ref.read(mapControllerProvider).controller!;

    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: const LatLng(47.0690121, 15.4062616), // FH Joanneum Graz
        initialZoom: 18,
        onTap: (TapPosition tapPosition, LatLng point) {
          // Center map around tap position
          controller.rotate(0);
          controller.move(point, 19,
              offset: Offset(0, MediaQuery.of(context).size.height / -3));

          // Extend bottom sheet to show results
          final DraggableScrollableController bottomSheetController =
              ref.read(bottomSheetControllerProvider).controller!;

          bottomSheetController.animateTo(.70,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear);

          final TextEditingController searchTextController =
              ref.read(searchTextControllerProvider).controller!;

          searchTextController.text = '°${point.latitude},°${point.longitude}';
        },
      ),
      children: <Widget>[
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const <String>['a', 'b', 'c'],
          tileProvider: AppMapTileProvider(),
        ),
        // MarkerLayer(markers: markers),
        PopupMarkerLayer(
          options: PopupMarkerLayerOptions(
            markers: markers,
            popupController: _popupLayerController,
          ),
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
