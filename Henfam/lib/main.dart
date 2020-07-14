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
      theme: _appTheme,
      // theme: ThemeData(
      //   primaryColor: Color(0xfd9827), //Colors.amber,
      //   primaryColorDark: Color(0xff222831),
      //   accentColor: Colors.blue,
      //   backgroundColor: Colors.white,
      //   buttonTheme: ButtonThemeData(
      //     buttonColor: Colors.amber,
      //     textTheme: ButtonTextTheme.primary,
      //   ),
      // ),
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
              return SlideTransition(position: anim.drive(tween), child: child);
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

final ThemeData _appTheme = _buildTheme();

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: Color(0xff009DFF),
    primaryColor: Color(0xfffd9827),
    buttonColor: Color(0xffFD9827),
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textSelectionColor: Color(0xfffdbf2d),
    errorColor: Color(0xFFC5032B),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: Color(0xffFD9827),
      colorScheme: base.colorScheme.copyWith(
        secondary: Color(0xfffdbf2d),
      ),
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: Color(0xff008ae0)),
    // inputDecorationTheme: InputDecorationTheme(
    //   focusedBorder: CutCornersBorder(
    //     borderSide: BorderSide(
    //       width: 2.0,
    //       color: kShrineBrown900,
    //     ),
    //   ),
    //   border: CutCornersBorder(),
    // ),
    textTheme: _buildShrineTextTheme(base.textTheme),
    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6.copyWith(fontSize: 18.0),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(
        fontFamily: 'Rubik',
        displayColor: Color(0xFF442B2D),
        bodyColor: Color(0xFF442B2D),
      );
}
