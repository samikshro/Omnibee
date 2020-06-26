import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileEarnings.dart';
import 'package:Henfam/pages/account/widgets/profileErrandSnapshot.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/pages/account/widgets/profilePointsBar.dart';
import 'package:Henfam/pages/account/widgets/profilePrefs.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
          backgroundColor: Colors.amber[700],
        ),
        body: ListView(
          children: <Widget>[
            ProfileHeader('Gracie Matthews', 'gmm322'),
            ProfileErrandSnapshot(),
            Divider(
              color: Colors.black,
            ),
            ProfileEarnings(14.69, 3.65),
            Divider(
              color: Colors.black,
            ),
            ProfilePointsBar(350),
            Divider(
              color: Colors.black,
            ),
            ProfilePrefs(),
            Divider(
              color: Colors.black,
            ),
            ProfileContact(),
          ],
        ));
  }
}
