import 'package:flutter/material.dart';
import 'package:floob/ui/screens/auth/login_screen.dart';
import 'package:floob/ui/screens/auth/register_screen.dart';
import 'package:floob/ui/screens/menu/settings_screen.dart';
import 'package:floob/ui/screens/profile/personal_data_screen.dart';
import 'package:floob/ui/screens/profile/statistics_screen.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:floob/ui/widgets/text_divider.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:floob/utils/route_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

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
          const Header(text: 'Menu', hasBackAction: true),

          const TextDivider(text: 'When not logged In'),

          // Login Button
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const LoginScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: const Text('Login'),
          ),

          const SizedBox(height: 8),

          // Register Button
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const RegisterScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: const Text('Register'),
          ),

          const TextDivider(text: 'When logged In'),

          // Personal Data Button
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const PersonalDataScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: const Text('Personal Data'),
          ),

          const SizedBox(height: 8),

          // Statistics Button
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const StatisticsScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: const Text('Statistics'),
          ),

          const TextDivider(text: 'Always'),

          // Settings Button
          FilledButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const SettingsScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: const Text('Settings'),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
