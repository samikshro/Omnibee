import 'package:flutter/material.dart';

class MediumTextSection extends StatelessWidget {
  final String caption;

  MediumTextSection(this.caption);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(15, 10, 10, 10),
      child: Text(
        caption,
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    );
  }
}
