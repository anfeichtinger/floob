import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:floob/config/style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

import 'states/theme_mode_state.dart';
import 'ui/screens/map_screen.dart';

/// Try using const constructors as much as possible!

void main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  /// Support high refresh rate on Android
  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  /// Init Hive key/value store
  if (kIsWeb) {
    await Hive.initFlutter();
  } else {
    final Directory tmpDir = await getTemporaryDirectory();
    await Hive.initFlutter(tmpDir.path);
  }
  await Hive.openBox<dynamic>('prefs');

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('de'),
        ],
        fallbackLocale: const Locale('en'),
        useFallbackTranslations: true,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeModeState currentTheme = ref.watch(themeProvider);

    return MaterialApp(
      /// Localization is not available for the title.
      title: 'Flutter Production Boilerplate',

      /// Theme stuff
      theme: Style.lightTheme,
      darkTheme: Style.darkTheme,
      themeMode: currentTheme.themeMode,

      /// Localization stuff
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
    );
  }
}
