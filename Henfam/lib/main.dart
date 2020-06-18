import 'package:flutter/material.dart';

import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/chat/chatList.dart';
import 'package:Henfam/pages/explore/ctownDelivery.dart';
import 'package:Henfam/pages/chat/chat.dart';
import 'package:Henfam/pages/explore/ctownMenu.dart';

void main() {
  runApp(HenfamBasic());
}

class HenfamBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/explore': (context) => Explore(),
        '/ctowndelivery': (context) => CtownDelivery(),
        '/chatlist': (context) => ChatList(),
        '/chat': (context) => Chat(),
        '/ctownmenu': (context) => CtownMenu(),
      },
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Henfam'),
          //   backgroundColor: Colors.amber,
          // ),
          bottomNavigationBar: TabBar(
              indicatorColor: Colors.amber,
              labelColor: Colors.amber,
              tabs: [
                Tab(icon: Icon(Icons.explore)),
                Tab(icon: Icon(Icons.chat)),
                Tab(icon: Icon(Icons.local_offer)),
                Tab(icon: Icon(Icons.account_circle)),
              ]),
          body: TabBarView(
            children: [
              Explore(),
              ChatList(),
              Icon(Icons.local_offer),
              CtownMenu(),
              //Icon(Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}
