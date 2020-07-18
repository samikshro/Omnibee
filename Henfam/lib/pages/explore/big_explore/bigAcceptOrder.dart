import 'package:Henfam/auth/authentication.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/minEarnings.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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

  void _onExpand(bool is_expanded) {
    setState(() {
      isExpanded = is_expanded;
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

    for (int i = 0; i < docList.length; i++) {
      final docId = docList[i].documentID;
      DocumentReference doc = firestore.collection('orders').document(docId);
      batch.updateData(
          doc, {'user_id.is_accepted': true, 'user_id.runner': uid});
    }

    batch.commit();
  }

  Future<String> _getUserID() async {
    final result = await widget.auth.getCurrentUser();
    return result.uid;
  }

  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    final docList = [
      document,
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(
                    width: double.infinity,
                    height: 750,
                    child: Column(
                      children: <Widget>[
                        CustomMap(docList, selectedList),
                        ExpansionTile(
                          title: Text(_getNumRequests(docList)),
                          onExpansionChanged: _onExpand,
                          trailing: Text(
                            'DECOUPLE',
                            style: TextStyle(color: Colors.cyan),
                          ),
                          children: <Widget>[
                            ExpandedDecouple(
                                docList, selectedList, _changeCheckBox),
                          ],
                        ),
                        DisplaySmallUsers(isExpanded, docList, selectedList),
                        MinEarnings(docList, selectedList),
                        AcceptOrderInfo(docList, selectedList),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              fillOverscroll: true,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                      child: Text('Confirm', style: TextStyle(fontSize: 20.0)),
                      onPressed: () {
                        _markOrdersAccepted(docList);
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
