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
                Firestore.instance
                    .collection('users')
                    .document((state as Authenticated).user.uid)
                    .get()
                    .then((DocumentSnapshot document) {
                  User user =
                      User.fromEntity(UserEntity.fromSnapshot(document));
                  _markOrdersAccepted(orderList, user);
                });
              },
            ),
          ),
          body: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 50)),
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
