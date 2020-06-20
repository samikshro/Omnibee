import 'package:Henfam/pages/explore/helpcard.dart';
import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/menuModel.dart';
import 'package:Henfam/pages/explore/errandFee.dart';
import 'package:Henfam/pages/explore/deliveryHeader.dart';

class Delivery extends StatefulWidget {
  List<MenuModel> list;
  String headerCaption;
  Delivery({this.list, this.headerCaption});

  @override
  _DeliveryState createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
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
                  DeliveryHeader(
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
