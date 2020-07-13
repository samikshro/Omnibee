import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigAcceptOrderInfo.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/bigDisplaySmallUsers.dart';
import 'package:Henfam/pages/explore/big_explore/bigAcceptOrder_widgets/expandedDecouple.dart';
import 'package:Henfam/pages/map/map.dart';
import 'package:flutter/material.dart';

class AcceptOrder extends StatefulWidget {
  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  final restaurant = {
    'name': 'Oishii Bowl',
    'location': [42.441947, -76.485066]
  };

  final requesters = [
    {
      'name': 'John',
      'image': Image(
        image: AssetImage('assets/beeperson@2x.png'),
      ),
      'selected': true,
      'item_cost': 11.23,
      'min_earnings': 2.50,
      'location': [42.447866, -76.484200],
    },
    {
      'name': 'Kristen',
      'image': Image(
        image: AssetImage('assets/beeperson@2x.png'),
      ),
      'selected': true,
      'item_cost': 15.23,
      'min_earnings': 3.20,
      'location': [42.444806, -76.482617],
    },
    {
      'name': 'Lisa',
      'image': Image(
        image: AssetImage('assets/beeperson@2x.png'),
      ),
      'selected': true,
      'item_cost': 9.23,
      'min_earnings': 2.59,
      'location': [42.444054, -76.485805],
    },
  ];
  var displayBigUsers = false;

  void _changeCheckBox(Map<String, Object> requester, bool modifiedVal) {
    setState(() {
      requester['selected'] = modifiedVal;
    });
  }

  void _onExpand(bool is_expanded) {
    setState(() {
      displayBigUsers = is_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          CustomMap(requesters, restaurant),
          ExpansionTile(
            title: Text('3 requests'),
            onExpansionChanged: _onExpand,
            trailing: Text(
              'DECOUPLE',
              style: TextStyle(color: Colors.cyan),
            ),
            children: <Widget>[
              ExpandedDecouple(requesters, _changeCheckBox),
            ],
          ),
          DisplaySmallUsers(displayBigUsers, requesters),
          AcceptOrderInfo(requesters),
        ],
      ),
    );
  }
}
