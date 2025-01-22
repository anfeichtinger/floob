import 'dart:convert';

import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/review.dart';
import 'package:floob/states/controllers/base_controller.dart';
import 'package:floob/utils/floob_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

/// Define the provider with which we can access the controller in the view.
final Provider<ReviewController> reviewControllerProvider =
    Provider<ReviewController>((Ref<Object?> ref) {
  return const ReviewController();
});

/// This class contains all possible api calls related to reviews.
class ReviewController extends BaseController {
  const ReviewController();

  Future<List<Review>> getReviews({Map<String, dynamic>? query}) async {
    // Send the request
    final Response response = await FloobApi.get('/reviews', query: query);

    // Abort if the status code is not 200
    if (response.statusCode != 200) {
      throwResponseException(response);
    }

    // Parse and return the list of reviews.
    return FloobApi.parseMany(response, Review.fromJson);
  }

  Future<List<Review>> getReviewsByLocation(Location location) async {
    Map<String, dynamic> query = <String, dynamic>{
      'filters': jsonEncode(<String, String>{
        'location_id': location.id.toString(),
      })
    };

    return getReviews(query: query);
  }
}
