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
    setState(() {
      _isLoading = true;
    });
    if (validateAndSave()) {
      if (_isLoginForm) {
        BlocProvider.of<AuthBloc>(context).add(SignedIn(_email, _password));
      } else {
        BlocProvider.of<AuthBloc>(context)
            .add(SignedUp(_name, _email, _password, _phone));
      }
      /* setState(() {
          _isLoading = false;
        }); */
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
