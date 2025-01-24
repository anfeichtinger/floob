import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // |============|
  // | Essentials |
  // |============|

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }

  // |===========|
  // | Specifics |
  // |===========|

  Future<void> saveLoginToken(String token) async {
    await saveToken(token);
  }
}
