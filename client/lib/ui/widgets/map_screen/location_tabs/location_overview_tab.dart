import 'package:floob/data/models/location.dart';
import 'package:floob/states/bottom_sheet/location_tab_controller.dart';
import 'package:floob/ui/widgets/empty_state.dart';
import 'package:floob/ui/widgets/map_screen/rating_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

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
            onTap: () => MapsLauncher.launchQuery(location.address),
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
            onTap: () => _launchUrl(location.website!),
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

        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1 / .75,
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              Color color = Colors.green;
              IconData icon = UniconsLine.check_circle;
              String title = 'Erfüllt';
              bool Function(Map<String, bool?>?) condition =
                  (Map<String, bool?>? innerMap) => innerMap!['value'] == true;
              switch (index % 4) {
                case 1:
                  color = Colors.red;
                  icon = UniconsLine.times_circle;
                  title = 'Nicht Erfüllt';
                  condition = (Map<String, bool?>? innerMap) =>
                      innerMap!['value'] == false;
                  break;
                case 2:
                  color = Colors.amber;
                  icon = UniconsLine.exclamation_circle;
                  title = 'Unzuverlässig';
                  condition = (Map<String, bool?>? innerMap) =>
                      innerMap!['trusted'] == false;
                  break;
                case 3:
                  color = Colors.grey;
                  icon = UniconsLine.question_circle;
                  title = 'Unbekannt';
                  condition = (Map<String, bool?>? innerMap) =>
                      innerMap!['value'] == null;
                  break;
              }

              return Card(
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 12, left: 12),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Expanded(
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
                            (location.accessibility?.values
                                        .where(condition)
                                        .length ??
                                    0)
                                .toString(),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  color: color,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).update(context, 1);
        }),
        const SizedBox(height: 36),
        // ===============================
        // |           Ratings           |
        // ===============================
        Text('Erfahrungsberichte',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 24),
        RatingHeader(location: location),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).update(context, 2);
        }),
        const SizedBox(height: 36),
        // ===============================
        // |            Media            |
        // ===============================
        Text('Medien', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 24),
        // GridView.builder(
        //     padding: EdgeInsets.zero,
        //     physics: const NeverScrollableScrollPhysics(),
        //     shrinkWrap: true,
        //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 3,
        //         crossAxisSpacing: 12,
        //         mainAxisSpacing: 12,
        //         childAspectRatio: 1 / 1.3),
        //     itemCount: 6,
        //     itemBuilder: (BuildContext context, int index) {
        //       // Todo actual media
        //       return Container(
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).colorScheme.surface,
        //           borderRadius: const BorderRadius.all(Style.radiusLg),
        //         ),
        //         child: const Center(
        //           child: Icon(UniconsLine.image),
        //         ),
        //       );
        //     }),
        const EmptyState(
          icon: UniconsLine.image_slash,
          title: 'Keine Medien vorhanden',
        ),
        const SizedBox(height: 16),
        _buildViewAllButton(context, ref, onPressed: () {
          ref.read(locationTabControllerProvider).update(context, 3);
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

  Future<void> _launchUrl(String url) async {
    Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}
