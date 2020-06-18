import 'package:flutter/material.dart';

import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/models/ctownMenuModel.dart';
import 'package:Henfam/pages/explore/errandFee.dart';
import 'package:Henfam/pages/explore/ctownDeliveryHeader.dart';

class CtownDelivery extends StatefulWidget {
  @override
  _CtownDeliveryState createState() => _CtownDeliveryState();
}

class _CtownDeliveryState extends State<CtownDelivery> {
  var _location = "Olin Library";

  final favorites = [
    MenuModel(
      restName: 'Oishii Bowl',
      typeFood: ['Asian', 'Japanese'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/oishiibowl.png'),
      ),
    ),
    MenuModel(
      restName: 'Kung Fu Tea',
      typeFood: ['Beverages'],
      hours: '9PM',
      photo: Image(
        image: AssetImage('assets/kungfutea.png'),
      ),
    ),
  ];

  final moreRestaurants = [
    MenuModel(
      restName: 'Insomnia Cookies',
      typeFood: ['Cookies', 'Desserts'],
      hours: '1AM',
      photo: Image(
        image: AssetImage('assets/insomnia.png'),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
            LargeTextSection("My Favorites"),
            Column(
              children: favorites
                  .map((menu) => menu.displayRestaurantCard())
                  .toList(),
            ),
            LargeTextSection("More Restaurants"),
            Column(
              children: moreRestaurants
                  .map((menu) => menu.displayRestaurantCard())
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
