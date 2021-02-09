import 'package:Henfam/models/models.dart';
import 'package:flutter/material.dart';

class DeliveryInstructions extends StatelessWidget {
  final Order order;
  final double boldFontSize;
  final double fontSize;

  DeliveryInstructions(this.order, this.fontSize, this.boldFontSize);

  @override
  Widget build(BuildContext context) {
    if (order.deliveryIns != "") {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Text(
              'Delivery Instructions:',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: boldFontSize),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 0, 10),
            child: Text(
              order.deliveryIns,
              style: TextStyle(fontSize: fontSize),
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }
}
