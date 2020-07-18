import 'package:flutter/material.dart';

class ShowEmailInput extends StatelessWidget {
  final isLoginForm;
  final Function saveEmail;

  ShowEmailInput(this.isLoginForm, this.saveEmail);

  String emailValidation(String value) {
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!isLoginForm) {
      return emailValidationSignup(value);
    }
    return null;
  }

  String emailValidationSignup(String value) {
    final start = value.indexOf('@');
    final isCornellEmail =
        !((start == -1) || (value.substring(start) != "@cornell.edu"));

    return isCornellEmail ? null : 'Not a valid Cornell email address';
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = (isLoginForm)
        ? const EdgeInsets.fromLTRB(0.0, 58.0, 0.0, 0.0)
        : const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0);

    return Padding(
      padding: topPadding,
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Email',
          icon: new Icon(
            Icons.mail,
          ),
        ),
        validator: (value) {
          return emailValidation(value);
        },
        onSaved: (value) => saveEmail(value),
      ),
    );
  }
}
