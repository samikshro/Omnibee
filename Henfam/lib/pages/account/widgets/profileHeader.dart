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
          Image(
            image: AssetImage('assets/profilePic.png'),
            height: 150,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(fontSize: 22),
                ),
                Text(
                  netId,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
