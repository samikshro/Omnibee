import 'package:flutter/material.dart';

class ShowPasswordInput extends StatelessWidget {
  final Function savePassword;

  ShowPasswordInput(this.savePassword);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
          hintText: 'Password',
          icon: new Icon(
            Icons.lock,
          ),
        ),
        validator: (value) {
          return value.isEmpty ? 'Password can\'t be empty' : null;
        },
        onSaved: (value) => savePassword(value),
      ),
    );
  }
}
