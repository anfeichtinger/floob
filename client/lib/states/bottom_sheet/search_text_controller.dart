import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<SearchTextControllerState>
    searchTextControllerProvider =
    ChangeNotifierProvider<SearchTextControllerState>(
        (Ref<SearchTextControllerState> ref) {
  return SearchTextControllerState();
});

class SearchTextControllerState extends ChangeNotifier {
  SearchTextControllerState({String? text}) {
    controller ??= TextEditingController(text: text ?? '');
  }

  TextEditingController? controller;

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    super.dispose();
  }
}
