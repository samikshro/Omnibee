import 'package:flutter/material.dart';

class BigMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: Text("Big mode!"),
      ),
    );
  }
}
