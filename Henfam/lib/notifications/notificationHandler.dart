import 'package:Henfam/auth/authentication.dart';
import 'package:flutter/material.dart';

import 'dart:async';
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

    _fcm.getToken().then((token) {
      print(token);
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
