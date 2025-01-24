import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/states/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
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
          TextFormField(
            decoration: InputDecoration(
              labelText: tr('register_repeat_password'),
              border: const OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () async {
              final String email = emailController.text;
              final String password = passwordController.text;
              bool isOK = await loginController.register(email, password);

              if (mounted) {
                setState(() {
                  if (isOK) {
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(tr('register_error')),
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
            child: Text(tr('register_submit')),
          ),
          const SizedBox(height: 32),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              '< ${tr('register_cancel')}',
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
