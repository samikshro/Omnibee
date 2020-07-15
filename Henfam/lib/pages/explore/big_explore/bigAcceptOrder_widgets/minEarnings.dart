import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MinEarnings extends StatelessWidget {
  List<DocumentSnapshot> requests;
  List<bool> selectedList;

  MinEarnings(this.requests, this.selectedList);

  String _getMinEarnings() {
    double minEarnings = 0;
    for (int i = 0; i < requests.length; i++) {
      if (selectedList[i] == true) {
        for (int j = 0; j < requests[i]['user_id']['basket'].length; j++) {
          minEarnings += requests[i]['user_id']['basket'][j]['price'] * .33;
        }
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
