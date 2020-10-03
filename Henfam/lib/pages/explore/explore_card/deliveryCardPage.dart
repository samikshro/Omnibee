import 'package:Henfam/pages/explore/explore_card/widgets/documentCallbackButton.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:Henfam/widgets/miniHeader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCardPage extends StatelessWidget {
  void _markOrderComplete(DocumentSnapshot doc) {
    final db = Firestore.instance;
    db
        .collection('orders')
        .document(doc.documentID)
        .setData({'is_delivered': true}, merge: true);
  }

  bool _isDeliveryComplete(DocumentSnapshot doc) {
    return doc['is_delivered'] != null;
  }

  Widget _displayStatus(DocumentSnapshot doc, BuildContext context) {
    if (_isDeliveryComplete(doc)) {
      return Center(
        child: Text('Waiting for confirmation from recipient...'),
      );
    } else {
      return DocumentCallbackButton(
        'Delivery Complete',
        _markOrderComplete,
        doc,
        context,
      );
    }
  }

  static void launchURL(String s) async {
    String url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _callPhoneNumber(DocumentSnapshot doc, BuildContext context) {
    return Center(
      child: CupertinoButton(
        color: Theme.of(context).primaryColor,
        child: Text(
          "Call Requester",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          print("in onPressed");
          Firestore.instance
              .collection('users')
              .document(doc["user_id"]["uid"])
              .get()
              .then((DocumentSnapshot document) {
            print("in then anonymous function");
            print(document["phone"]);
            print("past");
            launchURL("tel:" + document['phone']);
          });
        },
      ),
    );
  }

  Widget _getOrderInformation(DocumentSnapshot doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Name'),
        _getRequesterName(doc),
        MiniHeader('Items'),
        _getYourItems(doc),
      ],
    );
  }

  Widget _getRequesterName(DocumentSnapshot doc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(doc['user_id']['name']),
    );
  }

  Widget _getYourItems(DocumentSnapshot doc) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 5, 0, 10),
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

  Widget _getDeliveryWindow(DocumentSnapshot doc) {
    String startTime = doc['user_id']['delivery_window']['start_time'];
    String endTime = doc['user_id']['delivery_window']['end_time'];
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text("$startTime to $endTime"),
    );
  }

  Widget _getDeliveryLocation(DocumentSnapshot doc) {
    String location = doc['user_id']['location'];
    List<String> wordList = location.split(',');
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(wordList[0]),
    );
  }

  Widget _getDeliveryInformation(DocumentSnapshot doc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Delivery Window'),
        _getDeliveryWindow(doc),
        MiniHeader('Destination'),
        _getDeliveryLocation(doc),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Delivery'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Information'),
          _callPhoneNumber(document, context),
          _getDeliveryInformation(document),
          MediumTextSection('Order Information'),
          _getOrderInformation(document),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: _displayStatus(document, context),
          ),
        ],
      ),
    );
  }
}
