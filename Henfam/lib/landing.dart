import 'package:Henfam/auth/authentication.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/account/profile.dart';
import 'package:Henfam/notifications/notificationHandler.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

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
    return NotificationHandler(
      child: Container(
        child: DefaultTabController(
          length: 2, //4,
          child: Scaffold(
            bottomNavigationBar: TabBar(
                indicatorColor: Theme.of(context).primaryColor,
                labelColor: Theme.of(context).primaryColor,
                tabs: [
                  Tab(icon: Icon(Icons.explore, size: 35)),
                  // Tab(icon: Icon(Icons.chat)),
                  // Tab(icon: Icon(Icons.local_offer)),
                  Tab(icon: Icon(Icons.account_circle, size: 35)),
                ]),
            body: TabBarView(
              children: [
                Explore(),
                // ChatList(),
                // BigMode(),
                Profile(auth, logoutCallback, userId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
