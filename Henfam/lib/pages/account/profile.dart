import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 45, 0),
              child: Image(
                image: AssetImage('assets/profilePic.png'),
              ),
            ),
            Text("Jessie Zhou", style: TextStyle(fontSize: 25)),
            Container(
              width: 180,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Edit Profile"),
              ),
            ),
            Container(
              width: 180,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Change Credit Card"),
              ),
            ),
            Container(
              width: 180,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Sign Out"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
