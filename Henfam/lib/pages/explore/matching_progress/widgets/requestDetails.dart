import 'package:Henfam/widgets/miniHeader.dart';
import 'package:flutter/material.dart';

class RequestDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          MiniHeader('Details of Request'),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Request Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              'Food Delivery from Oishii Bowl to\nOlin Library',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Items Requested',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
