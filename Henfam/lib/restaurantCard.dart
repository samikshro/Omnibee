import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final Image photo;
  final String name;
  final List<String> category;
  final String closes;

  RestaurantCard(this.photo, this.name, this.category, this.closes);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          photo,
          Column(
            children: <Widget>[
              Text(name),
              Text(category[0]),
            ],
          )
        ],
      ),
    );
  }
}
