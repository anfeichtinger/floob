import 'package:flutter/material.dart';

class CustomRecentPhotosText extends StatelessWidget {
  const CustomRecentPhotosText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 16),
      child: Row(
        children: <Widget>[
          Text('Recent Photos', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
