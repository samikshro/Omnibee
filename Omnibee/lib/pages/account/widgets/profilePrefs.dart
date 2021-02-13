import 'package:Omnibee/pages/account/widgets/customTile.dart';
import 'package:Omnibee/pages/account/widgets/sectionHeader.dart';
import 'package:flutter/material.dart';

class ProfilePrefs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader('Preferences'),
          CustomTile(label: 'Notification Settings'),
          CustomTile(label: 'Location Settings'),
        ],
      ),
    );
  }
}
