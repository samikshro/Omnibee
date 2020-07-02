import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/auth/root_page.dart';
import 'package:Henfam/pages/explore/matching_progress/matchingProgress.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/pages/explore/explore.dart';
import 'package:Henfam/pages/chat/chatList.dart';
import 'package:Henfam/pages/explore/delivery.dart';
import 'package:Henfam/pages/chat/chat.dart';
import 'package:Henfam/pages/explore/menu/menu.dart';
import 'package:Henfam/pages/explore/menu/menuOrderForm.dart';
import 'package:Henfam/pages/explore/menu/basketForm.dart';
import 'package:Henfam/pages/explore/request/request.dart';
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
        '/request': (context) => Request(),
        '/bigmode': (context) => BigMode(),
        '/matching': (context) => MatchingProgress(),
      },
      home: new RootPage(
        auth: new Auth(),
      ),
    );
  }
}
