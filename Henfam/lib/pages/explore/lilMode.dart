import 'package:Henfam/pages/explore/lil_explore/errandSelectionRow.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';

class LilMode extends StatelessWidget {
  final List<Map<String, Object>> activities;

  LilMode(this.activities);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        LargeTextSection("Request an Errand"),
        ErrandSelectionRow(),
      ],
    );
  }
}
