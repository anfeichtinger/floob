import 'package:easy_localization/easy_localization.dart';
import 'package:floob/data/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:timeago/timeago.dart' as timeago;

class LocationRatingListTile extends StatelessWidget {
  const LocationRatingListTile({required this.review, super.key});

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          // Avatar
          leading: Image.asset(
            'assets/img/logo-full-512x512.png',
            width: 64,
          ),

          // User name
          title: Text(
            review.user?.name ?? 'Anon',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),

          // Timestamp and Rating
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                timeago.format(review.createdAt ?? DateTime.now(),
                    locale: context.locale.toString()),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              StarRating(
                rating: review.score?.toDouble() ?? 0,
                color: Colors.amber,
                borderColor: Colors.amber,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
            ],
          ),

          isThreeLine: true,
        ),

        // Review Text
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            review.text ?? 'No review text',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),

        // Margin
        const SizedBox(height: 16.0),
      ],
    );
  }
}
