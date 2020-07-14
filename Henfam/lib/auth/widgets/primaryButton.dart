import 'package:flutter/material.dart';

class ShowPrimaryButton extends StatelessWidget {
  final isLoginForm;
  final Function validateAndSubmit;

  ShowPrimaryButton(this.isLoginForm, this.validateAndSubmit);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
      child: SizedBox(
        height: 40.0,
        child: new RaisedButton(
          elevation: 5.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          child: new Text(isLoginForm ? 'Login' : 'Create account',
              style: new TextStyle(
                fontSize: 20.0,
              )),
          onPressed: validateAndSubmit,
        ),
      ),
    );
  }
}
