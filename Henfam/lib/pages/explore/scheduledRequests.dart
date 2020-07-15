import 'package:flutter/material.dart';

import 'package:Henfam/widgets/notificationCircle.dart';

class ScheduledRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(children: <Widget>[
              Container(
                child: Text(
                  'Scheduled Requests',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              NotificationCircle(2)
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  print("Hello!");
                },
                child:
                    Text("View".toUpperCase(), style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
