import 'package:flutter/material.dart';

class ShowNameInput extends StatelessWidget {
  final isLoginForm;
  final Function saveName;

  ShowNameInput(this.isLoginForm, this.saveName);

  String nameValidation(String value) {
    if (value.isEmpty) {
      return 'Email can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 0, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'First name',
            icon: new Icon(
              Icons.mail,
            ),
          ),
          validator: (value) {
            return nameValidation(value);
          },
          onSaved: (value) => saveName(value),
        ),
      );
    } else {
      return Container();
    }
  }
}
