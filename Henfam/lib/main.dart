import 'package:Henfam/bloc/basket/basket_bloc.dart';
import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/bloc/menu_order_form/menu_order_form_bloc.dart';
import 'package:Henfam/bloc/simple_bloc_observer.dart';
import 'package:flutter/services.dart';
import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/auth/root_page.dart';
import 'package:Henfam/notifications/notificationHandler.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder.dart';

import 'package:Henfam/pages/explore/explore_card/deliveryCardPage.dart';
import 'package:Henfam/pages/explore/explore_card/orderCardPage.dart';
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

import 'package:Henfam/pages/explore/big_explore/bigMode.dart';
import 'package:Henfam/pages/explore/big_explore/bigFilter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(HenfamBasic());
}

class HenfamBasic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();

    return MultiBlocProvider(
      providers: [
        BlocProvider<BasketBloc>(
          create: (BuildContext context) => BasketBloc()..add(BasketLoaded()),
        ),
        BlocProvider<RestaurantBloc>(
          create: (BuildContext context) =>
              RestaurantBloc()..add(RestaurantLoaded()),
        ),
        BlocProvider<MenuOrderFormBloc>(
          create: (BuildContext context) =>
              MenuOrderFormBloc()..add(MenuOrderFormLoaded()),
        ),
      ],
      child: MaterialApp(
        theme: _appTheme,
        initialRoute: '/',
        routes: {
          '/explore': (context) => SafeArea(
                top: false,
                child: Explore(),
              ),
          '/Delivery': (context) => SafeArea(
                top: false,
                child: Delivery(),
              ),
          '/chatlist': (context) => SafeArea(
                top: false,
                child: ChatList(),
              ),
          '/chat': (context) => SafeArea(
                top: false,
                child: Chat(),
              ),
          '/Menu': (context) => SafeArea(
                top: false,
                child: Menu(),
              ),
          '/menu_order_form': (context) => SafeArea(
                top: false,
                child: MenuOrderForm(),
              ),
          '/basket_form': (context) => SafeArea(
                top: false,
                child: Basket(),
              ),
          '/request': (context) => SafeArea(
                top: false,
                child: Request(),
              ),
          '/bigmode': (context) => SafeArea(
                top: false,
                child: BigMode(),
              ),
          '/matching': (context) => SafeArea(
                top: false,
                child: MatchingProgress(),
              ),
          '/accept_order': (context) => SafeArea(
                top: false,
                child: AcceptOrder(),
              ),
          '/expanded_map': (context) => SafeArea(
                top: false,
                child: ExpandedMap(),
              ),
          '/order_card_page': (context) => SafeArea(
                top: false,
                child: OrderCardPage(),
              ),
          '/delivery_card_page': (context) => SafeArea(
                top: false,
                child: DeliveryCardPage(),
              ),
        },
        onGenerateRoute: (settings) {
          if (settings.name == "/big_filter") {
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => BigFilter(),
              transitionsBuilder: (_, anim, __, child) {
                var begin = Offset(0.0, 1.0);
                var end = Offset.zero;
                var curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                return SlideTransition(
                    position: anim.drive(tween), child: child);
              },
            );
          } else {
            return null;
          }
        },
        home: SafeArea(
          top: false,
          child: NotificationHandler(
            child: new RootPage(
              auth: new Auth(),
            ),
          ),
        ),
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
    appBarTheme: base.appBarTheme.copyWith(
      color: Colors.white,
      brightness: Brightness.light,
    ),
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
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
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
