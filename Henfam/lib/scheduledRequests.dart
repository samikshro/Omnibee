import 'package:flutter/material.dart';

import './notificationCircle.dart';

class ScheduledRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Text(
              'Scheduled Requests',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          NotificationCircle(2),
          Container(
            margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.amber)),
              onPressed: () {},
              color: Colors.amber,
              textColor: Colors.white,
              child: Text("View".toUpperCase(), style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
