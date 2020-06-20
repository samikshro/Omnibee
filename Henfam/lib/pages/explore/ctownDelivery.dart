import 'package:Henfam/pages/explore/helpcard.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'package:Henfam/pages/explore/errandFee.dart';
import 'package:Henfam/pages/explore/ctownDeliveryHeader.dart';

class CtownDelivery extends StatefulWidget {
  List<MenuModel> list;
  String headerCaption;
  CtownDelivery({this.list, this.headerCaption});

  @override
  _CtownDeliveryState createState() => _CtownDeliveryState();
}

class _CtownDeliveryState extends State<CtownDelivery> {
  var _location = "Olin Library";

  @override
  Widget build(BuildContext context) {
    final DeliveryArguments args = ModalRoute.of(context).settings.arguments;
    final menuList = args.menus;
    final String headerCaption = args.headerCaption;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  CtownDeliveryHeader(
                    _location,
                    headerCaption,
                  ),
                ],
              ),
            ),
            ErrandFee(),
            LargeTextSection("Choose a restaurant"),
            Column(
              children:
                  menuList.map((menu) => menu.displayRestaurantCard()).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
