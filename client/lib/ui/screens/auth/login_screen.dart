import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/app_bar_gone.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        children: const <Widget>[
          Header(text: 'Login', hasBackAction: true),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
