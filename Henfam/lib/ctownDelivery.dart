import 'package:flutter/material.dart';

import 'largeTextSection.dart';
import 'restaurantCard.dart';

class CtownDelivery extends StatefulWidget {
  @override
  _CtownDeliveryState createState() => _CtownDeliveryState();
}

class _CtownDeliveryState extends State<CtownDelivery> {
  var _myFavorites = [
    {
      'photo': Image(
        image: AssetImage('assets/oishiibowl.png'),
      ),
      'name': 'Oishii Bowl',
      'category': ['Asian', 'Japanese'],
      'closes': '9PM'
    },
    {
      'photo': Image(
        image: AssetImage('assets/kungfutea.png'),
      ),
      'name': 'Kung Fu Tea',
      'category': ['Beverages'],
      'closes': '9PM'
    },
    {
      'photo': Image(
        image: AssetImage('assets/insomnia.png'),
      ),
      'name': 'Insomnia Cookies',
      'category': ['Cookies', 'Desserts'],
      'closes': '1AM'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          LargeTextSection("My Favorites"),
          Flexible(
            child: GridView.count(
              // crossAxisCount is the number of columns
              crossAxisCount: 1,
              // This creates two columns with two items in each column
              children: List.generate(_myFavorites.length, (index) {
                return RestaurantCard(
                  _myFavorites[index]['photo'],
                  _myFavorites[index]['name'],
                  _myFavorites[index]['category'],
                  _myFavorites[index]['closes'],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
