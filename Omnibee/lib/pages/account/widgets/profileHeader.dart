import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;

  ProfileHeader(this.name);

  @override
  Widget build(BuildContext context) {
    print(name);
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Hello, $name",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
