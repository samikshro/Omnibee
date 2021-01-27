import 'dart:async';
import 'package:Henfam/bloc/blocs.dart';
import 'package:Henfam/entities/entities.dart';
import 'package:Henfam/models/models.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/minEarnings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Henfam/services/paymentService.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcceptOrder extends StatefulWidget {
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

  void _markOrdersAccepted(List<Order> orderList, User runner) async {
    orderList.forEach((order) {
      BlocProvider.of<OrderBloc>(context).add(OrderMarkAccepted(order, runner));
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
  void _isStripeSetup(List<Order> orderList, User user) async {
    if (user.stripeSetupComplete == true) {
      _markOrdersAccepted(orderList, user);
      final snackBar = SnackBar(
        content: Text('Accepted errand!'),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
      Timer(Duration(seconds: 2), () {
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      });
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              //TODO: try circular progress indicator
              Text('Setup a payment account to get paid after your delivery!'),
              Text('Please wait up to 10 seconds for the form to load.',
                  style: TextStyle(fontSize: 18)),
              CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: _setUpButtonChild(),
                  onPressed: () {
                    if (user != null) {
                      setState(() {
                        _loading = 1;
                      });

                      user.stripeAccountId == ""
                          ? _setupStripeAccount(user)
                          : _updateStripeAccount(user.stripeAccountId);
                    }
                    setState(() {
                      _loading = 0;
                    });
                  }),
            ],
          );
        },
      );
    }
  }

  void _setupStripeAccount(User user) {
    PaymentService.createAccount(user.email);
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
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      print("Building accept order again");
      return Scaffold(
          appBar: AppBar(
            title: Text("${order.restaurantName} Errand"),
          ),
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
                print("hello , at is stripe setup");
                // BlocProvider.of<AuthBloc>(context)
                //     .add(WasStripeSetupCompleted());
                print((state as Authenticated).user);
                
                Firestore.instance.collection('users')
                    .document((state as Authenticated).user.uid)
                    .get()
                    .then((DocumentSnapshot document) {
                  User user = User.fromEntity(UserEntity.fromSnapshot(document));
                  _isStripeSetup(orderList, user);
                });

                
                print("after isStripeSetup");
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              /* Stack(
                children: <Widget>[
                  CustomMap(orderList, selectedList),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: BackButton(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ), */
              // Padding(padding: const EdgeInsets.only(top: 50)),
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
    });
  }
}
