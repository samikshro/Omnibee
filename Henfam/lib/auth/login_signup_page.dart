import 'package:Henfam/auth/widgets/circularProgress.dart';
import 'package:Henfam/auth/widgets/emailInput.dart';
import 'package:Henfam/auth/widgets/logo.dart';
import 'package:Henfam/auth/widgets/nameInput.dart';
import 'package:Henfam/auth/widgets/passwordInput.dart';
import 'package:Henfam/auth/widgets/phoneInput.dart';
import 'package:Henfam/auth/widgets/primaryButton.dart';
import 'package:Henfam/auth/widgets/secondaryButton.dart';
import 'package:Henfam/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void savePhone(String value) {
    _phone = value.trim();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

// TODO: potentially causing problem: "setting setState after dispose"
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
      try {
        if (_isLoginForm) {
          BlocProvider.of<AuthBloc>(context).add(SignedIn(_email, _password));
        } else {
          BlocProvider.of<AuthBloc>(context)
              .add(SignedUp(_name, _email, _password, _phone));
        }
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print("in catch statement");
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
            ShowPhoneInput(_isLoginForm, savePhone),
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
