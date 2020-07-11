import 'package:flutter/material.dart';

class AcceptOrderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          leading: FlutterLogo(),
          title: Text('Oishii Bowl --> Olin Library'),
        ),
        ListTile(
          dense: true,
          leading: FlutterLogo(),
          title: Text('Deliver between 7.30pm - 8.30pm'),
        ),
        ListTile(
          dense: true,
          leading: FlutterLogo(),
          title: Text('3 items, \$42.10 subtotal'),
        ),
      ],
    );
  }
}
