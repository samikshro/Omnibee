import 'package:flutter/material.dart';

class ScheduledRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.fromLTRB(20, 50, 10, 10),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Scheduled Requests',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: 25,
            height: 25,
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            decoration: new BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('2',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
