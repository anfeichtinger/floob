import 'package:floob/states/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/screens/menu/settings_screen.dart';
import 'package:floob/ui/screens/profile/personal_data_screen.dart';
import 'package:floob/ui/screens/profile/statistics_screen.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:floob/utils/route_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:hive/hive.dart';
import 'package:floob/states/controllers/login_state_notifier.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LoginController loginController = LoginController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          const Header(text: 'profile_title', hasBackAction: true),

          // Logo Image
          Center(
            child: Image.asset(
              'assets/img/logo-full-512x512.png',
              width: MediaQuery.of(context).size.width / 4,
            ),
          ),
          const SizedBox(height: 8),

          // Title Text
          Center(
            child: Text(
              Hive.box<dynamic>('prefs')
                  .get('session_user_name', defaultValue: 'Anonym') as String,
              style: const TextStyle(
                fontSize: 36,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          const SizedBox(height: 64),

          // Personal Data Button
          ListTile(
            title: Text(
              tr('profile_personal_data'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Style.radiusMd.x),
              side: const BorderSide(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(
                animatedRoute(
                  const PersonalDataScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // Statistics Button
          ListTile(
            title: Text(
              tr('profile_statistics'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Style.radiusMd.x),
              side: const BorderSide(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(
                animatedRoute(
                  const StatisticsScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // Settings Button
          ListTile(
            title: Text(
              tr('profile_settings'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.black,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Style.radiusMd.x),
              side: const BorderSide(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).push(
                animatedRoute(
                  const SettingsScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          // Logout Button
          TextButton(
            onPressed: () {
              loginController.logout();
              ref.read(loginStateNotifierProvider.notifier).logout();
              Navigator.of(context).pop();
            },
            child: Text(
              tr('profile_logout'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
