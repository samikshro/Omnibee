import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigCard extends StatelessWidget {
  final DocumentSnapshot document;

  BigCard(BuildContext context, {this.document});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/accept_order');
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        shadowColor: Colors.amberAccent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text(document['user_id']['name'] +
                  ": " +
                  document['user_id']['rest_name_used']),
              subtitle: Text('Olin Library: 12PM-1PM'),
            ),
            Image(
              image: AssetImage(
                  "assets/oishii_bowl_pic1.png"), //document['small_photo']),
              fit: BoxFit.cover,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('ACCEPT'),
                  onPressed: () {/* ... */},
                  highlightColor: Colors.amberAccent,
                  textColor: Colors.amber,
                ),
                FlatButton(
                  child: const Text('EXPAND'),
                  onPressed: () {/* ... */},
                  highlightColor: Colors.amberAccent,
                  textColor: Colors.amber,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
