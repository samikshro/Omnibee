import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Following is for payments account setup. Will need to move to a different
// location after success
import 'package:url_launcher/url_launcher.dart';
import 'package:Henfam/services/paymentService.dart';

class Profile extends StatefulWidget {
  //final BaseAuth auth;

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
      //await widget.auth.signOut();
      BlocProvider.of<AuthBloc>(context).add(WasUnauthenticated());
    } catch (e) {
      print(e);
    }
  }

  // Future<double> _getBalance() {
  //   return _getStripeAccountID().then((val) async {
  //     double bal = 0;
  //     await (PaymentService.retrieveAccountBalance(accId)).then((response) {
  //       List<dynamic> z = response.data["pending"] as List<dynamic>;
  //       for (int i = 0; i < z.length; i++) {
  //         bal += z[i]["amount"];
  //       }
  //     });
  //     return bal / 100;
  //   });
  // }

  Future<double> _getBalance(String accId) async {
    double bal = 0;
    await PaymentService.retrieveAccountBalance(accId).then((response) {
      List<dynamic> z = response.data["pending"] as List<dynamic>;
      for (int i = 0; i < z.length; i++) {
        bal += z[i]["amount"];
      }
    });
    return bal / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Profile'),
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  FutureBuilder<double>(
                    future: _getBalance(state.user.stripeAccountId),
                    builder:
                        (BuildContext context, AsyncSnapshot<double> balance) {
                      if (!balance.hasData)
                        return Center(child: Text('Loading...'));
                      return LargeTextSection(
                        "Balance to be Transferred: \$" +
                            balance.data.toStringAsFixed(2),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        ProfileHeader(state.user.name),
                        Divider(),
                        ProfileContact(signOut),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
