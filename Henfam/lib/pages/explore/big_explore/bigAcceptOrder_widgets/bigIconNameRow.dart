import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IconNameRow extends StatelessWidget {
  List<DocumentSnapshot> requests;
  List<bool> selectedList;

  IconNameRow(this.requests, this.selectedList);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: requests.map((request) {
          if (selectedList[requests.indexOf(request)] == true) {
            return TinyIconAndName(request);
          }
          return Container();
        }).toList(),
      ),
    );
  }
}

class TinyIconAndName extends StatelessWidget {
  DocumentSnapshot request;

  TinyIconAndName(this.request);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset('assets/beeperson.png'),
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
        Text(request['user_id']['name']),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }
}
