import 'package:flutter/material.dart';

class LargeTextSection extends StatelessWidget {
  final String caption;

  LargeTextSection(this.caption);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
      child: Text(
        caption,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.left,
      ),
    );
  }
}
