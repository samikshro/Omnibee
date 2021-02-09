import 'package:Henfam/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeliveryInfo extends StatelessWidget {
  final Order order;
  final double fontSize;
  final double boldFontSize;

  DeliveryInfo(this.order, this.fontSize, this.boldFontSize);

  String _getDeliveryLocation(Order order) {
    String location = order.location;
    List<String> wordList = location.split(',');
    return wordList[0];
  }

  String _getExpirationTime(Order order) {
    DateTime time = order.expirationTime;
    final DateFormat formatter = DateFormat('jm');
    final String formatted = formatter.format(time);
    return formatted;
  }

  Widget _getStatus(Order order) {
    if (order.isReceived) {
      return Container(
          child: Text(
        'Order Complete!',
        style: TextStyle(fontSize: fontSize),
      ));
    } else if (order.isDelivered) {
      return Container(
          child: Text(
        'Order Delivered! Need confirmation to complete the order.',
        style: TextStyle(fontSize: fontSize),
      ));
    } else if (order.isAccepted) {
      return Container(
          child: Text(
        'Order is on the way!',
        style: TextStyle(fontSize: fontSize),
      ));
    } else if (order.isExpired()) {
      return Container(
          child: Text(
        'Order expired before being accepted.',
        style: TextStyle(fontSize: fontSize),
      ));
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Waiting for a Runner...',
            style: TextStyle(fontSize: fontSize),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Text(
            'Order will expire at ${_getExpirationTime(order)}',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Drop-off Location:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text(_getDeliveryLocation(order),
                style: TextStyle(fontSize: fontSize)),
          ),
          Text(
            'Delivery Window:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
            child: Text(order.getDeliveryWindow(),
                style: TextStyle(fontSize: fontSize)),
          ),
          Text(
            'Status:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: _getStatus(order),
          )
        ],
      ),
    );
  }
}
