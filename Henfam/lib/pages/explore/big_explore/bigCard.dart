import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BigCard extends StatelessWidget {
  final DocumentSnapshot document;

  BigCard(BuildContext context, {this.document});

  List<Widget> _itemsToOrder(DocumentSnapshot document) {
    List<Widget> children = [];
    for (int i = 0; i < document['user_id']['basket'].length; i++) {
      children.add(ListTile(
        title: Text(
          document['user_id']['basket'][i]['name'],
        ),
        trailing: Text(document['user_id']['basket'][i]['price'].toString()),
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/accept_order', arguments: document);
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ExpansionTile(
                leading: Icon(Icons.fastfood),
                title: Text(document['user_id']['name'] +
                    ": " +
                    document['user_id']['rest_name_used']),
                subtitle: Text(document['user_id']['rest_name_used'] +
                    ": " +
                    document['user_id']['delivery_window']['start_time'] +
                    "-" +
                    document['user_id']['delivery_window']['end_time']),
                children: _itemsToOrder(document)),
            Image(
              image: AssetImage("assets/oishii_bowl_pic1.png"),
              fit: BoxFit.cover,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    'ACCEPT',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/accept_order',
                        arguments: document);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
