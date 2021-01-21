import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/landing.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/auth/login_signup_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatefulWidget {
  //RootPage({this.auth});

  //final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Uninitialized) {
        print("About to build waiting screen (auth state uninitialized)");
        return buildWaitingScreen();
      } else if (state is Unauthenticated || state is ErrorState) {
        return new LoginSignupPage();
      } else if (state is Authenticated) {
        print(state.user.name + " has logged in.");
        return new LandingPage();
      } else {
        print("About to build waiting screen (in else)");

        return buildWaitingScreen();
      }
    });
  }
}
