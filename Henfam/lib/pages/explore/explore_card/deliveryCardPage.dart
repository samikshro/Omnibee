import 'package:Henfam/models/order.dart';
import 'package:Henfam/bloc/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:Henfam/widgets/miniHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeliveryCardPage extends StatelessWidget {
  Widget _displayStatus(Order order, BuildContext context) {
    if (order.isDelivered) {
      return Center(
        child: Text('Waiting for confirmation from recipient...'),
      );
    } else {
      return Center(
        child: CupertinoButton(
          color: Theme.of(context).primaryColor,
          child: Text(
            "Mark Delivered",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () {
            BlocProvider.of<OrderBloc>(context).add(OrderMarkDelivered(order));
            Navigator.pop(context);
          },
        ),
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

  Widget _callPhoneNumber(Order order, BuildContext context) {
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
          Firestore.instance
              .collection('users')
              .document(order.uid)
              .get()
              .then((DocumentSnapshot document) {
            launchURL("tel:" + document['phone']);
          });
        },
      ),
    );
  }

  Widget _getOrderInformation(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Name'),
        _getRequesterName(order),
        MiniHeader('Items'),
        _getYourItems(order),
      ],
    );
  }

  Widget _getRequesterName(Order order) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(order.name),
    );
  }

  List<Widget> _getAddOns(List<dynamic> addOns) {
    if (addOns.length == 0) {
      return [Container()];
    }

    List<Widget> output = [];
    addOns.forEach((addOn) {
      output.add(Padding(
        padding: EdgeInsets.fromLTRB(15, 10, 0, 10),
        child: Text(addOn),
      ));
    });

    return output;
  }

  Widget _getYourItems(Order order) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: order.basket.length,
          itemBuilder: (BuildContext context, int index) {
            return ExpansionTile(
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.bottomLeft,
              title: Text(order.basket[index]['name']),
              subtitle: Text(
                '\$${order.price.toString()}',
              ),
              trailing: Icon(Icons.arrow_drop_down),
              children: _getAddOns(order.basket[index]['add_ons']),
            );
          }),
    );
  }

  Widget _getDeliveryWindow(Order order) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text("${order.startTime} to ${order.endTime}"),
    );
  }

  Widget _getDeliveryLocation(Order order) {
    List<String> wordList = order.location.split(',');
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
      child: Text(wordList[0]),
    );
  }

  Widget _getDeliveryInformation(Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MiniHeader('Delivery Window'),
        _getDeliveryWindow(order),
        MiniHeader('Destination'),
        _getDeliveryLocation(order),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Delivery'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MediumTextSection('Delivery Information'),
          _callPhoneNumber(order, context),
          _getDeliveryInformation(order),
          MediumTextSection('Order Information'),
          _getOrderInformation(order),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: _displayStatus(order, context),
          ),
        ],
      ),
    );
  }
}
