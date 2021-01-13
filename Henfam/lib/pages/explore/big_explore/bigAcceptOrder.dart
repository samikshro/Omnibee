import 'dart:async';

import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/models/models.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/minEarnings.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/services/paymentService.dart';

// TODO: remove auth, extract payments
class AcceptOrder extends StatefulWidget {
  BaseAuth auth = new Auth();
  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  var isExpanded = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _loading = 0;
  var selectedList = [
    true,
  ];

  void _changeCheckBox(int index, bool modifiedVal) {
    setState(() {
      selectedList[index] = modifiedVal;
    });
  }

  void _onExpand(bool isExpanded) {
    setState(() {
      isExpanded = isExpanded;
    });
  }

  String _getNumRequests(List<Order> orderList) {
    int numRequests = 0;
    for (int i = 0; i < orderList.length; i++) {
      if (selectedList[i] == true) {
        numRequests += orderList[i].basket.length;
      }
    }

    return "${numRequests.toString()} items";
  }

  Future<String> _getUserName(String uid) async {
    Future<String> s = Firestore.instance
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot document) {
      return document['name'];
    });
    return s;
  }

  void _markOrdersAccepted(List<Order> orderList) async {
    final uid = await _getUserID();
    final firestore = Firestore.instance;
    final batch = firestore.batch();

    firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot delivererDoc) {
      for (int i = 0; i < orderList.length; i++) {
        final docId = orderList[i].docID;
        DocumentReference doc = firestore.collection('orders').document(docId);
        _getUserName(uid).then((name) {
          batch.updateData(doc, {
            'user_id.is_accepted': true,
            'user_id.runner': uid,
            'user_id.runner_name': name
          });

          batch.setData(
              doc, {'stripeAccountId': delivererDoc['stripeAccountId']},
              merge: true);

          batch.commit();
        });
      }
    });
  }

  Widget _setUpButtonChild() {
    if (_loading == 0) {
      return Text("Set Up Payments");
    } else if (_loading == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  /// [_isStripeSetup] checks if stripe setup has been approved and payouts have
  /// been enabled. If payouts are enabled, the order is accepted. If payouts
  /// are not enabled, the user is asked to setup a payment account.
  void _isStripeSetup(List<Order> orderList) async {
    final uid = await _getUserID();
    final firestore = Firestore.instance;

    firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot delivererDoc) {
      if (delivererDoc != null && delivererDoc['stripe_setup_complete']) {
        _markOrdersAccepted(orderList);
        final snackBar = SnackBar(
          content: Text('Accepted errand!'),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);
        Timer(Duration(seconds: 2), () {
          Navigator.popUntil(
              context, ModalRoute.withName(Navigator.defaultRouteName));
        });
      } else
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                //TODO: try circular progress indicator
                Text(
                    'Setup a payment account to get paid after your delivery!'),
                Text('Please wait up to 10 seconds for the form to load.',
                    style: TextStyle(fontSize: 18)),
                CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: _setUpButtonChild(), //Text("Set Up Payments"),
                    onPressed: () {
                      if (delivererDoc != null) {
                        setState(() {
                          _loading = 1;
                        });

                        delivererDoc['stripeAccountId'] == ""
                            ? _setupStripeAccount()
                            : _updateStripeAccount(
                                delivererDoc['stripeAccountId']);
                      }
                      setState(() {
                        _loading = 0;
                      });
                    }),
              ],
            );
          },
        );
    }).catchError((error, stackTrace) {
      return Future.error(error, stackTrace);
    });
  }

  Future<String> _getUserID() async {
    final result = await widget.auth.getCurrentUser();
    return result.uid;
  }

  Future<String> _getEmail(userId) async {
    final _firestore = Firestore.instance;
    final docSnapShot =
        await _firestore.collection('users').document(userId).get();
    return docSnapShot['email'];
  }

  void _setupStripeAccount() {
    _getUserID().then((uid) {
      _getEmail(uid).then((val) {
        PaymentService.createAccount(val);
      });
    });
  }

  void _updateStripeAccount(String accountId) {
    bool updateEnabled = false;
    if (updateEnabled)
      PaymentService.updateAccountLink(accountId);
    else
      PaymentService.createAccountLink(accountId);
  }

  @override
  Widget build(BuildContext context) {
    final Order order = ModalRoute.of(context).settings.arguments;
    final orderList = [
      order,
    ];
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            child: Text('Accept Errand',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).scaffoldBackgroundColor)),
            onPressed: () {
              _isStripeSetup(orderList); //, context);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CustomMap(orderList, selectedList),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: BackButton(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(_getNumRequests(orderList)),
              onExpansionChanged: _onExpand,
              trailing: Text(
                'DECOUPLE',
                style: TextStyle(color: Colors.cyan),
              ),
              children: <Widget>[
                ExpandedDecouple(orderList, selectedList, _changeCheckBox),
              ],
            ),
            DisplaySmallUsers(isExpanded, orderList, selectedList),
            MinEarnings(orderList, selectedList),
            AcceptOrderInfo(orderList, selectedList),
          ],
        )));
  }
}
