import 'package:Henfam/auth/widgets/circularProgress.dart';
import 'package:Henfam/auth/widgets/emailInput.dart';
import 'package:Henfam/auth/widgets/logo.dart';
import 'package:Henfam/auth/widgets/nameInput.dart';
import 'package:Henfam/auth/widgets/passwordInput.dart';
import 'package:Henfam/auth/widgets/primaryButton.dart';
import 'package:Henfam/auth/widgets/secondaryButton.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/auth/authentication.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  String _errorMessage = '';

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

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
        } else {
          userId = await widget.auth.signUp(_name, _email, _password);
          userId = await widget.auth.signIn(_email, _password);
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Error",
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Okay'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              );
            });
      }
    }
  }

  Widget _showForm() {
    return new Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            ShowLogo(_isLoading),
            ShowNameInput(_isLoginForm, saveName),
            ShowEmailInput(_isLoginForm, saveEmail),
            ShowPasswordInput(savePassword),
            ShowPrimaryButton(_isLoginForm, validateAndSubmit),
            ShowSecondaryButton(_isLoginForm, toggleFormMode),
            //ShowErrorMessage(_errorMessage),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Omnibee"),
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          ShowCircularProgress(_isLoading),
        ],
      ),
    );
  }
}
