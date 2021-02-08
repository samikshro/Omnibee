import 'package:flutter/material.dart';

class ShowPhoneInput extends StatelessWidget {
  final isLoginForm;
  final Function savePhone;

  ShowPhoneInput(this.isLoginForm, this.savePhone);

  String phoneValidation(String value) {
    if (value.isEmpty) {
      return 'Phone can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoginForm) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10, 0.0, 0.0),
        child: new TextFormField(
          maxLines: 1,
          keyboardType: TextInputType.phone,
          autofocus: false,
          decoration: new InputDecoration(
            hintText: 'Phone number',
            icon: new Icon(
              Icons.phone,
            ),
          ),
          validator: (value) {
            return phoneValidation(value);
          },
          onSaved: (value) => savePhone(value),
        ),
      );
    } else {
      return Container();
    }
  }
}
