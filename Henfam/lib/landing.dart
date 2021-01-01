import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/account/profile.dart';
import 'package:Henfam/notifications/notificationHandler.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key key,
    /*this.auth*/
  }) : super(key: key);

  //final BaseAuth auth;

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                Profile(/*widget.auth*/),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
