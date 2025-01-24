import 'package:floob/utils/floob_api.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'base_controller.dart';
import 'package:floob/data/models/user.dart';

class LoginController extends BaseController {
  Future<bool> login({Map<String, dynamic>? query}) async {
    final http.Response response =
        await FloobApi.get('/users/login', query: query);

    if (response.statusCode == 200) {
      User? user = FloobApi.parseOne(response, User.fromJson);
      Hive.box<dynamic>('prefs').put('id', user!.id);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    final http.Response response =
        await FloobApi.post('/users/register', body: <String, String>{
      'name': email
          .split('@')
          .first
          .replaceAll('.', ' ')
          .replaceAll(RegExp(r'\d'), ''),
      'email': email,
      'password': password
    });

    return response.statusCode == 201;
  }
}
