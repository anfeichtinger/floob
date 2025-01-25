import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:floob/config/style.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const Header(
            text: 'profile_statistics',
            hasBackAction: true,
          ),
          const SizedBox(height: 20),
          TextField(
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                labelText: tr('profile_rated_buildings'),
                labelStyle: const TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Style.radiusSm.x),
                ),
              ),
              controller: TextEditingController(text: '6'),
              readOnly: true,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              labelText: tr('profile_rated_categories'),
              labelStyle: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Style.radiusSm.x),
              ),
            ),
            controller: TextEditingController(text: '11'),
            readOnly: true,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          TextField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              labelText: tr('profile_most_frequent_category'),
              labelStyle: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Style.radiusSm.x),
              ),
            ),
            controller: TextEditingController(text: 'Treppen & Aufzüge'),
            readOnly: true,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 48),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(Style.radiusSm.x),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  tr('profile_available_badges'),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontFamily: 'Nunito'),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List<Widget>.generate(
                    4,
                    (int index) => Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(right: 10),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
