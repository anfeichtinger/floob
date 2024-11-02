import 'package:flutter_production_boilerplate_riverpod/data/models/location.dart';
import 'package:flutter_production_boilerplate_riverpod/states/controllers/base_controller.dart';
import 'package:flutter_production_boilerplate_riverpod/utils/floob_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

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
}
