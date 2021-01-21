import 'package:Henfam/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/account/profile.dart';
import 'package:Henfam/notifications/notificationHandler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key key,
  }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return NotificationHandler(
        uid: (state as Authenticated).user.uid,
        child: Container(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              bottomNavigationBar: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(icon: Icon(Icons.explore, size: 35)),
                    Tab(icon: Icon(Icons.account_circle, size: 35)),
                  ]),
              body: TabBarView(
                children: [
                  Explore(),
                  Profile(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
