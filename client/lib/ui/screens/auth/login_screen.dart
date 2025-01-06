import 'package:easy_localization/easy_localization.dart';
import 'package:floob/ui/screens/auth/reset_password_screen.dart';
import 'package:floob/utils/route_builder.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:floob/ui/screens/auth/register_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

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
          const SizedBox(height: 16),
          Center(
            child: Image.asset(
              'assets/img/logo-full-512x512.png',
              width: MediaQuery.of(context).size.width / 3,
            ),
          ),
          const SizedBox(height: 64),
          TextFormField(
            decoration: InputDecoration(
              labelText: tr('login_email'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            decoration: InputDecoration(
              labelText: tr('login_password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {},
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(double.infinity, 54),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            child: Text(tr('login_submit')),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const RegisterScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: Text(
              tr('login_register'),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                animatedRoute(
                  const ResetPasswordScreen(),
                  type: RouteAnimationType.fromRight,
                ),
              );
            },
            child: Text(
              tr('login_forgot_password'),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
