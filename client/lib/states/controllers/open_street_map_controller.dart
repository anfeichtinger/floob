import 'dart:convert';

import 'package:floob/data/models/open_street_map/overpass_data.dart';
import 'package:floob/data/models/open_street_map/overpass_response.dart';
import 'package:floob/states/controllers/base_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

/// Define the provider with which we can access the controller in the view.
final Provider<OpenStreetMapController> openStreetMapControllerProvider =
    Provider<OpenStreetMapController>((Ref<Object?> ref) {
  return const OpenStreetMapController();
});

/// This class contains all possible api calls related to the open street map api.
class OpenStreetMapController extends BaseController {
  final String url = 'https://overpass-api.de/api/interpreter';

  const OpenStreetMapController();

  Future<List<OverpassData>> fetchFeatures(LatLng point,
      {int radius = 10}) async {
    // Overpass QL query
    final String query = '''
  [out:json];
  (
    node["building"](around:$radius, ${point.latitude}, ${point.longitude});
    way["building"](around:$radius, ${point.latitude}, ${point.longitude});
    relation["building"](around:$radius, ${point.latitude}, ${point.longitude});

    node["office"](around:$radius, ${point.latitude}, ${point.longitude});
    way["office"](around:$radius, ${point.latitude}, ${point.longitude});
    relation["office"](around:$radius, ${point.latitude}, ${point.longitude});

    node["amenity"](around:$radius, ${point.latitude}, ${point.longitude});
    way["amenity"](around:$radius, ${point.latitude}, ${point.longitude});
    relation["amenity"](around:$radius, ${point.latitude}, ${point.longitude});

    node["shop"](around:$radius, ${point.latitude}, ${point.longitude});
    way["shop"](around:$radius, ${point.latitude}, ${point.longitude});
    relation["shop"](around:$radius, ${point.latitude}, ${point.longitude});
  );
  out center;
  ''';
    try {
      // Make the HTTP POST request
      final http.Response response = await http.post(
        Uri.parse(url),
        body: <String, String>{'data': query},
      );

      // On ok response
      if (response.statusCode == 200) {
        // Parse response
        final OverpassResponse data = OverpassResponse.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>,
        );

        // Return valid nearby nodes
        return data.nodes;
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return <OverpassData>[];
      }
    } catch (e) {
      print('Error occurred: $e');
      return <OverpassData>[];
    }
  }
}
