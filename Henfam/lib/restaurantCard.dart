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
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: <Widget>[
          photo,
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Padding(padding: EdgeInsets.only(bottom: 7)),
                Text(category.join(', ')),
                Padding(padding: EdgeInsets.only(bottom: 7)),
                Text("Open until " + closes,
                    style: TextStyle(color: Colors.green)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
