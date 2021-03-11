import 'package:Omnibee/auth/widgets/circularProgress.dart';
import 'package:Omnibee/auth/widgets/emailInput.dart';
import 'package:Omnibee/auth/widgets/logo.dart';
import 'package:Omnibee/auth/widgets/nameInput.dart';
import 'package:Omnibee/auth/widgets/passwordInput.dart';
import 'package:Omnibee/auth/widgets/phoneInput.dart';
import 'package:Omnibee/auth/widgets/primaryButton.dart';
import 'package:Omnibee/auth/widgets/secondaryButton.dart';
import 'package:Omnibee/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginSignupPage extends StatefulWidget {
  //LoginSignupPage({this.auth});

  //final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  String _phone;

  bool _isLoginForm = true;
  bool _isLoading = false;

  bool validateAndSave() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    _isLoading = false;
    return false;
  }

  void saveName(String value) {
    _name = value.trim();
  }

  void saveEmail(String value) {
    _email = value.trim();
  }

  void savePassword(String value) {
    _password = value.trim();
  }

  void savePhone(String value) {
    _phone = value.trim();
  }

  void resetForm() {
    _formKey.currentState.reset();
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      if (_isLoginForm) {
        setState(() {
          _isLoading = true;
        });
        BlocProvider.of<AuthBloc>(context).add(SignedIn(_email, _password));
      } else {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            bool _hasAcceptedTermsAndCond = false;

            return StatefulBuilder(
              builder: (BuildContext context, setState) => Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: GestureDetector(
                          onTap: () => launch('https://omnibee.io/terms'),
                          child: Text(
                            'Please view the terms and conditions here.',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.lightBlue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CheckboxListTile(
                            title: Text(
                              'I agree to the terms and conditions.',
                            ),
                            value: _hasAcceptedTermsAndCond,
                            onChanged: (value) {
                              setState(() {
                                _hasAcceptedTermsAndCond = value;
                              });
                            }),
                      ),
                      Center(
                        child: CupertinoButton(
                          color: Theme.of(context).primaryColor,
                          child: Text("Continue"),
                          onPressed: !_hasAcceptedTermsAndCond
                              ? null
                              : () {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SignedUp(
                                      _name,
                                      _email,
                                      _password,
                                      _phone,
                                    ),
                                  );
                                  Navigator.pop(context);
                                },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ShowLogo(_isLoading),
            ShowNameInput(_isLoginForm, saveName),
            ShowEmailInput(_isLoginForm, saveEmail),
            ShowPhoneInput(_isLoginForm, savePhone),
            ShowPasswordInput(savePassword),
            ShowPrimaryButton(_isLoginForm, validateAndSubmit),
            ShowSecondaryButton(_isLoginForm, toggleFormMode),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Omnibee"),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            ShowCircularProgress(_isLoading),
          ],
        ),
      ),
      listener: (context, state) {
        setState(() {
          _isLoading = false;
        });
        if (state is ErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Error",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(AppStarted());
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
        }
      },
    );
  }
}
