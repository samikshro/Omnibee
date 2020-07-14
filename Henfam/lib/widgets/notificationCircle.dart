import 'package:flutter/material.dart';

class NotificationCircle extends StatelessWidget {
  final int numNotifications;

  NotificationCircle(this.numNotifications);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          numNotifications.toString(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
