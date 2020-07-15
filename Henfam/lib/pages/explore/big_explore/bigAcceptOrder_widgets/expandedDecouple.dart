import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpandedDecouple extends StatefulWidget {
  List<DocumentSnapshot> requests;
  List<bool> selectedList;
  Function changeCheckBox;

  ExpandedDecouple(this.requests, this.selectedList, this.changeCheckBox);
  @override
  _ExpandedDecoupleState createState() => _ExpandedDecoupleState();
}

class _ExpandedDecoupleState extends State<ExpandedDecouple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: 140,
        child: Row(
          children: widget.requests.map((request) {
            int requestIndex = widget.requests.indexOf(request);
            return ProfileCheckBoxColumn(
                request,
                widget.selectedList[requestIndex],
                requestIndex,
                widget.changeCheckBox);
          }).toList(),
        ),
      ),
    );
  }
}

class ProfileCheckBoxColumn extends StatelessWidget {
  DocumentSnapshot request;
  bool isSelected;
  int requestIndex;
  Function changeCheckBox;

  ProfileCheckBoxColumn(
    this.request,
    this.isSelected,
    this.requestIndex,
    this.changeCheckBox,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 65,
            width: 65,
            child: Image.asset('assets/beeperson@2x.png'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Text(request['user_id']['name']),
          Checkbox(
              value: isSelected,
              onChanged: (val) {
                changeCheckBox(requestIndex, val);
              })
        ],
      ),
    );
  }
}
