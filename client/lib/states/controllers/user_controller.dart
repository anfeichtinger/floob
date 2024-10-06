import 'package:flutter_production_boilerplate_riverpod/data/models/user.dart';
import 'package:flutter_production_boilerplate_riverpod/states/controllers/base_controller.dart';
import 'package:flutter_production_boilerplate_riverpod/utils/floob_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

/// Define the provider with which we can access the controller in the view.
final Provider<UserController> userControllerProvider =
    Provider<UserController>((ProviderRef<Object?> ref) {
  return const UserController();
});

/// This class contains all possible api calls related to users.
class UserController extends BaseController {
  const UserController();

  Future<List<User>> getUsers() async {
    // Send the request
    final Response response = await FloobApi.get('/users');

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the list of users.
    return FloobApi.parseMany(response, User.fromJson);
  }

  Future<User?> getUser(String id) async {
    // Send the request
    final Response response = await FloobApi.get('/users/$id');

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the user.
    return FloobApi.parseOne<User>(response, User.fromJson);
  }
}
