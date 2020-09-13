import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/minEarnings.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/services/paymentService.dart';

class AcceptOrder extends StatefulWidget {
  BaseAuth auth = new Auth();
  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  var isExpanded = false;
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

  String _getNumRequests(List<DocumentSnapshot> docList) {
    int numRequests = 0;
    for (int i = 0; i < docList.length; i++) {
      if (selectedList[i] == true) {
        numRequests += docList[i]['user_id']['basket'].length;
      }
    }

    return "${numRequests.toString()} items";
  }

  void _markOrdersAccepted(List<DocumentSnapshot> docList) async {
    final uid = await _getUserID();
    final firestore = Firestore.instance;
    final batch = firestore.batch();

    firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot delivererDoc) {
      for (int i = 0; i < docList.length; i++) {
        final docId = docList[i].documentID;
        DocumentReference doc = firestore.collection('orders').document(docId);
        batch.updateData(
            doc, {'user_id.is_accepted': true, 'user_id.runner': uid});

        batch.setData(doc, {'stripeAccountId': delivererDoc['stripeAccountId']},
            merge: true);
      }

      batch.commit();
    });
  }

  /// [_isStripeSetup] checks if stripe setup has been approved and payouts have
  /// been enabled. If payouts are enabled, the order is accepted. If payouts
  /// are not enabled, the user is asked to setup a payment account.
  void _isStripeSetup(List<DocumentSnapshot> docList) async {
    final uid = await _getUserID();
    final firestore = Firestore.instance;

    firestore
        .collection('users')
        .document(uid)
        .get()
        .then((DocumentSnapshot delivererDoc) {
      if (delivererDoc != null && delivererDoc['stripe_setup_complete']) {
        // delivererDoc['stripeAccountId'] != null) {
        _markOrdersAccepted(docList);
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      } else
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Column(
              children: [
                Text(
                    'Please setup a payment account to get paid after your delivery!'),
                CupertinoButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Setup Payments"),
                    onPressed: () {
                      if (delivererDoc != null) {
                        delivererDoc['stripeAccountId'] == ""
                            ? _setupStripeAccount()
                            : _updateStripeAccount(
                                delivererDoc['stripeAccountId']);
                        // _setupStripeAccount();
                      }
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
    print("setupStripeAccount");
    _getUserID().then((uid) {
      _getEmail(uid).then((val) {
        PaymentService.createAccount(val);
      });
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

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    final docList = [
      document,
    ];
    return Scaffold(
        bottomNavigationBar: SizedBox(
          width: double.infinity,
          height: 60,
          child: RaisedButton(
            child: Text('Run Errand',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Theme.of(context).scaffoldBackgroundColor)),
            onPressed: () {
              _isStripeSetup(docList);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CustomMap(docList, selectedList),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: BackButton(
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Text(_getNumRequests(docList)),
              onExpansionChanged: _onExpand,
              trailing: Text(
                'DECOUPLE',
                style: TextStyle(color: Colors.cyan),
              ),
              children: <Widget>[
                ExpandedDecouple(docList, selectedList, _changeCheckBox),
              ],
            ),
            DisplaySmallUsers(isExpanded, docList, selectedList),
            MinEarnings(docList, selectedList),
            AcceptOrderInfo(docList, selectedList),
          ],
        )));
  }
}
