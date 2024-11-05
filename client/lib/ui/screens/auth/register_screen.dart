import 'package:flutter/material.dart';
import 'package:floob/ui/widgets/app_bar_gone.dart';
import 'package:floob/ui/widgets/header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

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
          Header(text: 'Register', hasBackAction: true),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
