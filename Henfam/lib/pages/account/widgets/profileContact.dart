import 'package:Henfam/pages/account/widgets/customTile.dart';
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
          CustomTile(label: 'Log out', onTap: signOut),
        ],
      ),
    );
  }
}
