import 'package:flutter/material.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/screens/home_screen.dart';
import 'package:flutter_production_boilerplate_riverpod/ui/screens/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/widgets/bottom_nav_bar/bottom_nav_bar_state.dart';
import '../widgets/app_bar_gone.dart';

class SkeletonScreen extends ConsumerWidget {
  const SkeletonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? navIndex = ref.watch(bottomNavProvider) as int?;
    List<Widget> pageNavigation = <Widget>[
      const HomeScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarGone(),
      backgroundColor: Theme.of(context).colorScheme.surface,

      /// When switching between tabs this will fade the old
      /// layout out and the new layout in.
      body: Stack(
        children: [
          // Map or background content here
          Container(
            color: Colors.blue[200],
            child: const Center(
              child: Text(
                'Your Map View Here',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          // DraggableScrollableSheet widget
          DraggableScrollableSheet(
            initialChildSize: 0.2, // Start with 20% height
            minChildSize: 0.2, // Minimum height
            maxChildSize: 0.8, // Maximum height when fully expanded
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                  boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26)],
                ),
                child: Column(
                  children: [
                    // Handle to indicate the sheet can be dragged
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Main content of the bottom sheet
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController, // Important for dragging
                        itemCount: 20, // Number of items
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: const Icon(Icons.place),
                            title: Text('Action Item ${index + 1}'),
                            subtitle: Text('Subtitle for item ${index + 1}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
