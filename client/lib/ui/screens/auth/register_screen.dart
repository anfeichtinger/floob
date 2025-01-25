import 'package:easy_localization/easy_localization.dart';
import 'package:floob/config/style.dart';
import 'package:floob/states/controllers/login_controller.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:unicons/unicons.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();
  final LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: const AppBarGone(),
      body: Form(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          physics: const BouncingScrollPhysics(),
          children: <Widget>[
            const SizedBox(height: 16),
            const Header(text: 'Registrierung', hasBackAction: true),

            // Logo
            Center(
              child: Image.asset(
                'assets/img/logo-full-512x512.png',
                width: MediaQuery.of(context).size.width / 3,
              ),
            ),
            const SizedBox(height: 64),

            // Email TextFormField
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                labelText: tr('login_email'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),

            // Password TextFormField
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: tr('login_password'),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),

            // Repeat password TextFormField
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              controller: repeatPasswordController,
              decoration: InputDecoration(
                labelText: tr('register_repeat_password'),
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),

            // Register button
            FilledButton(
              onPressed: () async {
                final String email = emailController.text;
                final String password = passwordController.text;
                final String repeatPassword = repeatPasswordController.text;
                bool isOK = password == repeatPassword
                    ? await loginController.register(email, password)
                    : false;

                if (mounted) {
                  setState(() {
                    if (isOK) {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            tr('register_success'),
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            tr('register_error'),
                          ),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Icon(UniconsLine.arrow_left),
                  Text(tr('register_cancel')),
                ],
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
