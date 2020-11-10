import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

//TODO: move to using bloc
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

  double _roundDown(double value, int precision) {
    final isNegative = value.isNegative;
    final mod = pow(10.0, precision);
    final roundDown = (((value.abs() * mod).floor()) / mod);
    return isNegative ? -roundDown : roundDown;
  }

  @override
  Widget build(BuildContext context) {
    if (document['user_id']['is_accepted'] == true) {
      return Container();
    }
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
              title: Text(
                document['user_id']['rest_name_used'] +
                    " to " +
                    document['user_id']['location'],
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: _itemsToOrder(document),
            ),
            Text(
              "Minimum Earnings: " +
                  "\$" +
                  //TODO: used a hack to get correct truncation + floor round
                  // (0.2 * document['user_id']['price']).toString(),
                  _roundDown(0.2 * document['user_id']['price'], 2).toString(),
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.right,
            ),
            Text(
              "Deliver Between: " +
                  document['user_id']['delivery_window']['start_time'] +
                  "-" +
                  document['user_id']['delivery_window']['end_time'] +
                  "\n",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
            ),
            Image(
              image: AssetImage(document['user_id']['restaurant_pic']),
              fit: BoxFit.cover,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    'VIEW',
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
