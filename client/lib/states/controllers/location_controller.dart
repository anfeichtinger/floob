import 'dart:convert';

import 'package:floob/data/models/location.dart';
import 'package:floob/states/controllers/base_controller.dart';
import 'package:floob/utils/floob_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

/// Define the provider with which we can access the controller in the view.
final Provider<LocationController> locationControllerProvider =
    Provider<LocationController>((Ref<Object?> ref) {
  return const LocationController();
});

/// This class contains all possible api calls related to locations.
class LocationController extends BaseController {
  const LocationController();

  Future<List<Location>> getLocations({Map<String, dynamic>? query}) async {
    // Send the request
    final Response response = await FloobApi.get('/locations', query: query);

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the list of locations.
    return FloobApi.parseMany(response, Location.fromJson);
  }

  Future<Location?> getLocation(String id,
      {Map<String, dynamic>? query}) async {
    // Send the request
    final Response response =
        await FloobApi.get('/locations/$id', query: query);

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the location.
    return FloobApi.parseOne(response, Location.fromJson);
  }

  Future<List<Location>> getLocationsByLatLng(LatLng point,
      {int radius = 20}) async {
    // Send the request
    final Response response =
        await FloobApi.get('/locations/latlng', query: <String, String>{
      'lat': point.latitude.toString(),
      'lng': point.longitude.toString(),
      'radius': radius.toString(),
    });

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the list of locations.
    return FloobApi.parseMany(response, Location.fromJson);
  }

  Future<Location?> putAccessibilityEntries(
      Location location, Map<String, String> entries) async {
    entries.addAll({'overpass_data': jsonEncode(location.overpassData)});

    // Send the request
    final Response response = await FloobApi.put(
      '/locations/${location.id ?? 0}/accessibility-entries',
      body: entries,
    );

    // Abort if the status code is not 200 or 201
    if (response.statusCode != 200 && response.statusCode != 201) {
      throwResponseException(response);
    }

    // Parse and return the list of locations.
    return FloobApi.parseOne(response, Location.fromJson);
  }
}
