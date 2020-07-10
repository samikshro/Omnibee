import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2.0,
      shadowColor: Colors.amberAccent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.fastfood),
            title: Text('Oiishi Bowl'),
            subtitle: Text('Olin Library: Deliver food to Sandra'),
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(15),
          // child:
          Image(
            image: AssetImage(
                "assets/oishii_bowl_pic1.png"), //document['small_photo']),
            fit: BoxFit.cover,
          ),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: const Color(0xff7c94b6),
          //     image: DecorationImage(
          //       image: AssetImage(
          //           "assets/oishii_bowl_pic1.png"), //document['small_photo']),
          //       fit: BoxFit.cover,
          //     ),
          //     border: Border.all(
          //       color: Colors.black,
          //       width: 8,
          //     ),
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          // ),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: const Text('SHARE'),
                onPressed: () {/* ... */},
                highlightColor: Colors.amberAccent,
                textColor: Colors.amber,
              ),
              FlatButton(
                child: const Text('CHAT'),
                onPressed: () {/* ... */},
                highlightColor: Colors.amberAccent,
                textColor: Colors.amber,
              ),
              FlatButton(
                child: const Text('EDIT'),
                onPressed: () {/* ... */},
                highlightColor: Colors.amberAccent,
                textColor: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
