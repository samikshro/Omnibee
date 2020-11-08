import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String netId;

  ProfileHeader(this.name, this.netId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
