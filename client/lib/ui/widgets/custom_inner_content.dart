import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_dragging_handle.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_featured_items_grid.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_featured_lists_text.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_recent_photo_large.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_recent_photos_small.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/widgets/custom_recent_photos_text.dart';

class CustomInnerContent extends StatelessWidget {
  const CustomInnerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        SizedBox(height: 12),
        CustomDraggingHandle(),
        SizedBox(height: 24),
        CustomFeaturedListsText(),
        SizedBox(height: 16),
        CustomFeaturedItemsGrid(),
        SizedBox(height: 24),
        CustomRecentPhotosText(),
        SizedBox(height: 16),
        CustomRecentPhotoLarge(),
        SizedBox(height: 12),
        CustomRecentPhotosSmall(),
        SizedBox(height: 16),
      ],
    );
  }
}
