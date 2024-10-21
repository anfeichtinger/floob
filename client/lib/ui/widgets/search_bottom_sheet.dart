import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SearchBottomSheet extends StatelessWidget {
  const SearchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draggable Bottom Sheet with Search'),
      ),
      body: DraggableBottomSheet(
        minExtent: 100,
        maxExtent: 500,
        backgroundWidget: const Center(
          child: Text('Main Content Here'),
        ),
        previewWidget: Container(
          color: Colors.grey[200],
          child: const Center(
            child: Text('Pull up to search'),
          ),
        ),
        expandedWidget: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white,
          child: Column(
            children: [
              buildSearchBar(),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text('Item $index'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        onDragging: (double dragValue) {
          print('Dragging $dragValue');
        },
      ),
    );
  }

  Widget buildSearchBar() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
