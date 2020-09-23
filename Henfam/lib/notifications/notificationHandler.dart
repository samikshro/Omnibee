import 'package:Henfam/auth/authentication.dart';
import 'package:flutter/material.dart';

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationHandler extends StatefulWidget {
  NotificationHandler({this.child});

  final Widget child;

  @override
  _NotificationHandlerState createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  _saveDeviceToken() async {
    FirebaseUser user = await Auth().getCurrentUser();
    String fcmToken = await _fcm.getToken();

    if (fcmToken != null) {
      var userRef = _db.collection('users').document(user.uid);
      await userRef.setData({'token': fcmToken}, merge: true);
    }
  }

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      _fcm.onIosSettingsRegistered.listen((event) {
        _saveDeviceToken();
      });
      _fcm.requestNotificationPermissions(
        IosNotificationSettings(),
      );
    } else {
      _saveDeviceToken();
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: ListTile(
                  title: Text(message['notification']['title']),
                  subtitle: Text(message['notification']['body']),
                  // TODO: Uncomment out this code for testflight
                  /* title: Text(message['aps']['alert']['title']),
                  subtitle: Text(message['aps']['alert']['body']), */
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            });
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
