import 'package:flutter/material.dart';

class ListTileX extends StatelessWidget {
  final Widget? leading; // Optional leading widget
  final Text? title; // Required title text
  final Widget? subtitle; // Optional subtitle text
  final void Function()? onTap; // Optional tap event handler
  final void Function()? onLongPress; // Optional long press event handler
  final void Function()? onDoubleTap; // Optional double tap event handler
  final Widget? trailing; // Optional trailing widget
  final EdgeInsetsGeometry trailingPadding; // Optional trailing padding
  final Color? background; // Optional tile background color
  final double? height; // Required height for the custom list tile
  final Widget? before; // Optional widget above list tile
  final Widget? after; // Optional widget below list tile
  final Radius? borderRadius; // Optional widget below list tile

  // Constructor for the custom list tile
  const ListTileX({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.trailing,
    this.trailingPadding = const EdgeInsets.all(12),
    this.background,
    this.height,
    this.before,
    this.after,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          background ?? Colors.transparent, // Set background color if provided
      borderRadius: BorderRadius.all(borderRadius ?? Radius.zero),
      child: InkWell(
        // Tappable area with event handlers
        onTap: onTap, // Tap event handler
        onDoubleTap: onDoubleTap, // Double tap event handler
        onLongPress: onLongPress, // Long press event handler
        borderRadius: BorderRadius.all(borderRadius ?? Radius.zero),
        child: Column(
          children: <Widget>[
            before ?? const SizedBox(),
            SizedBox(
              // Constrain the size of the list tile
              height: height, // Set custom height from constructor
              child: Row(
                // Row layout for list item content
                children: <Widget>[
                  Padding(
                    // Padding for the leading widget
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: leading, // Display leading widget
                  ),
                  Expanded(
                    // Expanded section for title and subtitle
                    child: Column(
                      // Column layout for title and subtitle
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // Align text left
                      children: <Widget>[
                        title ??
                            const SizedBox(), // Display title or empty space
                        subtitle ??
                            const SizedBox(), // Display subtitle or empty space
                      ],
                    ),
                  ),
                  Padding(
                    // Padding for the trailing widget
                    padding: trailingPadding,
                    child: trailing, // Display trailing widget
                  )
                ],
              ),
            ),
            after ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
