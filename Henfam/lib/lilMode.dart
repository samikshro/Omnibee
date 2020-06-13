import 'package:flutter/material.dart';

import './helpcard.dart';
import './scheduledRequests.dart';
import './notificationCircle.dart';
import './currentOrder.dart';

class LilMode extends StatelessWidget {
  final List<Map<String, Object>> activities;

  LilMode(this.activities);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          CurrentOrder("Jessie", "7:30", "on the way"),
          ScheduledRequests(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Text(
              'What would you like help with, John?',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: HelpCard(),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
            child: Text(
              'Or choose from other errands nearby!',
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 60),
            child: ExpansionTile(
              title: Row(
                children: <Widget>[
                  Text('Other Errands'),
                  NotificationCircle(1),
                ],
              ),
              children: <Widget>[
                Text(
                  'Test',
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
