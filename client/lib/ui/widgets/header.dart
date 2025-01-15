import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    required this.text,
    this.hasBackAction = false,
    this.backIcon,
    this.onBackAction,
  });

  final String text;
  final bool hasBackAction;
  final IconData? backIcon;
  final void Function()? onBackAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 48, bottom: 24),
      child: Row(
        children: <Widget>[
          if (hasBackAction)
            IconButton(
              onPressed: onBackAction ??
                  () {
                    Navigator.of(context).pop();
                  },
              icon: Icon(
                backIcon ?? UniconsLine.arrow_left,
                size: 40,
              ),
            ),
          Text(
            tr(text),
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(fontWeightDelta: 2),
          ),
        ],
      ),
    );
  }
}
