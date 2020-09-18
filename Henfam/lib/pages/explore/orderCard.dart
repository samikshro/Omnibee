import 'package:Henfam/services/paymentService.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCard extends StatelessWidget {
  final DocumentSnapshot document;

  OrderCard(BuildContext context, {this.document});

  bool _isOrderComplete(DocumentSnapshot doc) {
    return doc['is_received'] != null && doc['is_delivered'] != null;
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
    if (_isOrderComplete(document)) return Container();
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
                    document['user_id']['delivery_window']['end_time']),
                children: _itemsToOrder(document)),
            Image(
              image: AssetImage("assets/oishii_bowl_pic1.png"),
              fit: BoxFit.cover,
            ),
            OrderCardButtonBar(document, context),
          ],
        ),
      ),
    );
  }
}

class OrderCardButtonBar extends StatelessWidget {
  final DocumentSnapshot document;
  final BuildContext context;

  OrderCardButtonBar(this.document, this.context);

  MainAxisAlignment _getAlignment() {
    if (document['is_delivered'] == null || document['is_delivered'] == false) {
      return MainAxisAlignment.end;
    } else {
      return MainAxisAlignment.spaceAround;
    }
  }

  void _markOrderComplete(DocumentSnapshot doc, BuildContext context) {
    // TODO: Commented code: in-app payments. Live code: marketplace transfers.
    // PaymentService.payment(
    //     doc, context, 50.0, doc['user_id']['payment_method_id']);
    PaymentService.paymentTransfer(doc, context, doc['price'], 1.23,
        doc['user_id']['payment_method_id'], doc['stripeAccountId']);
  }

  List<Widget> _getButtons(BuildContext context) {
    List<Widget> buttons = [
      FlatButton(
        child: const Text(
          'VIEW DETAILS',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/order_card_page', arguments: document);
        },
      ),
    ];

    if (document['is_delivered'] != null) {
      buttons.insert(
          0,
          RaisedButton(
            color: Color(0xffFD9827),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: const Text(
              'CONFIRM DELIVERY',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              _markOrderComplete(document, context);
            },
          ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: _getAlignment(),
      children: _getButtons(context),
    );
  }
}
