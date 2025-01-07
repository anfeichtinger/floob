import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floob/config/style.dart';
import 'package:floob/ui/screens/menu/menu_screen.dart';
import 'package:floob/ui/widgets/bottom_sheet_handle.dart';
import 'package:floob/utils/route_builder.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: true,
      snap: true,
      snapSizes: const <double>[.15, .7, 1],
      shouldCloseOnMinExtent: false,
      initialChildSize:
          !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? 0.15 : 0.4,
      minChildSize: 0.15,
      builder: (BuildContext context, ScrollController scrollController) {
        return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context)
              .copyWith(dragDevices: <PointerDeviceKind>{
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
          }),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Card(
              elevation: 12.0,
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Style.radiusLg,
                  topRight: Style.radiusLg,
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
              ),
              margin: const EdgeInsets.all(0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: <Widget>[
                  const BottomSheetHandle(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            hintText: 'Search here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Style.radiusMd),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        height: 64,
                        width: 64,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            Navigator.of(context).push(animatedRoute(
                              const MenuScreen(),
                              type: RouteAnimationType.fromBottom,
                            ));
                          },
                          child: CircleAvatar(
                            radius: double.infinity,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: MediaQuery.of(context).size.height - 128,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Style.radiusMd),
                      color: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
