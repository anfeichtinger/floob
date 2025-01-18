import 'dart:math';

import 'package:floob/config/style.dart';
import 'package:floob/data/models/location.dart';
import 'package:floob/states/bottom_sheet/location_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class LocationOverviewTab extends ConsumerWidget {
  const LocationOverviewTab({required this.location, super.key});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      children: <Widget>[
        const SizedBox(height: 24),
        // ===============================
        // |           General           |
        // ===============================
        Text('Allgemein', style: Theme.of(context).textTheme.titleMedium),
        // Address
        if (location.address.isNotEmpty)
          ListTile(
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            visualDensity: VisualDensity.comfortable,
            leading: Icon(
              UniconsLine.map_marker,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: .75),
            ),
            title: Text(location.address),
          ),
        // Website
        if (location.website != null)
          ListTile(
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
            visualDensity: VisualDensity.comfortable,
            leading: Icon(
              UniconsLine.link,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: .75),
            ),
            title: Text(location.website!),
          ),
        const SizedBox(height: 36),
        // ===============================
        // |        Accessibility        |
        // ===============================
        Text('Merkmale', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 24),
        // Todo real values
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1 / .75,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              Color color = Colors.green;
              IconData icon = UniconsLine.check_circle;
              switch (index % 4) {
                case 1:
                  color = Colors.red;
                  icon = UniconsLine.times_circle;
                  break;
                case 2:
                  color = Colors.amber;
                  icon = UniconsLine.exclamation_circle;
                  break;
                case 3:
                  color = Colors.grey;
                  icon = UniconsLine.question_circle;
                  break;
              }

              return Card(
                color: Theme.of(context).colorScheme.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 28,
                      color: color,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      Random().nextInt(21).toString(), // Todo real values
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: color,
                              ),
                    ),
                  ],
                ),
              );
            }),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).controller?.animateTo(1);
        }),
        const SizedBox(height: 36),
        // ===============================
        // |           Ratings           |
        // ===============================
        Text('Erfahrungsberichte',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 24),
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 20,
                right: MediaQuery.of(context).size.width / 12,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    location.reviewScore.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  RatingBarIndicator(
                    itemCount: 5,
                    itemSize: 20,
                    rating: location.reviewScore,
                    itemBuilder: (BuildContext context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  Text(
                    '(${location.reviewCount})',
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: LinearProgressIndicator(
                      value: Random().nextDouble(), // Todo real values
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
        ),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).controller?.animateTo(2);
        }),
        const SizedBox(height: 36),
        // ===============================
        // |            Media            |
        // ===============================
        Text('Medien', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 24),
        GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1 / 1.3),
            itemCount: 6,
            itemBuilder: (BuildContext context, int index) {
              // Todo actual media
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.all(Style.radiusLg),
                ),
                child: const Center(
                  child: Icon(UniconsLine.image),
                ),
              );
            }),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).controller?.animateTo(3);
        }),
        const SizedBox(height: 256),
      ],
    );
  }

  Widget _buildViewAllButton(
    BuildContext context,
    WidgetRef ref, {
    void Function()? onPressed,
  }) {
    return Center(
      child: TextButton(
        onPressed: onPressed ?? () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Alle ansehen',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(width: 8),
            const Icon(
              UniconsLine.angle_right,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
