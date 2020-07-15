import 'package:flutter/material.dart';

class IconNameRow extends StatelessWidget {
  List<Map<String, Object>> requesters;

  IconNameRow(this.requesters);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: requesters.map((requester) {
          if (requester['selected'] == true) {
            return TinyIconAndName(requester);
          }
          return Container();
        }).toList(),
      ),
    );
  }
}

class TinyIconAndName extends StatelessWidget {
  Map<String, Object> requester;

  TinyIconAndName(this.requester);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        requester['small_image'],
        Padding(
          padding: EdgeInsets.only(right: 5),
        ),
        Text(requester['name']),
        Padding(
          padding: EdgeInsets.only(right: 10),
        ),
      ],
    );
  }
}
