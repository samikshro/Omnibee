import 'package:Henfam/pages/explore/currentOrders.dart';
import 'package:Henfam/pages/explore/lil_explore/errandSelectionRow.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';

class LilMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building lilmode\n");
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: LargeTextSection("Request an Errand"),
        ),
        ErrandSelectionRow(),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: LargeTextSection("Your Current Errands"),
        ),
        CurrentOrders(),
      ],
    );
  }
}
