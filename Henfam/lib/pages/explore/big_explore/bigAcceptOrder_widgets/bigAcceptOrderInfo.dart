import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AcceptOrderInfo extends StatelessWidget {
  List<DocumentSnapshot> requests;
  List<bool> selectedList;

  AcceptOrderInfo(this.requests, this.selectedList);

  Widget _getSubtotal() {
    int numItems = 0;
    double subtotal = 0;
    for (int i = 0; i < requests.length; i++) {
      if (selectedList[i] == true) {
        for (int j = 0; j < requests[i]['user_id']['basket'].length; j++) {
          numItems += 1;
          subtotal += requests[i]['user_id']['basket'][j]['price'];
        }
      }
    }

    return Text(
      '${numItems.toString()} items, \$${subtotal.toStringAsFixed(2)} subtotal',
    );
  }

  String _getStartAndEndLocations() {
    String startLocation = requests[0]['user_id']['rest_name_used'];
    List<String> endLocations = [];
    for (int i = 0; i < requests.length; i++) {
      if (selectedList[i] == true) {
        String location = requests[i]['user_id']['location'];
        List<String> locList = location.split(',');
        endLocations.add(locList[0]);
      }
    }

    String locations = '';
    for (int i = 0; i < endLocations.length; i++) {
      bool isLastLocation = i == endLocations.length - 1;
      bool isOnlyLocation = endLocations.length == 1;

      if (isLastLocation && !isOnlyLocation) {
        locations += "and ${endLocations[i]}";
      } else if (isOnlyLocation) {
        locations += "${endLocations[i]}";
      } else {
        locations += "${endLocations[i]}, ";
      }
    }

    return "$startLocation to $locations";
  }

  String _getDeliveryRange() {
    String lowerBoundTime = '';
    String upperBoundTime = '';
    double lowerBoundDouble = 0.0;
    double upperBoundDouble = 0.0;
    for (int i = 0; i < requests.length; i++) {
      if (selectedList[i] == true) {
        String startTime =
            requests[i]['user_id']['delivery_window']['start_time'];
        double startTimeDouble = _parseTimeToDouble(startTime);
        bool lowerLessThan = startTimeDouble > lowerBoundDouble;
        lowerBoundTime = lowerLessThan ? startTime : lowerBoundTime;
        lowerBoundDouble = lowerLessThan ? startTimeDouble : lowerBoundDouble;

        String endTime = requests[i]['user_id']['delivery_window']['end_time'];
        double endTimeDouble = _parseTimeToDouble(endTime);
        bool upperGreaterThan = endTimeDouble < upperBoundDouble;
        upperBoundTime = upperGreaterThan ? endTime : upperBoundTime;
        lowerBoundDouble = upperGreaterThan ? endTimeDouble : upperBoundDouble;

        if (upperBoundTime == '') {
          upperBoundTime = endTime;
        }
      }
    }

    return 'Deliver between $lowerBoundTime - $upperBoundTime';
  }

  double _parseTimeToDouble(String time) {
    final stringList = time.split(":");
    final minuteAndMeridianList = stringList[1].split(' ');
    double hour = double.parse(stringList[0]);
    double minute = double.parse(minuteAndMeridianList[0]);
    final meridian = minuteAndMeridianList[1];

    if (meridian == 'PM') {
      hour += 12;
    }

    return hour + minute / 60;
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
          title: Text(_getStartAndEndLocations()),
        ),
        ListTile(
          dense: true,
          leading: Icon(
            Icons.alarm,
          ),
          title: Text(_getDeliveryRange()),
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
