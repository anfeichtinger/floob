import 'dart:io';

import 'package:http/http.dart';

/// Shared functionallity of controllers.
class BaseController {
  const BaseController();

  void throwResponseException(Response response) {
    throw HttpException('Error ${response.statusCode} | ${response.body}');
  }
}
