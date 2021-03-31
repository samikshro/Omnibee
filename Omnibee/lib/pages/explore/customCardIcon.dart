import 'package:Omnibee/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCardIcon extends StatelessWidget {
  final Order order;

  CustomCardIcon(this.order);

  @override
  Widget build(BuildContext context) {
    if (order.isReceived) {
      return Icon(Icons.check_circle, color: Colors.green, size: 45);
    } else if (order.isExpired()) {
      return Icon(Icons.cancel, color: Colors.red, size: 45);
    } else if (order.smallRestaurantImage != null) {
      return Image(
        image: AssetImage(order.smallRestaurantImage),
        fit: BoxFit.fill,
      );
    } else {
      return Icon(Icons.fastfood, size: 45);
    }
  }
}
