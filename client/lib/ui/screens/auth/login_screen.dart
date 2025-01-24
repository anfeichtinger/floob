import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/ui/screens/auth/reset_password_screen.dart';
import 'package:floob/utils/route_builder.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:floob/ui/screens/auth/register_screen.dart';
import 'package:floob/states/controllers/login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final LoginController loginController = LoginController();

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
            controller: emailController,
            decoration: InputDecoration(
              labelText: tr('login_email'),
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: tr('login_password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () async {
              final String email = emailController.text;
              final String password = passwordController.text;
              bool isOK = await loginController.login(
                query: <String, String>{'email': email, 'password': password},
              );

              if (mounted) {
                setState(() {
                  if (isOK) {
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('login_invalid_credentials')),
                      ),
                    );
                  }
                });
              }
            },
            style: ButtonStyle(
              minimumSize: WidgetStateProperty.all<Size>(
                const Size(double.infinity, 54),
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Style.radiusSm.x),
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
