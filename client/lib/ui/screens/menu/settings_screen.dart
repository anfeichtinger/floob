import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/config/style.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

import '../../widgets/settings_screen/theme_card.dart';
import '../../widgets/header.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

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
          const Header(text: 'Settings', hasBackAction: true),

          Card(
            elevation: 0,
            shadowColor: Theme.of(context).colorScheme.shadow,

            /// Example: Many items have their own colors inside of the ThemData
            /// You can overwrite them in [config/style.dart].
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Style.radiusMd),
              side: BorderSide(color: Theme.of(context).shadowColor),
            ),
            child: SwitchListTile(
              onChanged: (bool newValue) {
                /// Example: Change locale
                /// The initial locale is automatically determined by the library.
                /// Changing the locale like this will persist the selected locale.
                context.setLocale(
                    newValue ? const Locale('de') : const Locale('en'));
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Style.radiusMd),
              ),
              value: context.locale == const Locale('de'),
              inactiveTrackColor:
                  Theme.of(context).colorScheme.surfaceContainer,

              /// You can use a FittedBox to keep Text in its bounds.
              title: FittedBox(
                alignment: Alignment.centerLeft,
                fit: BoxFit.scaleDown,
                child: Row(
                  children: <Widget>[
                    Icon(
                      UniconsLine.english_to_chinese,
                      // FluentIcons.local_language_24_regular,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      tr('language_switch_title'),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .apply(fontWeightDelta: 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// Example: Good way to add space between items without using Paddings
          const SizedBox(height: 8),

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <ThemeCard>[
              ThemeCard(
                mode: ThemeMode.system,
                icon: UniconsLine.adjust_half,
                // icon: FluentIcons.dark_theme_24_regular,
              ),
              ThemeCard(
                mode: ThemeMode.light,
                icon: UniconsLine.sun,
                // icon: FluentIcons.weather_sunny_24_regular,
              ),
              ThemeCard(
                mode: ThemeMode.dark,
                icon: UniconsLine.moon,
                // icon: FluentIcons.weather_moon_24_regular,
              ),
            ],
          ),
          const SizedBox(height: 36),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
