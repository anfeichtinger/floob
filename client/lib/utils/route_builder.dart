import 'package:flutter/material.dart';

enum RouteAnimationType {
  fromLeft,
  fromTop,
  fromRight,
  fromBottom,
}

Route<T> animatedRoute<T extends Widget>(
  T screen, {
  RouteAnimationType type = RouteAnimationType.fromBottom,
}) {
  return PageRouteBuilder<T>(
    // Page
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) =>
        screen,
    // Transition
    transitionsBuilder: switch (type) {
      RouteAnimationType.fromLeft => _transitionsBuilderFromLeft,
      RouteAnimationType.fromTop => _transitionsBuilderFromTop,
      RouteAnimationType.fromRight => _transitionsBuilderFromRight,
      RouteAnimationType.fromBottom || _ => _transitionsBuilderFromBottom,
    },
  );
}

/// Slide child in from the left
Widget _transitionsBuilderFromLeft(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(-1.0, 0.0);
  const Offset end = Offset.zero;
  const Cubic curve = Curves.easeInOut;

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}

/// Slide child in from the top
Widget _transitionsBuilderFromTop(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(0.0, -1.0);
  const Offset end = Offset.zero;
  const Cubic curve = Curves.easeInOut;

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}

/// Slide child in from the right
Widget _transitionsBuilderFromRight(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(1.0, 0.0);
  const Offset end = Offset.zero;
  const Cubic curve = Curves.easeInOut;

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}

/// Slide child in from the bottom
Widget _transitionsBuilderFromBottom(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  const Offset begin = Offset(0.0, 1.0);
  const Offset end = Offset.zero;
  const Cubic curve = Curves.easeInOut;

  final Tween<Offset> tween = Tween<Offset>(begin: begin, end: end);
  final CurvedAnimation curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: curve,
  );

  return SlideTransition(
    position: tween.animate(curvedAnimation),
    child: child,
  );
}
