import 'package:Omnibee/models/order.dart';
import 'package:flutter/material.dart';

class MinEarnings extends StatelessWidget {
  final List<Order> orders;
  final List<bool> selectedList;

  MinEarnings(this.orders, this.selectedList);

  String _getMinEarnings() {
    double minEarnings = 0;
    for (int i = 0; i < orders.length; i++) {
      if (selectedList[i] == true) {
        minEarnings += orders[i].minEarnings;
      }
    }

    return minEarnings.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Minimum Earnings',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {},
              ),
            ],
          ),
          Text('\$${_getMinEarnings()}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ))
        ],
      ),
    );
  }
}
