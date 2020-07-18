import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryCard extends StatelessWidget {
  final DocumentSnapshot document;

  DeliveryCard(BuildContext context, {this.document});

  String _getEarnings() {
    double minEarnings = 0.0;
    for (int j = 0; j < document['user_id']['basket'].length; j++) {
      minEarnings += document['user_id']['basket'][j]['price'] * .33;
    }

    return minEarnings.toStringAsFixed(2);
  }

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
      onTap: () {},
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
                    document['user_id']['delivery_window']['end_time'] +
                    "\nEarnings: \$${_getEarnings()}"),
                children: _itemsToOrder(document)),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text(
                    'VIEW DETAILS',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/delivery_card_page',
                      arguments: document,
                    );
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
