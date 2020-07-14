import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileEarnings.dart';
import 'package:Henfam/pages/account/widgets/profileErrandSnapshot.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/pages/account/widgets/profilePointsBar.dart';
import 'package:Henfam/pages/account/widgets/profilePrefs.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  Profile(this.auth, this.logoutCallback, this.userId);

  signOut() async {
    try {
      await auth.signOut();
      logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
        ),
        body: ListView(
          children: <Widget>[
            ProfileHeader('Gracie Matthews', 'gmm322'),
            ProfileErrandSnapshot(),
            Divider(),
            ProfileEarnings(14.69, 3.65),
            Divider(),
            ProfilePointsBar(350),
            Divider(),
            ProfilePrefs(),
            Divider(),
            ProfileContact(signOut),
          ],
        ));
  }
}
