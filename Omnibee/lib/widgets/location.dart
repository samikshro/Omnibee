import 'package:flutter/material.dart';

class Location extends StatelessWidget {
  final String location;

  Location(this.location);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Image(
        image: AssetImage('assets/location_pin.png'),
      ),
      Padding(padding: EdgeInsets.only(left: 5)),
      Text(
        location,
        style: TextStyle(fontSize: 12),
      )
    ]);
  }
}
