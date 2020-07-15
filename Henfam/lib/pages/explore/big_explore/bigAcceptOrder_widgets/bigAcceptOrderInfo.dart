import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder.dart';
import 'package:flutter/material.dart';

class AcceptOrderInfo extends StatelessWidget {
  List<Map<String, Object>> requesters;

  AcceptOrderInfo(this.requesters);

  Widget _getSubtotal() {
    int numItems = requesters.length;
    double subtotal = 0;
    for (int i = 0; i < numItems; i++) {
      if (requesters[i]['selected'] == true) {
        subtotal += requesters[i]['item_cost'];
      }
    }

    return Text(
      '${numItems.toString()} items, \$${subtotal.toString()} subtotal',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: Icon(
            Icons.location_on,
          ),
          title: Text('Oishii Bowl -> Olin Library'),
        ),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.alarm,
          ),
          title: Text('Deliver between 7.30pm - 8.30pm'),
        ),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.shopping_basket,
          ),
          title: _getSubtotal(),
        ),
      ],
    );
  }
}
