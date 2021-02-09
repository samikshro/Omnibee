import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/widgets/infoButton.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:Henfam/widgets/mediumTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Following is for payments account setup. Will need to move to a different
// location after success
import 'package:url_launcher/url_launcher.dart';
import 'package:Henfam/services/paymentService.dart';

class Profile extends StatefulWidget {
  static void launchURL(String s) async {
    String url = s;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() async {
    try {
      BlocProvider.of<AuthBloc>(context).add(WasUnauthenticated());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
              ),
              ProfileHeader(state.user.name),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reimbursements: \$${state.user.reimbursement.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 19),
                    ),
                    InfoButton(
                      titleMessage: "Reimbursements",
                      bodyMessage:
                          "This is the total amount your account will be reimbursed for past deliveries. It includes the cost of food and your earnings.\n\nReimbursements will be paid out 2 days after the errand was completed.",
                      buttonMessage: "Okay",
                      buttonSize: 25,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Earnings: \$${state.user.earnings.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 19),
                    ),
                    InfoButton(
                      titleMessage: "Total Earnings",
                      bodyMessage:
                          "This is your total lifetime earnings on Omnibee. It is the sum of all earnings from previous deliveries.",
                      buttonMessage: "Okay",
                      buttonSize: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Divider(),
                    ProfileContact(signOut),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
