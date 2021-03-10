import 'dart:io';

import 'package:Omnibee/models/models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryInfo extends StatelessWidget {
  final Order order;
  final double fontSize;
  final double boldFontSize;
  final int isDeliveryPage;
  final bool isRunner;

  DeliveryInfo(
    this.order,
    this.fontSize,
    this.boldFontSize,
    this.isDeliveryPage,
    this.isRunner,
  );

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

  Widget _getRunnerName(Order order) {
    if (order.isAccepted) {
      return Container(
          child: Text(
        order.runnerName,
        style: TextStyle(fontSize: fontSize),
      ));
    } else {
      return Container(
          child: Text(
        'Order not been accepted by anyone.',
        style: TextStyle(fontSize: fontSize),
      ));
    }
  }

  Widget _getRequesterName(Order order) {
    return Container(
        child: Text(
      order.name,
      style: TextStyle(fontSize: fontSize),
    ));
  }

  void _launchMap(BuildContext context, lat, lng) async {
    var urlGoogleMaps =
        "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    var urlAppleMaps = 'https://maps.apple.com/?q=$lat,$lng';

    if (Platform.isAndroid) {
      if (await canLaunch(urlGoogleMaps)) {
        await launch(urlGoogleMaps);
      } else {
        throw 'Could not launch $urlGoogleMaps';
      }
    } else {
      urlGoogleMaps =
          "comgooglemaps://?saddr=&daddr=$lat,$lng&directionsmode=walking";
      if (await canLaunch(urlAppleMaps)) {
        await launch(urlAppleMaps);
      } else if (await canLaunch(urlGoogleMaps)) {
        await launch(urlGoogleMaps);
      } else {
        throw 'Could not launch map on iOS';
      }
    }
  }

  Widget _getLocationWidget(
    BuildContext context,
    String location,
    Order order,
    int isDeliveryPage,
  ) {
    if (isDeliveryPage == 1) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
        child: ListTile(
            title: Text(
              location,
              style: TextStyle(fontSize: fontSize),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.explore,
                size: 35,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () async {
                double latitude = order.userCoordinates.x;
                double longitude = order.userCoordinates.y;
                _launchMap(context, latitude, longitude);
              },
            )),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
        child: ListTile(
          title: Text(
            location,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String location = _getDeliveryLocation(order);
    String nameTitle = isRunner ? "Requester Name" : "Runner Name";
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            nameTitle,
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child:
                  isRunner ? _getRequesterName(order) : _getRunnerName(order)),
          Text(
            'Drop-off Location:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          _getLocationWidget(context, location, order, isDeliveryPage),
          Text(
            'Delivery Window:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Text(order.getDeliveryWindow(),
                style: TextStyle(fontSize: fontSize)),
          ),
          Text(
            'Status:',
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: boldFontSize),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: _getStatus(order),
          )
        ],
      ),
    );
  }
}
