import 'package:Henfam/pages/explore/explore_card/widgets/documentCallbackButton.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stripe_payment/stripe_payment.dart';
import 'package:Henfam/services/paymentService.dart';

class OrderCardPage extends StatefulWidget {
  @override
  _OrderCardPageState createState() => _OrderCardPageState();
}

class _OrderCardPageState extends State<OrderCardPage> {
  final db = Firestore.instance;

  bool _isDeliveryComplete(DocumentSnapshot doc) {
    return doc['is_delivered'] != null;
  }

  //TODO: deprecated. remove and update this code.
  // void _confirmDeliveryComplete(DocumentSnapshot doc, BuildContext context) {
  //   PaymentService.payment(
  //       doc, context, 100.0, doc['user_id']['payment_method_id']);
  // }

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

  String _getDeliveryWindow(DocumentSnapshot doc) {
    String startTime = doc['user_id']['delivery_window']['start_time'];
    String endTime = doc['user_id']['delivery_window']['end_time'];
    return "$startTime to $endTime";
  }

  void _deleteDocument(DocumentSnapshot doc, BuildContext context) async {
    await db.collection('orders').document(doc.documentID).delete();
  }

  Widget _stillWaitingForMatch(DocumentSnapshot doc) {
    if (doc['user_id']['is_accepted'] == true) {
      return Container(child: Text('You have been paired with a big bee!'));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Waiting for a Big Bee...'),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text('Order will expire at ${_getExpirationTime(doc)}'),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      );
    }
  }

  Widget _getYourItems(DocumentSnapshot doc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 0, 0),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: doc['user_id']['basket'].length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(doc['user_id']['basket'][index]['name']),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text('\$${doc['user_id']['price'].toString()}'),
                )
              ],
            );
          }),
    );
  }

  Widget _getDeliveryInformation(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Drop-off Location:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getDeliveryLocation(doc)),
          ),
          Text(
            'Delivery Window:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(_getDeliveryWindow(doc)),
          ),
          Text(
            'Status:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: _stillWaitingForMatch(doc),
          ),
        ],
      ),
    );
  }

  Widget _getOrderInformation(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Your items:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          _getYourItems(doc),
        ],
      ),
    );
  }

  Widget _controlButtons(DocumentSnapshot doc, BuildContext context) {
    if (_isDeliveryComplete(doc)) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
        child: Center(
          child: Text('Order delivered!'),
        ),
      );
    } else if (doc['user_id']['is_accepted'] == true) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
        child: Center(
          child: Text('Order is on the way!'),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: DocumentCallbackButton(
            'Cancel Order', _deleteDocument, doc, context),
      );
    }
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
          _getDeliveryInformation(document),
          MediumTextSection('Order Information'),
          _getOrderInformation(document),
          _controlButtons(document, context),
        ],
      ),
    );
  }
}
