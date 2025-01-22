import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.backgroundColor,
    this.borderRadius,
    this.icon,
    this.iconSize = 40,
  });

  final String title;
  final TextStyle? titleStyle;
  final String? subtitle;
  final TextStyle? subtitleStyle;
  final IconData? icon;
  final double iconSize;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Column(
        children: <Widget>[
          ..._buildIcon(context),
          ..._buildTitle(context),
          ..._buildSubtitle(context),
        ],
      ),
    );
  }

  List<Widget> _buildIcon(BuildContext context) {
    return icon != null
        ? <Widget>[
            Icon(
              icon,
              size: iconSize,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: .65),
            ),
          ]
        : <Widget>[];
  }

  List<Widget> _buildTitle(BuildContext context) {
    List<Widget> result = List<Widget>.empty(growable: true);

    if (icon != null) {
      result.add(const SizedBox(height: 12));
    }

    result.add(Text(
      tr(title),
      style: titleStyle ??
          Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
      textAlign: TextAlign.center,
    ));

    return result;
  }

  List<Widget> _buildSubtitle(BuildContext context) {
    List<Widget> result = List<Widget>.empty(growable: true);

    if (subtitle == null) return result;

    result.add(const SizedBox(height: 8));

    result.add(Text(
      tr(subtitle!),
      style: subtitleStyle ??
          Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: .75),
              ),
      textAlign: TextAlign.center,
    ));

    return result;
  }
}
