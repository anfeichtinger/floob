import 'package:floob/config/style.dart';
import 'package:floob/data/models/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingHeader extends StatelessWidget {
  const RatingHeader({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 20,
            right: MediaQuery.of(context).size.width / 12,
          ),
          child: Column(
            children: <Widget>[
              Text(
                location.reviews?['score']?.toStringAsFixed(1) ?? '0.0',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              RatingBarIndicator(
                itemCount: 5,
                itemSize: 20,
                rating: location.reviews?['score'] ?? 0,
                itemBuilder: (BuildContext context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              Text(
                '(${location.reviews?['count']?.toInt() ?? 0})',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: .75)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              index = 5 - index;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: LinearProgressIndicator(
                  value: location.reviews?['${index}star'] ?? 0,
                  color: Colors.amber,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: .25),
                  borderRadius: const BorderRadius.all(Style.radiusFull),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
