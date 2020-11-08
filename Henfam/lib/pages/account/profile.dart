import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/account/widgets/profileContact.dart';
import 'package:Henfam/pages/account/widgets/profileHeader.dart';
import 'package:Henfam/widgets/largeTextSection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Following is for payments account setup. Will need to move to a different
// location after success
import 'package:url_launcher/url_launcher.dart';
import 'package:Henfam/services/paymentService.dart';

class Profile extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  Profile(this.auth, this.logoutCallback, this.userId);

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
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Future<String> _getName() async {
    final _firestore = Firestore.instance;
    final docSnapShot =
        await _firestore.collection('users').document(widget.userId).get();
    return docSnapShot['name'];
  }

  Future<String> _getEmail() async {
    final _firestore = Firestore.instance;
    final docSnapShot =
        await _firestore.collection('users').document(widget.userId).get();
    return docSnapShot['email'];
  }

  Future<String> _getStripeAccountID() async {
    final _firestore = Firestore.instance;
    final docSnapShot =
        await _firestore.collection('users').document(widget.userId).get();
    return docSnapShot['stripeAccountId'];
  }

  void _setupStripeAccount() {
    print("setupStripeAccount");
    _getEmail().then((val) {
      PaymentService.createAccount(val);
    });
  }

  void _updateStripeAccount(String accountId) {
    print("updateStripeAccount");
    bool updateEnabled = false;
    if (updateEnabled)
      PaymentService.updateAccountLink(accountId);
    else
      PaymentService.createAccountLink(accountId);
  }

  /// [_stripeAccount] sets up a Stripe account or updates a Stripe account.
  /// If a user document's 'stripe_setup_complete' == false and
  /// 'stripeAccountId' == "", then setup. If 'stripe_setup_complete' == false
  /// and 'stripeAccountId' != "", then update. If 'stripe_setup_complete'
  /// == true, cleanly exit function.
  /* void _stripeAccount() {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance
          .collection('users')
          .document(user.uid)
          .get()
          .then((DocumentSnapshot doc) {
        if (doc != null) {
          if (doc['stripe_setup_complete'])
            print("Stripe Setup is Complete");
          else
            doc['stripeAccountId'] == ""
                ? _setupStripeAccount()
                : _updateStripeAccount(doc['stripeAccountId']);
        }
      });
    });
  }
 */
  Future<double> _getBalance() {
    return _getStripeAccountID().then((val) async {
      double bal = 0;
      await (PaymentService.retrieveAccountBalance(val)).then((response) {
        List<dynamic> z = response.data["pending"] as List<dynamic>;
        for (int i = 0; i < z.length; i++) {
          bal += z[i]["amount"];
        }
      });
      return bal / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
          ),
          FutureBuilder<double>(
            future: _getBalance(),
            builder: (BuildContext context, AsyncSnapshot<double> balance) {
              if (!balance.hasData) return Center(child: Text('Loading...'));
              return LargeTextSection(
                "Balance to be Transferred: \$" +
                    balance.data.toStringAsFixed(2),
              );
            },
          ),
          Expanded(
            child: FutureBuilder<String>(
              future:
                  _getName(), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (!snapshot.hasData) return Center(child: Text('Loading...'));
                return ListView(
                  children: <Widget>[
                    ProfileHeader(snapshot.data, 'gmm22'),
                    Divider(),
                    ProfileContact(signOut),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
    // ));
  }
}
