import 'package:flutter/material.dart';

class ClockIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.access_time),
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: Text("ASAP"),
          )
        ],
      ),
    );
  }
}
