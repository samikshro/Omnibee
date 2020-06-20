import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'package:Henfam/pages/explore/errandFee.dart';
import 'package:Henfam/pages/explore/ctownDeliveryHeader.dart';

class CtownDelivery extends StatefulWidget {
  List<MenuModel> list;
  CtownDelivery({this.list});

  @override
  _CtownDeliveryState createState() => _CtownDeliveryState();
}

class _CtownDeliveryState extends State<CtownDelivery> {
  var _location = "Olin Library";

  @override
  Widget build(BuildContext context) {
    final List<MenuModel> args = ModalRoute.of(context).settings.arguments;
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
                  CtownDeliveryHeader(_location),
                ],
              ),
            ),
            ErrandFee(),
            LargeTextSection("Choose a restaurant"),
            Column(
              children:
                  args.map((menu) => menu.displayRestaurantCard()).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
