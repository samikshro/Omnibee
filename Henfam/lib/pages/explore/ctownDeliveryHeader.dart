import 'package:flutter/material.dart';

import 'package:Henfam/widgets/location.dart';
import 'package:Henfam/widgets/clockicon.dart';

class CtownDeliveryHeader extends StatelessWidget {
  final String location;
  final String caption;

  CtownDeliveryHeader(this.location, this.caption);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            caption,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClockIcon(),
                Location(location),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
