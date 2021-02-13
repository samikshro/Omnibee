import 'package:flutter/material.dart';

class ShowSecondaryButton extends StatelessWidget {
  final isLoginForm;
  final Function toggleFormMode;

  ShowSecondaryButton(this.isLoginForm, this.toggleFormMode);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: new Text(
        isLoginForm ? 'Create an account' : 'Have an account? Sign in',
        style: new TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      onPressed: toggleFormMode,
    );
  }
}
