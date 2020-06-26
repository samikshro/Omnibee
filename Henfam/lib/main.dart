import 'package:flutter/material.dart';

import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/chat/chatList.dart';
import 'package:Henfam/pages/explore/delivery.dart';
import 'package:Henfam/pages/chat/chat.dart';
import 'package:Henfam/pages/explore/menu/menu.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/pages/account/profile.dart';
import 'package:Henfam/pages/explore/big_explore/bigMode.dart';

void main() {
  runApp(HenfamBasic());
}

class HenfamBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData baseTheme = ThemeData.light();
    return MaterialApp(
      theme: ThemeData(
          textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black)),
          buttonTheme:
              baseTheme.buttonTheme.copyWith(buttonColor: Colors.amber)),
      initialRoute: '/',
      routes: {
        '/explore': (context) => Explore(),
        '/Delivery': (context) => Delivery(),
        '/chatlist': (context) => ChatList(),
        '/chat': (context) => Chat(),
        '/Menu': (context) => Menu(),
        '/menu_order_form': (context) => MenuOrderForm(),
        '/basket_form': (context) => Basket(),
        // '/request': (context) => Request(),
        '/bigmode': (context) => BigMode()
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
              //Icon(Icons.local_offer),
              BigMode(),
              Profile(),
            ],
          ),
        ),
      ),
    );
  }
}
