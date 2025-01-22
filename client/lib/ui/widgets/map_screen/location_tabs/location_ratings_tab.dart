import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/data/models/review.dart';
import 'package:floob/states/controllers/review_controller.dart';
import 'package:floob/ui/widgets/map_screen/rating_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:floob/ui/widgets/map_screen/location_rating_list_tile.dart';

class LocationRatingsTab extends ConsumerStatefulWidget {
  const LocationRatingsTab({required this.location, super.key});

  final Location location;

  @override
  LocationRatingsTabState createState() => LocationRatingsTabState();
}

class LocationRatingsTabState extends ConsumerState<LocationRatingsTab> {
  double _userRating = 0;

  Future<List<Review>> _loadRatings(WidgetRef ref) async {
    return ref
        .read(reviewControllerProvider)
        .getReviewsByLocation(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24),
          _buildSummarySection(context),
          const SizedBox(height: 36),
          _buildUserRatingSection(context),
          const SizedBox(height: 24),
          _buildRatingsFromOthersSection(context),
        ],
      ),
    );
  }

  Widget _buildSummarySection(BuildContext context) {
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
        const SizedBox(height: 24),
        RatingHeader(location: widget.location),
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
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context)
                    .showSnackBar(Style.notImplementedSnackbar);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRatingsFromOthersSection(BuildContext context) {
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
        FutureBuilder<List<Review>>(
            future: _loadRatings(ref),
            builder: (BuildContext context, AsyncSnapshot<List<Review>> f) {
              if (f.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (f.hasError || !f.hasData || f.data!.isEmpty) {
                return Center(child: Text(tr('location_ratings_no_ratings')));
              } else {
                List<Review> reviews = f.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: reviews.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LocationRatingListTile(review: reviews[index]);
                  },
                );
              }
            }),
        const SizedBox(height: 256),
      ],
    );
  }
}
