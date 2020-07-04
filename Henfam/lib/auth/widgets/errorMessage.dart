import 'package:flutter/material.dart';

class ShowErrorMessage extends StatelessWidget {
  final errorMessage;

  ShowErrorMessage(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    if (errorMessage.length > 0 && errorMessage != null) {
      return new Text(
        errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}
