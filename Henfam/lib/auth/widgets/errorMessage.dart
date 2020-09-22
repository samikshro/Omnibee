import 'package:flutter/material.dart';

class ShowErrorMessage extends StatelessWidget {
  final errorMessage;

  ShowErrorMessage(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    if (errorMessage.length > 0 && errorMessage != null) {
      return AlertDialog(
        title: Text(
          "Error",
          style: TextStyle(color: Colors.black),
        ),
        content: Text(
          errorMessage,
          style: TextStyle(color: Colors.red),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
