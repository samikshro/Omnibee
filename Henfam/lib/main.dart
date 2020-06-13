import 'package:flutter/material.dart';

import 'explore.dart';
import 'chatList.dart';
import 'ctownDelivery.dart';
import 'chat.dart';

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
        '/chatlist' : (context) => ChatList(),
        '/chat' : (context) => Chat(),
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
              Icon(Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}


