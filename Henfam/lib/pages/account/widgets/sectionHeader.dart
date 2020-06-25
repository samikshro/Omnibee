import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String label;

  SectionHeader(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
      child: Text(
        label,
        style: TextStyle(fontSize: 22),
      ),
    );
  }
}
