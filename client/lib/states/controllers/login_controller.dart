import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'base_controller.dart';
import '../../utils/session_manager.dart';

class LoginController extends BaseController {
  /// Sends a login request to the given path with the given query parameters and headers.
  Future<void> login(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    Uri uri = _parseUri(path: path, query: query);
    _log('GET', uri: uri, body: null, headers: headers);

    final http.Response response = await http.get(
      uri,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      final String token = responseBody['token'] as String;
      final SessionManager sessionManager = SessionManager();
      await sessionManager.saveLoginToken(token);
    } else {
      throwResponseException(response);
    }
  }

  /// Sends a register request to the given path with the given body and headers.
  Future<void> register(
    String path, {
    required Map<String, String> body,
    Map<String, String>? headers,
  }) async {
    Uri uri = _parseUri(path: path);
    _log('POST', uri: uri, body: body, headers: headers);

    final http.Response response = await http.post(
      uri,
      body: body,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
    );

    if (response.statusCode != 201) {
      throwResponseException(response);
    }
  }

  Uri _parseUri({
    required String path,
    Map<String, dynamic>? query,
    bool isApi = true,
  }) {
    // Handle path with or without leading '/'
    path = path.startsWith('/') ? path : '/$path';

    return Uri(
      scheme: kReleaseMode ? 'https' : 'http',
      host: kReleaseMode ? 'floob.feichtinger.dev' : 'floob.feichtinger.dev',
      port: kReleaseMode ? 443 : 80,
      path: isApi ? 'api$path' : path,
      queryParameters: query,
    );
  }

  void _log(
    String requestType, {
    Uri? uri,
    Map<String, String>? body,
    Map<String, String>? headers,
  }) {
    String timestamp = DateTime.now().toIso8601String().split('T')[1];
    String message = '[$timestamp] $requestType {';

    if (uri != null) {
      message += '\n  Uri: "$uri",';
    }

    if (body != null) {
      message += '\n  Body: $body,';
    }

    if (headers != null) {
      message += '\n  Headers: $headers,';
    }

    message += '\n}';
    log(message);
  }
}
