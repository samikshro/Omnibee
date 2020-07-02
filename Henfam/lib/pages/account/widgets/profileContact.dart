import 'package:Henfam/pages/account/widgets/customTile.dart';
import 'package:Henfam/pages/account/widgets/sectionHeader.dart';
import 'package:flutter/material.dart';

class ProfileContact extends StatelessWidget {
  final Function signOut;

  ProfileContact(this.signOut);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader('Contact'),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Text(
              'Phone',
              style: TextStyle(fontSize: 18),
            ),
          ),
          CustomTile(label: '(932) 555-1212'),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Text(
              'Support',
              style: TextStyle(fontSize: 18),
            ),
          ),
          CustomTile(label: 'Help'),
          CustomTile(label: 'Feedback'),
          CustomTile(label: 'Log out', onTap: signOut),
        ],
      ),
    );
  }
}
