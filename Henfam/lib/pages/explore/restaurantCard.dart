import 'package:flutter/material.dart';
import 'package:Henfam/models/menuModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantCard extends StatelessWidget {
  // final MenuModel restaurant;
  final DocumentSnapshot document;

  RestaurantCard(BuildContext context, {this.document}); //this.restaurant);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/Menu', arguments: document);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: <Widget>[
            //restaurant.smallPhoto,
            Image(
              image: AssetImage(document['small_photo']),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(document['rest_name'],
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(bottom: 7)),
                  Text(document['type_food'].join(', ')),
                  Padding(padding: EdgeInsets.only(bottom: 7)),
                  Text(
                    "Open until " + document['hours']['end_time'],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
