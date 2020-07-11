import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/auth/root_page.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder.dart';
import 'package:Henfam/pages/explore/matching_progress/matchingProgress.dart';
import 'package:Henfam/pages/map/expandedMap.dart';
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
import 'package:Henfam/pages/explore/big_explore/bigFilter.dart';

void main() {
  runApp(HenfamBasic());
}

class HenfamBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.amber,
        primaryColorDark: Color(0xff222831),
        accentColor: Colors.blue,
        backgroundColor: Colors.white,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
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
        '/accept_order': (context) => AcceptOrder(),
        '/expanded_map': (context) => ExpandedMap(),
        //'/big_filter': (context) => BigFilter(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "/big_filter") {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => BigFilter(),
            transitionsBuilder: (_, anim, __, child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return //FadeTransition(opacity: anim, child: child);
                  // ScaleTransition(scale: anim, child: child);
                  SlideTransition(position: anim.drive(tween), child: child);
            },
          );
        }
      },
      home: new RootPage(
        auth: new Auth(),
      ),
    );
  }
}
