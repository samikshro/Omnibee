import 'package:flutter/material.dart';

class ExpandedDecouple extends StatefulWidget {
  List<Map<String, Object>> requesters;
  Function changeCheckBox;

  ExpandedDecouple(this.requesters, this.changeCheckBox);
  @override
  _ExpandedDecoupleState createState() => _ExpandedDecoupleState();
}

class _ExpandedDecoupleState extends State<ExpandedDecouple> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: 160,
        child: Row(
          children: widget.requesters.map((requester) {
            return ProfileCheckBoxColumn(requester, widget.changeCheckBox);
          }).toList(),
        ),
      ),
    );
  }
}

class ProfileCheckBoxColumn extends StatelessWidget {
  Map<String, Object> requester;
  Function changeCheckBox;

  ProfileCheckBoxColumn(this.requester, this.changeCheckBox);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage('assets/beeperson@2x.png'),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
          ),
          Text(requester['name']),
          Checkbox(
              value: requester['selected'],
              onChanged: (val) {
                changeCheckBox(requester, val);
              })
        ],
      ),
    );
  }
}
