import 'package:Henfam/pages/account/widgets/customTile.dart';
import 'package:Henfam/pages/account/widgets/sectionHeader.dart';
import 'package:flutter/material.dart';

class ProfilePointsBar extends StatelessWidget {
  final int points;

  ProfilePointsBar(this.points);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader('Your Points'),
          CustomTile('350'),
        ],
      ),
    );
  }
}
