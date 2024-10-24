import 'package:flutter/material.dart';

class CustomFeaturedListsText extends StatelessWidget {
  const CustomFeaturedListsText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16),
      //only to left align the text
      child: Row(
        children: <Widget>[
          Text('Featured Lists', style: TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
