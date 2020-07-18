import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileEarnings.dart';
import 'package:Henfam/pages/account/widgets/profileErrandSnapshot.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/pages/account/widgets/profilePointsBar.dart';
import 'package:Henfam/pages/account/widgets/profilePrefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String> _getName() async {
    final _firestore = Firestore.instance;
    final docSnapShot =
        await _firestore.collection('users').document(userId).get();
    return docSnapShot['name'];
  }

  @override
  Widget build(BuildContext context) {
    final _firestore = Firestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: FutureBuilder<String>(
          future: _getName(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) return Center(child: Text('Loading...'));
            return ListView(
              children: <Widget>[
                ProfileHeader(snapshot.data, 'gmm22'),
                /* ProfileErrandSnapshot(),
            Divider(),
            ProfileEarnings(14.69, 3.65),
            Divider(),
            ProfilePointsBar(350),
            Divider(),
            ProfilePrefs(),
            Divider(), */
                ProfileContact(signOut),
              ],
            );
          }),
    );
  }
}
