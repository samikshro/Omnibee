import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/repository/repositories.dart';
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
    /* print("LandingPageState: build");
    return BlocProvider<OrderBloc>(
      lazy: false,
      create: (BuildContext orderContext) => OrderBloc(
          ordersRepository: FirebaseOrdersRepository(),
          authBloc: BlocProvider.of<AuthBloc>(orderContext))
        ..add(OrderLoaded()),
      child:  */

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

    /*   ,
    ); */
  }
}
