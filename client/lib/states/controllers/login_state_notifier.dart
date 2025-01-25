import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginStateNotifier extends StateNotifier<bool> {
  LoginStateNotifier() : super(false);

  void login() => state = true;
  void logout() => state = false;
}

final StateNotifierProvider<LoginStateNotifier, bool>
    loginStateNotifierProvider =
    StateNotifierProvider<LoginStateNotifier, bool>(
        (StateNotifierProviderRef<LoginStateNotifier, bool> ref) =>
            LoginStateNotifier());
