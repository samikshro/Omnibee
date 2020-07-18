import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:Henfam/widgets/miniHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderCardPage extends StatelessWidget {
  final db = Firestore.instance;

  Future<String> _getRunnerName(DocumentSnapshot doc) async {
    final runnerId = doc['user_id']['runner'];
    final runner = await db.collection('users').document(runnerId).get();
    return runner['name'];
  }

  String _getExpirationTime(DocumentSnapshot doc) {
    DateTime time = doc['user_id']['expiration_time'].toDate();
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(time);
    return formatted;
  }

  String _getDeliveryLocation(DocumentSnapshot doc) {
    String location = doc['user_id']['location'];
    List<String> wordList = location.split(',');
    return wordList[0];
  }

  Widget _stillWaitingForMatch(DocumentSnapshot doc) {
    if (doc['user_id']['is_accepted'] == false) {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Container(child: Text('You have been paired with a big bee!')),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
                'Still waiting for a big bee\nOrder will expire at ${_getExpirationTime(doc)}'),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Text('Delivering to: ${_getDeliveryLocation(doc)}'),
          ],
        ),
      );
    }
  }

  Widget _getOrderInformation(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Container(child: Text('test')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Information'),
          _stillWaitingForMatch(document),
          MediumTextSection('Order Information'),
          _getOrderInformation(document),
        ],
      ),
    );
  }
}
