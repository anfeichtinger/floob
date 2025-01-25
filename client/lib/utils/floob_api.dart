import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// Todo: implement a caching system to prevent the same request from being
// executed multiple times.

class FloobApi {
  // |===========|
  // |  Actions  |
  // |===========|

  /// Sends a GET request to the given path with the given query parameters and headers.
  static Future<http.Response> get(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) {
    Uri uri = FloobApi._parseUri(path: path, query: query);
    FloobApi._log('GET', uri: uri, body: null, headers: headers);

    return http.get(
      uri,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
    );
  }

  /// Sends a PUT request to the given path with the given query parameters, headers and body.
  static Future<http.Response> put(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? body,
    Map<String, String>? headers,
  }) {
    Uri uri = FloobApi._parseUri(path: path, query: query);
    FloobApi._log('PUT', uri: uri, body: body, headers: headers);

    return http.put(
      uri,
      body: body,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
    );
  }

  /// Sends a POST request to the given path with the given query parameters, headers and body.
  static Future<http.Response> post(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? body,
    Map<String, String>? headers,
  }) {
    Uri uri = FloobApi._parseUri(path: path, query: query);
    FloobApi._log('POST', uri: uri, body: body, headers: headers);

    return http.post(
      uri,
      body: body,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
    );
  }

  /// Sends a DELETE request to the given path with the given query parameters, headers and body.
  static Future<http.Response> delete(
    String path, {
    Map<String, dynamic>? query,
    Map<String, String>? body,
    Map<String, String>? headers,
  }) {
    Uri uri = FloobApi._parseUri(path: path, query: query);
    FloobApi._log('DELETE', uri: uri, body: body, headers: headers);

    return http.delete(
      uri,
      body: body,
      headers: headers ??
          <String, String>{
            'Content-type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
          },
    );
  }

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

  static void _log(
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
