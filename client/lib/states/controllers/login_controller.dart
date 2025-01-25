import 'package:floob/utils/floob_api.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/src/framework.dart';
import 'base_controller.dart';
import 'package:floob/data/models/user.dart';
import 'package:floob/states/controllers/login_state_notifier.dart';

class LoginController extends BaseController {
  Future<bool> login({Map<String, dynamic>? query}) async {
    final http.Response response =
        await FloobApi.get('/users/login', query: query);

    if (response.statusCode == 200) {
      User? user = FloobApi.parseOne(response, User.fromJson);
      Hive.box<dynamic>('prefs').put('session_user_id', user!.id.toString());
      Hive.box<dynamic>('prefs').put('session_user_name', user.name);
      Hive.box<dynamic>('prefs').put('session_user_email', user.email);
      loginStateNotifierProvider.notifier.update((state) => true);
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    Hive.box<dynamic>('prefs').put('session_user_id', '');
    Hive.box<dynamic>('prefs').put('session_user_name', '');
    Hive.box<dynamic>('prefs').put('session_user_email', '');
    loginStateNotifierProvider.notifier.update((state) => false);
  }

  Future<bool> register(String email, String password) async {
    final http.Response response =
        await FloobApi.post('/users/register', body: <String, String>{
      'name': email
          .split('@')
          .first
          .replaceAll('.', ' ')
          .replaceAll(RegExp(r'\d'), '')
          .split(' ')
          .map((String word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1)}'
              : '')
          .join(' '),
      'email': email,
      'password': password
    });

    return response.statusCode == 201;
  }
}

extension on AlwaysAliveRefreshable<LoginStateNotifier> {
  void update(bool Function(dynamic state) param0) {}
}
