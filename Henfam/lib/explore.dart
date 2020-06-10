import 'package:flutter/material.dart';

import './helpcard.dart';
import './scheduledRequests.dart';

class Explore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(title: Text('Explore'), backgroundColor: Colors.amber),
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
        Flexible(
          child: HelpCard(),
        ),
      ],
    );
  }
}
