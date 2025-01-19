import 'package:easy_localization/easy_localization.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/review.dart';
import 'package:floob/utils/floob_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:floob/ui/widgets/map_screen/location_rating_list_tile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LocationRatingsTab extends ConsumerStatefulWidget {
  const LocationRatingsTab({required this.location, super.key});

  final Location location;

  @override
  _LocationRatingsTabState createState() => _LocationRatingsTabState();
}

class _LocationRatingsTabState extends ConsumerState<LocationRatingsTab> {
  double _userRating = 0;

  // TODO: Adjust this function for use with the API, use it when ready
  // ?: Move this function to the controller
  Future<List<Review>> _loadRatings() async {
    final http.Response response =
        await FloobApi.get('/locations/${widget.location.id}/reviews');
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data =
          List<Map<String, dynamic>>.from(json.decode(response.body) as List);
      return data
          .map((Map<String, dynamic> review) => Review.fromJson(review))
          .toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<List<Review>> _generateRatings() async {
    return List<Review>.generate(
      5,
      (int index) => Review(
        id: index,
        locationId: widget.location.id,
        userId: index,
        score: (index % 5) + 1,
        text: 'Review text $index',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  List<_RatingData> _calculateRatingData(List<Review> reviews) {
    final Map<int, int> ratingCountMap = <int, int>{};
    for (final Review review in reviews) {
      final int score = review.score ?? 0;
      ratingCountMap[score] = (ratingCountMap[score] ?? 0) + 1;
    }
    return ratingCountMap.entries
        .map((MapEntry<int, int> entry) =>
            _RatingData(entry.key.toString(), entry.value.toDouble()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: _generateRatings(),
      builder: (BuildContext context, AsyncSnapshot<List<Review>> f) {
        if (f.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (f.hasError || !f.hasData || f.data!.isEmpty) {
          return Center(child: Text(tr('location_ratings_no_ratings')));
        } else {
          final List<Review> reviews = f.data!;
          final double averageRating = reviews
                  .map((Review review) => review.score?.toDouble() ?? 0)
                  .reduce((double a, double b) => a + b) /
              reviews.length;
          final List<_RatingData> ratingData = _calculateRatingData(reviews);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 24),
                _buildSummarySection(
                    context, averageRating, reviews.length, ratingData),
                const SizedBox(height: 24),
                _buildUserRatingSection(context),
                const SizedBox(height: 24),
                _buildRatingsFromOthersSection(context, reviews),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildSummarySection(BuildContext context, double averageRating,
      int totalRatings, List<_RatingData> ratingData) {
    final double maxRatingCount = ratingData
        .map((_RatingData data) => data.ratingCount)
        .reduce((double a, double b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_ratings_summary'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            // Total Rating
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),
                  Text(
                    '$averageRating',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: RatingBarIndicator(
                      rating: averageRating,
                      itemSize: 30.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        return const Icon(
                          Icons.star,
                          color: Colors.amber,
                        );
                      },
                    ),
                  ),
                  Text('($totalRatings)'),
                ],
              ),
            ),

            // Individual Ratings
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 150, // Adjust the height as needed
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(
                    isVisible: false,
                  ),
                  primaryYAxis: NumericAxis(
                    isVisible: false,
                    maximum: maxRatingCount,
                  ),
                  plotAreaBorderWidth: 0,
                  series: <BarSeries<_RatingData, String>>[
                    BarSeries<_RatingData, String>(
                      dataSource: ratingData,
                      xValueMapper: (_RatingData data, _) => data.rating,
                      yValueMapper: (_RatingData data, _) => data.ratingCount,
                      isTrackVisible: true,
                      color: Colors.amber,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserRatingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_ratings_add_rating'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // User Avatar
            Center(
              child: Image.asset(
                'assets/img/logo-full-512x512.png',
                width: 64,
              ),
            ),
            const SizedBox(width: 36),

            // Star Rating
            RatingBar.builder(
              initialRating: _userRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (BuildContext context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (double rating) {
                setState(() {
                  _userRating = rating;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingsFromOthersSection(
      BuildContext context, List<Review> reviews) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('location_ratings_from_others'),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reviews.length,
          itemBuilder: (BuildContext context, int index) {
            return LocationRatingListTile(review: reviews[index]);
          },
        ),
      ],
    );
  }
}

class _RatingData {
  _RatingData(this.rating, this.ratingCount);

  final String rating;
  final double ratingCount;
}
