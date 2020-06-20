import 'package:flutter/material.dart';
import 'package:Henfam/models/menuModel.dart';

class RestaurantCard extends StatelessWidget {
  final MenuModel restaurant;

  RestaurantCard(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/Menu', arguments: restaurant);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: <Widget>[
            restaurant.smallPhoto,
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(restaurant.restName,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(bottom: 7)),
                  Text(restaurant.typeFood.join(', ')),
                  Padding(padding: EdgeInsets.only(bottom: 7)),
                  Text("Open until " + restaurant.hours,
                      style: TextStyle(color: Colors.green)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
