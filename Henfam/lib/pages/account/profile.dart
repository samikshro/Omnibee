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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 45, 0),
                  child: Image(
                    image: AssetImage('assets/profilePic.png'),
                  ),
                ),
                Text("Jessie Zhou", style: TextStyle(fontSize: 25)),
                Icon(Icons.edit),
              ],
            ),
            Container(
              height: 200,
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text('Previous orders'),
                  ),
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text('Change credit cards'),
                  ),
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text('Sign out'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
