import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FloobApi {
  // |===========|
  // |  Actions  |
  // |===========|

  /// Sends a get request to the given path with the given query parameters.
  static Future<http.Response> get(String path, {Map<String, dynamic>? query}) {
    return http.get(
      FloobApi._parseUri(path: path, query: query),
      headers: <String, String>{
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  // Todo other http actions like put, post, delete....

  // |===================|
  // |  General Helpers  |
  // |===================|

  /// Parses the given path to a working URL.
  /// E. g. http://localhost:8000/api/users or https://floob.feichtinger.dev/api/users.
  static Uri _parseUri({
    required String path,
    Map<String, dynamic>? query,
    bool isApi = true,
  }) {
    // Handle path with or without leading '/'
    path = path.startsWith('/') ? path : '/$path';

    return Uri(
      scheme: kReleaseMode ? 'https' : 'http',
      host: kReleaseMode ? 'floob.feichtinger.dev' : 'localhost',
      port: kReleaseMode ? 443 : 8000,
      path: isApi ? 'api$path' : path,
      queryParameters: query,
    );
  }

  /// Parses the response of a request to a Map<String, dynamic>.
  static Map<String, dynamic> parseResponse(http.Response response) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  }

  /// Parses the response of a request that contains 'data' to a List<dynamic>.
  static List<dynamic> getListFromResponseData(http.Response response) {
    return parseResponse(response)['data'] as List<dynamic>;
  }

  /// Returns one instance from the responses data if present.
  static T? parseOne<T>(
      http.Response response, T Function(Map<String, dynamic>) fromJson) {
    return fromJson(
        FloobApi.parseResponse(response)['data'] as Map<String, dynamic>);
  }

  /// Returns a list of instances from the responses data if present.
  static List<T> parseMany<T>(
      http.Response response, T Function(Map<String, dynamic>) fromJson) {
    return FloobApi.getListFromResponseData(response)
        .map((dynamic item) => fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
